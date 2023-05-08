using Microsoft.EntityFrameworkCore;
using ORB.Core;
using ORB.Core.Models;
using ORB.Core.Services;
using ORB.Services.Validations;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Threading.Tasks;

namespace ORB.Services
{
    public class ProjectService : ReportingEntityService<Project>, IProjectService
    {
        private readonly IEntityService<UserProject> _userProjectService;
        private byte? _reportingFrequencyBeforePatch;
        private byte? _reportingDueDayBeforePatch;
        private DateTime? _reportingStartDateBeforePatch;
        private DateTime _nextReportDueBeforePatch;

        public ProjectService(IUnitOfWork unitOfWork, IEntityService<UserProject> userProjectService) : base(unitOfWork, unitOfWork.Projects, new ProjectValidator(unitOfWork))
        {
            _userProjectService = userProjectService;
        }

        protected async override Task AfterAdd(Project entity)
        {
            await base.AfterAdd(entity);

            var userIds = new HashSet<int>();

            if (entity.SeniorResponsibleOwnerUserID != null)
            {
                userIds.Add((int)entity.SeniorResponsibleOwnerUserID);
            }
            if (entity.ReportApproverUserID != null)
            {
                userIds.Add((int)entity.ReportApproverUserID);
            }
            if (entity.ProjectManagerUserID != null)
            {
                userIds.Add((int)entity.ProjectManagerUserID);
            }
            if (entity.ReportingLeadUserID != null)
            {
                userIds.Add((int)entity.ReportingLeadUserID);
            }

            foreach (var userId in userIds)
            {
                await _userProjectService.Add(new UserProject
                {
                    UserID = userId,
                    ProjectID = entity.ID
                });
            }
        }

        protected override void BeforePatch(Project entity)
        {
            base.BeforePatch(entity);

            _reportingFrequencyBeforePatch = entity.ReportingFrequency;
            _reportingDueDayBeforePatch = entity.ReportingDueDay;
            _reportingStartDateBeforePatch = entity.ReportingStartDate;
            _nextReportDueBeforePatch = ReportingCycleService.NextReportDue(entity, DateTime.UtcNow);
        }

        protected override void AfterPatch(Project project)
        {
            base.AfterPatch(project);

            if (_reportingFrequencyBeforePatch != project.ReportingFrequency
                || _reportingDueDayBeforePatch != project.ReportingDueDay
                || _reportingStartDateBeforePatch != project.ReportingStartDate)
            {
                CopyReportingCycleToChildren(project);
            }
        }

        protected override void BeforeClose(Project entity)
        {
            base.BeforeClose(entity);

            CloseProjectChildren(entity, DateTime.UtcNow);
        }

        protected override void BeforeRemove(Project project)
        {
            _unitOfWork.Attributes.RemoveRange(_unitOfWork.Attributes.Entities.Where(a => a.ProjectID == project.ID));
            _unitOfWork.UserProjects.RemoveRange(_unitOfWork.UserProjects.Entities.Where(up => up.ProjectID == project.ID));
        }

        private void CopyReportingCycleToChildren(Project project)
        {
            var newNextReportDueDate = ReportingCycleService.NextReportDue(project, DateTime.UtcNow);

            // Don't copy to benefits, they define their own reporting cycle

            foreach (var dependency in _unitOfWork.Dependencies.Entities.Where(c => c.ProjectID == project.ID))
            {
                ReportingCycleService.CopyReportingCycle(project, dependency);

                foreach (var update in _unitOfWork.DependencyUpdates.Entities.Where(u => u.DependencyID == dependency.ID && u.UpdatePeriod == _nextReportDueBeforePatch && u.SignOffID == null))
                {
                    update.UpdatePeriod = newNextReportDueDate;
                }
            }

            foreach (var workStream in _unitOfWork.WorkStreams.Entities.Where(k => k.ProjectID == project.ID))
            {
                ReportingCycleService.CopyReportingCycle(project, workStream);

                foreach (var update in _unitOfWork.WorkStreamUpdates.Entities.Where(u => u.WorkStreamID == workStream.ID && u.UpdatePeriod == _nextReportDueBeforePatch && u.SignOffID == null))
                {
                    update.UpdatePeriod = newNextReportDueDate;
                }

                foreach (var milestone in _unitOfWork.Milestones.Entities.Where(m => m.WorkStreamID == workStream.ID))
                {
                    ReportingCycleService.CopyReportingCycle(project, milestone);

                    foreach (var update in _unitOfWork.MilestoneUpdates.Entities.Where(u => u.MilestoneID == milestone.ID && u.UpdatePeriod == _nextReportDueBeforePatch && u.SignOffID == null))
                    {
                        update.UpdatePeriod = newNextReportDueDate;
                    }
                }
            }

            foreach (var risk in _unitOfWork.CorporateRisks.Entities.Where(r => r.IsProjectRisk == true && r.ProjectID == project.ID))
            {
                ReportingCycleService.CopyReportingCycle(project, risk);

                foreach (var update in _unitOfWork.CorporateRiskUpdates.Entities.Where(u => u.RiskID == risk.ID && u.UpdatePeriod == _nextReportDueBeforePatch && u.SignOffID == null))
                {
                    update.UpdatePeriod = newNextReportDueDate;
                }

                foreach (var riskMitigationAction in _unitOfWork.CorporateRiskMitigationActions.Entities.Where(a => a.RiskID == risk.ID))
                {
                    ReportingCycleService.CopyReportingCycle(project, riskMitigationAction);

                    foreach (var update in _unitOfWork.CorporateRiskMitigationActionUpdates.Entities.Where(u => u.RiskMitigationActionID == riskMitigationAction.ID && u.UpdatePeriod == _nextReportDueBeforePatch && u.SignOffID == null))
                    {
                        update.UpdatePeriod = newNextReportDueDate;
                    }
                }
            }

            foreach (var entity in _unitOfWork.ReportingEntities.Entities.Where(e => e.ProjectID == project.ID))
            {
                ReportingCycleService.CopyReportingCycle(project, entity);

                foreach (var update in _unitOfWork.ReportingEntityUpdates.Entities.Where(u => u.ReportingEntityID == entity.ID && u.UpdatePeriod == _nextReportDueBeforePatch && u.SignOffID == null))
                {
                    update.UpdatePeriod = newNextReportDueDate;
                }
            }
        }

        private void CloseProjectChildren(Project project, DateTime now)
        {
            foreach (var workstream in _unitOfWork.WorkStreams.Entities.Where(w => w.ProjectID == project.ID && w.EntityStatusID == (int)EntityStatuses.Open))
            {
                CloseEntityWithStatus(workstream, now);

                foreach (var milestone in _unitOfWork.Milestones.Entities.Where(m => m.WorkStreamID == workstream.ID && m.EntityStatusID == (int)EntityStatuses.Open))
                {
                    CloseEntityWithStatus(milestone, now);
                }
            }

            foreach (var benefit in _unitOfWork.Benefits.Entities.Where(b => b.ProjectID == project.ID && b.EntityStatusID == (int)EntityStatuses.Open))
            {
                CloseEntityWithStatus(benefit, now);
            }

            foreach (var dependency in _unitOfWork.Dependencies.Entities.Where(d => d.ProjectID == project.ID && d.EntityStatusID == (int)EntityStatuses.Open))
            {
                CloseEntityWithStatus(dependency, now);
            }

            foreach (var risk in _unitOfWork.CorporateRisks.Entities.Where(r => r.ProjectID == project.ID && r.EntityStatusID == (int)EntityStatuses.Open))
            {
                CloseEntityWithStatus(risk, now);

                foreach (var riskMitigationAction in _unitOfWork.CorporateRiskMitigationActions.Entities.Where(a => a.RiskID == risk.ID && a.EntityStatusID == (int)EntityStatuses.Open))
                {
                    CloseEntityWithStatus(riskMitigationAction, now);
                }
            }

            foreach (var entity in _unitOfWork.ReportingEntities.Entities.Where(e => e.ProjectID == project.ID && e.EntityStatusID == (int)EntityStatuses.Open))
            {
                CloseEntityWithStatus(entity, now);
            }

            foreach (var subProject in _unitOfWork.Projects.Entities.Where(m => m.ParentProjectID == project.ID && m.EntityStatusID == (int)EntityStatuses.Open))
            {
                CloseEntityWithStatus(subProject, now);
                CloseProjectChildren(subProject, now);
            }
        }

        public ICollection<Project> ProjectsDueInDirectoratePeriod(int directorateId, Period period)
        {
            var directorate = _unitOfWork.Directorates.Find(directorateId);
            if (directorate != null)
            {
                var dates = ReportingCycleService.ReportPeriodDates(directorate, DateTime.UtcNow, period);

                return _repository.Entities
                    .Include(p => p.SeniorResponsibleOwnerUser)
                    .Include(p => p.Attributes).ThenInclude(a => a.AttributeType)
                    .Where(p => p.DirectorateID == directorateId && p.ShowOnDirectorateReport == true && p.EntityStatusID == (int)EntityStatuses.Open)
                    .Where(p => ReportingCycleService.NextReportDue(p, dates.Start) <= dates.End).ToList();
            }
            return new Collection<Project>();
        }

        public ICollection<Project> ProjectsDueInDirectoratePeriod(int directorateId, DateTime fromDate, DateTime toDate)
        {
            var directorate = _unitOfWork.Directorates.Find(directorateId);
            if (directorate != null)
            {
                return _repository.Entities
                    .Where(p => p.DirectorateID == directorateId && p.EntityStatusID == (int)EntityStatuses.Open)
                    .Where(p => ReportingCycleService.NextReportDue(p, fromDate) <= toDate).ToList();
            }
            return new Collection<Project>();
        }
    }
}
