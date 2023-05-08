using Microsoft.AspNet.OData;
using Microsoft.EntityFrameworkCore;
using ORB.Core;
using ORB.Core.Models;
using ORB.Core.Services;
using ORB.Services.Validations;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ORB.Services
{
    public class DirectorateService : ReportingEntityService<Directorate>, IReportingEntityService<Directorate>
    {
        private byte? _reportingFrequencyBeforePatch;
        private byte? _reportingDueDayBeforePatch;
        private DateTime? _reportingStartDateBeforePatch;
        private DateTime _nextReportDueBeforePatch;

        public DirectorateService(IUnitOfWork unitOfWork) : base(unitOfWork, unitOfWork.Directorates, new DirectorateValidator(unitOfWork)) { }

        protected override void BeforePatch(Directorate entity)
        {
            base.BeforePatch(entity);

            _reportingFrequencyBeforePatch = entity.ReportingFrequency;
            _reportingDueDayBeforePatch = entity.ReportingDueDay;
            _reportingStartDateBeforePatch = entity.ReportingStartDate;
            _nextReportDueBeforePatch = ReportingCycleService.NextReportDue(entity, DateTime.UtcNow);
        }

        protected override void AfterPatch(Directorate directorate)
        {
            base.AfterPatch(directorate);

            if (_reportingFrequencyBeforePatch != directorate.ReportingFrequency
                || _reportingDueDayBeforePatch != directorate.ReportingDueDay
                || _reportingStartDateBeforePatch != directorate.ReportingStartDate)
            {
                CopyReportingCycleToChildren(directorate);
            }
        }

        protected override void BeforeRemove(Directorate directorate)
        {
            _unitOfWork.Attributes.RemoveRange(_unitOfWork.Attributes.Entities.Where(a => a.DirectorateID == directorate.ID));
        }

        protected override void BeforeClose(Directorate directorate)
        {
            CloseDirectorateEntities(directorate, DateTime.UtcNow);
        }

        private void CopyReportingCycleToChildren(Directorate directorate)
        {
            var newNextReportDueDate = ReportingCycleService.NextReportDue(directorate, DateTime.UtcNow);

            foreach (var commitment in _unitOfWork.Commitments.Entities.Where(c => c.DirectorateID == directorate.ID))
            {
                ReportingCycleService.CopyReportingCycle(directorate, commitment);

                foreach (var update in _unitOfWork.CommitmentUpdates.Entities.Where(u => u.CommitmentID == commitment.ID && u.UpdatePeriod == _nextReportDueBeforePatch && u.SignOffID == null))
                {
                    update.UpdatePeriod = newNextReportDueDate;
                }
            }

            foreach (var keyWorkArea in _unitOfWork.KeyWorkAreas.Entities.Where(k => k.DirectorateID == directorate.ID))
            {
                ReportingCycleService.CopyReportingCycle(directorate, keyWorkArea);

                foreach (var update in _unitOfWork.KeyWorkAreaUpdates.Entities.Where(u => u.KeyWorkAreaID == keyWorkArea.ID && u.UpdatePeriod == _nextReportDueBeforePatch && u.SignOffID == null))
                {
                    update.UpdatePeriod = newNextReportDueDate;
                }

                foreach (var milestone in _unitOfWork.Milestones.Entities.Where(m => m.KeyWorkAreaID == keyWorkArea.ID))
                {
                    ReportingCycleService.CopyReportingCycle(directorate, milestone);

                    foreach (var update in _unitOfWork.MilestoneUpdates.Entities.Where(u => u.MilestoneID == keyWorkArea.ID && u.UpdatePeriod == _nextReportDueBeforePatch && u.SignOffID == null))
                    {
                        update.UpdatePeriod = newNextReportDueDate;
                    }
                }
            }

            // Don't copy to metrics, they define their own reporting cycle

            foreach (var risk in _unitOfWork.CorporateRisks.Entities.Where(r => r.DirectorateID == directorate.ID && r.IsProjectRisk != true))
            {
                ReportingCycleService.CopyReportingCycle(directorate, risk);

                foreach (var update in _unitOfWork.CorporateRiskUpdates.Entities.Where(u => u.RiskID == risk.ID && u.UpdatePeriod == _nextReportDueBeforePatch && u.SignOffID == null))
                {
                    update.UpdatePeriod = newNextReportDueDate;
                }

                foreach (var riskMitigationAction in _unitOfWork.CorporateRiskMitigationActions.Entities.Where(a => a.RiskID == risk.ID))
                {
                    ReportingCycleService.CopyReportingCycle(directorate, riskMitigationAction);

                    foreach (var update in _unitOfWork.CorporateRiskMitigationActionUpdates.Entities.Where(u => u.RiskMitigationActionID == riskMitigationAction.ID && u.UpdatePeriod == _nextReportDueBeforePatch && u.SignOffID == null))
                    {
                        update.UpdatePeriod = newNextReportDueDate;
                    }
                }
            }

            foreach (var entity in _unitOfWork.ReportingEntities.Entities.Where(e => e.DirectorateID == directorate.ID))
            {
                ReportingCycleService.CopyReportingCycle(directorate, entity);

                foreach (var update in _unitOfWork.ReportingEntityUpdates.Entities.Where(u => u.ReportingEntityID == entity.ID && u.UpdatePeriod == _nextReportDueBeforePatch && u.SignOffID == null))
                {
                    update.UpdatePeriod = newNextReportDueDate;
                }
            }
        }

        private void CloseDirectorateEntities(Directorate directorate, DateTime closedDate)
        {
            foreach (var commitment in _unitOfWork.Commitments.Entities.Where(c => c.DirectorateID == directorate.ID && c.EntityStatusID == (int)EntityStatuses.Open))
            {
                CloseEntityWithStatus(commitment, closedDate);
            }

            foreach (var keyWorkArea in _unitOfWork.KeyWorkAreas.Entities.Where(k => k.DirectorateID == directorate.ID && k.EntityStatusID == (int)EntityStatuses.Open))
            {
                CloseEntityWithStatus(keyWorkArea, closedDate);

                foreach (var milestone in _unitOfWork.Milestones.Entities.Where(m => m.KeyWorkAreaID == keyWorkArea.ID && m.EntityStatusID == (int)EntityStatuses.Open))
                {
                    CloseEntityWithStatus(milestone, closedDate);
                }
            }

            foreach (var metric in _unitOfWork.Metrics.Entities.Where(m => m.DirectorateID == directorate.ID && m.EntityStatusID == (int)EntityStatuses.Open))
            {
                CloseEntityWithStatus(metric, closedDate);
            }

            foreach (var risk in _unitOfWork.CorporateRisks.Entities.Where(r => r.DirectorateID == directorate.ID && r.EntityStatusID == (int)EntityStatuses.Open))
            {
                CloseEntityWithStatus(risk, closedDate);

                foreach (var riskMitigationAction in _unitOfWork.CorporateRiskMitigationActions.Entities.Where(a => a.RiskID == risk.ID && a.EntityStatusID == (int)EntityStatuses.Open))
                {
                    CloseEntityWithStatus(riskMitigationAction, closedDate);
                }
            }

            foreach (var entity in _unitOfWork.ReportingEntities.Entities.Where(e => e.DirectorateID == directorate.ID && e.EntityStatusID == (int)EntityStatuses.Open))
            {
                CloseEntityWithStatus(entity, closedDate);
            }
        }
    }
}
