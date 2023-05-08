using AutoMapper;
using Microsoft.AspNet.OData;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using ORB.Core;
using ORB.Core.Models;
using ORB.Core.Repositories;
using ORB.Core.Services;
using ORB.Core.ReportViewModels;
using ORB.Services.Validations;
using System;
using System.Linq;
using System.Text.Json;
using System.Threading.Tasks;

namespace ORB.Services
{
    public class SignOffService : ISignOffService
    {
        protected readonly IUnitOfWork _unitOfWork;
        protected readonly ISignOffRepository _repository;
        protected readonly ILogger<SignOffService> _logger;
        protected readonly IMapper _mapper;
        protected readonly IReportBuilderService _reportBuilderService;

        public SignOffService(IUnitOfWork unitOfWork, ILogger<SignOffService> logger, IMapper mapper, IReportBuilderService reportBuilderService)
        {
            _unitOfWork = unitOfWork;
            _repository = unitOfWork.SignOffs;
            _logger = logger;
            _mapper = mapper;
            _reportBuilderService = reportBuilderService;
        }

        public IQueryable<SignOff> Entities
        {
            get
            {
                return _repository.Entities;
            }
        }

        public IQueryable<SignOff> Find(int id)
        {
            return _repository.Entities.Where(e => e.ID == id);
        }

        public virtual async Task<SignOff> Add(SignOff signOff)
        {
            signOff.SignOffDate = DateTime.UtcNow;
            signOff.SignOffUserID = _repository.ApiUser.ID;
            signOff.IsCurrent = true;

            var addedEntity = _repository.Add(signOff);
            if (addedEntity == null)
            {
                return null;
            }

            await SetSignedOffData(signOff);
            await _unitOfWork.SaveChanges();
            return addedEntity;
        }

        private static void ChangeEntityStatus(EntityWithStatus entity, EntityStatuses status, DateTime date)
        {
            entity.EntityStatusID = (int)status;
            entity.EntityStatusDate = date;
        }

        private async Task SetSignedOffData(SignOff signOff)
        {
            if (signOff.DirectorateID != null)
            {
                await SignOffDirectorateReport(signOff);
            }

            if (signOff.ProjectID != null)
            {
                await SignOffProjectReport(signOff);
            }

            if (signOff.PartnerOrganisationID != null)
            {
                await SignOffPartnerOrganisationReport(signOff);
            }

            if (signOff.RiskID != null)
            {
                var risk = _unitOfWork.CorporateRisks.Entities.SingleOrDefault(r => r.ID == signOff.RiskID);
                var financialRisk = _unitOfWork.FinancialRisks.Entities.SingleOrDefault(r => r.ID == signOff.RiskID);
                if (risk != null)
                {
                    await SignOffRiskReport(signOff);
                }
                else if (financialRisk != null)
                {
                    await SignOffFinancialRiskReport(signOff);
                }
            }
        }

        private async Task SignOffDirectorateReport(SignOff signOff)
        {
            var now = DateTime.UtcNow;
            var report = JsonSerializer.Deserialize<SignOffDirectorateViewModel>(signOff.ReportJson);

            foreach (var update in report.Directorate.DirectorateUpdates)
            {
                // Update IsCurrent flag for previous sign-offs
                var previousSignOffs = _repository.Entities.Where(so => so.IsCurrent == true && so.ReportMonth == signOff.ReportMonth && so.DirectorateID == signOff.DirectorateID);
                foreach (var pso in previousSignOffs) pso.IsCurrent = false;

                var du = _unitOfWork.DirectorateUpdates.Find(update.ID);
                if (du != null) du.SignOff = signOff;
            }

            foreach (var commitment in report.Commitments)
            {
                foreach (var update in commitment.CommitmentUpdates)
                {
                    var cu = _unitOfWork.CommitmentUpdates.Find(update.ID);
                    if (cu != null)
                    {
                        cu.SignOff = signOff;
                        var c = await _unitOfWork.Commitments.Edit(cu.CommitmentID);
                        if (c != null)
                        {
                            c.RagOptionID = cu.RagOptionID;
                            c.ForecastDate = cu.ForecastDate;
                            c.ActualDate = cu.ActualDate;
                            if (cu.ToBeClosed == true)
                            {
                                ChangeEntityStatus(c, EntityStatuses.Closed, now);
                            }
                            else if (c.EntityStatusID == (int)EntityStatuses.Closed) // Can only provide an update for an open or recently closed item, so must be re-opening
                            {
                                ChangeEntityStatus(c, EntityStatuses.Open, now);
                            }
                        }
                    }
                }
            }

            foreach (var keyWorkArea in report.KeyWorkAreas)
            {
                foreach (var update in keyWorkArea.KeyWorkAreaUpdates)
                {
                    var kwau = _unitOfWork.KeyWorkAreaUpdates.Find(update.ID);
                    if (kwau != null)
                    {
                        kwau.SignOff = signOff;
                        var kwa = await _unitOfWork.KeyWorkAreas.Edit(kwau.KeyWorkAreaID);
                        if (kwa != null)
                        {
                            kwa.RagOptionID = kwau.RagOptionID;
                            if (kwau.ToBeClosed == true)
                            {
                                ChangeEntityStatus(kwa, EntityStatuses.Closed, now);
                            }
                            else if (kwa.EntityStatusID == (int)EntityStatuses.Closed)
                            {
                                ChangeEntityStatus(kwa, EntityStatuses.Open, now);
                            }
                        }
                    }
                }
            }

            foreach (var metric in report.Metrics)
            {
                foreach (var update in metric.MetricUpdates)
                {
                    var mu = _unitOfWork.MetricUpdates.Find(update.ID);
                    if (mu != null)
                    {
                        mu.SignOff = signOff;
                        var m = await _unitOfWork.Metrics.Edit(mu.MetricID);
                        if (m != null)
                        {
                            m.RagOptionID = mu.RagOptionID;
                            if (mu.ToBeClosed == true)
                            {
                                ChangeEntityStatus(m, EntityStatuses.Closed, now);
                            }
                            else if (m.EntityStatusID == (int)EntityStatuses.Closed)
                            {
                                ChangeEntityStatus(m, EntityStatuses.Open, now);
                            }
                        }
                    }
                }
            }

            foreach (var milestone in report.Milestones)
            {
                foreach (var update in milestone.MilestoneUpdates)
                {
                    var miu = _unitOfWork.MilestoneUpdates.Find(update.ID);
                    if (miu != null)
                    {
                        miu.SignOff = signOff;
                        var m = await _unitOfWork.Milestones.Edit(miu.MilestoneID);
                        if (m != null)
                        {
                            m.RagOptionID = miu.RagOptionID;
                            m.ForecastDate = miu.ForecastDate;
                            m.ActualDate = miu.ActualDate;
                            if (miu.ToBeClosed == true)
                            {
                                ChangeEntityStatus(m, EntityStatuses.Closed, now);
                            }
                            else if (m.EntityStatusID == (int)EntityStatuses.Closed)
                            {
                                ChangeEntityStatus(m, EntityStatuses.Open, now);
                            }
                        }
                    }
                }
            }

            foreach (var reportingEntityType in report.ReportingEntityTypes)
            {
                foreach (var reportingEntity in reportingEntityType.ReportingEntities)
                {
                    foreach (var update in reportingEntity.ReportingEntityUpdates)
                    {
                        var reu = _unitOfWork.ReportingEntityUpdates.Find(update.ID);
                        if (reu != null)
                        {
                            reu.SignOff = signOff;
                            var re = await _unitOfWork.ReportingEntities.Edit(reu.ReportingEntityID);
                            if (re != null)
                            {
                                re.ForecastDate = reu.ForecastDate;
                                re.ActualDate = reu.ActualDate;
                                if (reu.ToBeClosed == true)
                                {
                                    ChangeEntityStatus(re, EntityStatuses.Closed, now);
                                }
                                else if (re.EntityStatusID == (int)EntityStatuses.Closed)
                                {
                                    ChangeEntityStatus(re, EntityStatuses.Open, now);
                                }
                            }
                        }
                    }
                }
            }
        }

        private async Task SignOffProjectReport(SignOff signOff)
        {
            var now = DateTime.UtcNow;
            var report = JsonSerializer.Deserialize<SignOffProjectViewModel>(signOff.ReportJson);

            foreach (var update in report.Project.ProjectUpdates)
            {
                // Update IsCurrent flag for previous sign-offs
                var previousSignOffs = _repository.Entities.Where(so => so.IsCurrent == true && so.ReportMonth == signOff.ReportMonth && so.ProjectID == signOff.ProjectID);
                foreach (var pso in previousSignOffs) pso.IsCurrent = false;

                var pu = _unitOfWork.ProjectUpdates.Find(update.ID);
                if (pu != null)
                {
                    pu.SignOff = signOff;
                    if (pu.ToBeClosed == true)
                    {
                        await CloseProjectEntities(pu.ProjectID, now);
                    }
                }
            }

            foreach (var benefit in report.Benefits)
            {
                foreach (var update in benefit.BenefitUpdates)
                {
                    var bu = _unitOfWork.BenefitUpdates.Find(update.ID);
                    if (bu != null)
                    {
                        bu.SignOff = signOff;
                        var b = await _unitOfWork.Benefits.Edit((int)bu.BenefitID);
                        if (bu.Benefit != null)
                        {
                            b.RagOptionID = bu.RagOptionID;
                            if (bu.ToBeClosed == true)
                            {
                                ChangeEntityStatus(b, EntityStatuses.Closed, now);
                            }
                            else if (b.EntityStatusID == (int)EntityStatuses.Closed)
                            {
                                ChangeEntityStatus(b, EntityStatuses.Open, now);
                            }
                        }
                    }
                }
            }

            foreach (var dependency in report.Dependencies)
            {
                foreach (var update in dependency.DependencyUpdates)
                {
                    var du = _unitOfWork.DependencyUpdates.Find(update.ID);
                    if (du != null)
                    {
                        du.SignOff = signOff;
                        var d = await _unitOfWork.Dependencies.Edit(du.DependencyID);
                        if (d != null)
                        {
                            d.RagOptionID = du.RagOptionID;
                            d.ForecastDate = du.ForecastDate;
                            d.ActualDate = du.ActualDate;
                            if (du.ToBeClosed == true)
                            {
                                ChangeEntityStatus(d, EntityStatuses.Closed, now);
                            }
                            else if (d.EntityStatusID == (int)EntityStatuses.Closed)
                            {
                                ChangeEntityStatus(d, EntityStatuses.Open, now);
                            }
                        }
                    }
                }
            }

            foreach (var milestone in report.Milestones)
            {
                foreach (var update in milestone.MilestoneUpdates)
                {
                    var miu = _unitOfWork.MilestoneUpdates.Find(update.ID);
                    if (miu != null)
                    {
                        miu.SignOff = signOff;
                        var m = await _unitOfWork.Milestones.Edit(miu.MilestoneID);
                        if (m != null)
                        {
                            m.RagOptionID = miu.RagOptionID;
                            m.ForecastDate = miu.ForecastDate;
                            m.ActualDate = miu.ActualDate;
                            if (miu.ToBeClosed == true)
                            {
                                ChangeEntityStatus(m, EntityStatuses.Closed, now);
                            }
                            else if (m.EntityStatusID == (int)EntityStatuses.Closed)
                            {
                                ChangeEntityStatus(m, EntityStatuses.Open, now);
                            }
                        }
                    }
                }
            }

            foreach (var workStream in report.WorkStreams)
            {
                foreach (var update in workStream.WorkStreamUpdates)
                {
                    var wsu = _unitOfWork.WorkStreamUpdates.Find(update.ID);
                    if (wsu != null)
                    {
                        wsu.SignOff = signOff;
                        var ws = await _unitOfWork.WorkStreams.Edit(wsu.WorkStreamID);
                        if (ws != null)
                        {
                            ws.RagOptionID = wsu.RagOptionID;
                            if (wsu.ToBeClosed == true)
                            {
                                ChangeEntityStatus(ws, EntityStatuses.Closed, now);
                            }
                            else if (ws.EntityStatusID == (int)EntityStatuses.Closed)
                            {
                                ChangeEntityStatus(ws, EntityStatuses.Open, now);
                            }
                        }
                    }
                }
            }

            foreach (var reportingEntityType in report.ReportingEntityTypes)
            {
                foreach (var reportingEntity in reportingEntityType.ReportingEntities)
                {
                    foreach (var update in reportingEntity.ReportingEntityUpdates)
                    {
                        var reu = _unitOfWork.ReportingEntityUpdates.Find(update.ID);
                        if (reu != null)
                        {
                            reu.SignOff = signOff;
                            var re = await _unitOfWork.ReportingEntities.Edit(reu.ReportingEntityID);
                            if (re != null)
                            {
                                re.ForecastDate = reu.ForecastDate;
                                re.ActualDate = reu.ActualDate;
                                if (reu.ToBeClosed == true)
                                {
                                    ChangeEntityStatus(re, EntityStatuses.Closed, now);
                                }
                                else if (re.EntityStatusID == (int)EntityStatuses.Closed)
                                {
                                    ChangeEntityStatus(re, EntityStatuses.Open, now);
                                }
                            }
                        }
                    }
                }
            }
        }

        private async Task SignOffPartnerOrganisationReport(SignOff signOff)
        {
            var now = DateTime.UtcNow;
            var report = JsonSerializer.Deserialize<SignOffPartnerOrganisationViewModel>(signOff.ReportJson);

            foreach (var update in report.PartnerOrganisation.PartnerOrganisationUpdates)
            {
                // Update IsCurrent flag for previous sign-offs
                var previousSignOffs = _repository.Entities.Where(so => so.IsCurrent == true && so.ReportMonth == signOff.ReportMonth && so.PartnerOrganisationID == signOff.PartnerOrganisationID);
                foreach (var pso in previousSignOffs) pso.IsCurrent = false;

                var du = _unitOfWork.PartnerOrganisationUpdates.Find(update.ID);
                if (du != null) du.SignOff = signOff;
            }

            foreach (var milestone in report.Milestones)
            {
                foreach (var update in milestone.MilestoneUpdates)
                {
                    var miu = _unitOfWork.MilestoneUpdates.Find(update.ID);
                    if (miu != null)
                    {
                        miu.SignOff = signOff;
                        var m = await _unitOfWork.Milestones.Edit(miu.MilestoneID);
                        if (m != null)
                        {
                            m.RagOptionID = miu.RagOptionID;
                            m.ForecastDate = miu.ForecastDate;
                            m.ActualDate = miu.ActualDate;
                            if (miu.ToBeClosed == true)
                            {
                                ChangeEntityStatus(m, EntityStatuses.Closed, now);
                            }
                            else if (m.EntityStatusID == (int)EntityStatuses.Closed)
                            {
                                ChangeEntityStatus(m, EntityStatuses.Open, now);
                            }
                        }
                    }
                }
            }

            foreach (var action in report.PartnerOrganisationRiskMitigationActions)
            {
                foreach (var update in action.PartnerOrganisationRiskMitigationActionUpdates)
                {
                    var rmau = _unitOfWork.PartnerOrganisationRiskMitigationActionUpdates.Find(update.ID);
                    if (rmau != null)
                    {
                        rmau.SignOff = signOff;
                        var rma = _unitOfWork.PartnerOrganisationRiskMitigationActions.Find((int)rmau.PartnerOrganisationRiskMitigationActionID);
                        if (rma != null)
                        {
                            rma.ForecastDate = rmau.ForecastDate;
                            rma.ActualDate = rmau.ActualDate;
                            if (rmau.ToBeClosed == true)
                            {
                                ChangeEntityStatus(rma, EntityStatuses.Closed, now);
                            }
                            else if (rma.EntityStatusID == (int)EntityStatuses.Closed)
                            {
                                ChangeEntityStatus(rma, EntityStatuses.Open, now);
                            }
                        }
                    }
                }
            }

            foreach (var partnerOrgRisk in report.PartnerOrganisationRisks)
            {
                foreach (var update in partnerOrgRisk.PartnerOrganisationRiskUpdates)
                {
                    var ru = _unitOfWork.PartnerOrganisationRiskUpdates.Find(update.ID);
                    if (ru != null)
                    {
                        ru.SignOff = signOff;
                        var risk = await _unitOfWork.PartnerOrganisationRisks.Edit((int)ru.PartnerOrganisationRiskID);
                        if (risk != null)
                        {
                            risk.RiskIsOngoing = ru.RiskIsOngoing;
                            risk.RiskProximity = ru.RiskProximity;
                            if (ru.ToBeClosed == true)
                            {
                                ChangeEntityStatus(risk, EntityStatuses.Closed, now);
                                var actions = _unitOfWork.PartnerOrganisationRiskMitigationActions.Entities.Where(a => a.PartnerOrganisationRiskID == risk.ID);
                                foreach (var rma in actions)
                                {
                                    if (rma.EntityStatusID == (int)EntityStatuses.Open)
                                    {
                                        ChangeEntityStatus(rma, EntityStatuses.Closed, now);
                                    }
                                }
                            }
                            else if (risk.EntityStatusID == (int)EntityStatuses.Closed)
                            {
                                ChangeEntityStatus(risk, EntityStatuses.Open, now);
                            }
                        }
                    }
                }
            }

            foreach (var reportingEntityType in report.ReportingEntityTypes)
            {
                foreach (var reportingEntity in reportingEntityType.ReportingEntities)
                {
                    foreach (var update in reportingEntity.ReportingEntityUpdates)
                    {
                        var reu = _unitOfWork.ReportingEntityUpdates.Find(update.ID);
                        if (reu != null)
                        {
                            reu.SignOff = signOff;
                            var re = await _unitOfWork.ReportingEntities.Edit(reu.ReportingEntityID);
                            if (re != null)
                            {
                                re.ForecastDate = reu.ForecastDate;
                                re.ActualDate = reu.ActualDate;
                                if (reu.ToBeClosed == true)
                                {
                                    ChangeEntityStatus(re, EntityStatuses.Closed, now);
                                }
                                else if (re.EntityStatusID == (int)EntityStatuses.Closed)
                                {
                                    ChangeEntityStatus(re, EntityStatuses.Open, now);
                                }
                            }
                        }
                    }
                }
            }
        }

        private async Task SignOffRiskReport(SignOff signOff)
        {
            var now = DateTime.UtcNow;
            var report = JsonSerializer.Deserialize<SignOffCorporateRiskViewModel>(signOff.ReportJson);

            foreach (var update in report.Risk.RiskUpdates)
            {
                // Update IsCurrent flag for previous sign-offs
                var previousSignOffs = _repository.Entities.Where(so => so.IsCurrent == true && so.ReportMonth == signOff.ReportMonth && so.RiskID == signOff.RiskID);
                foreach (var pso in previousSignOffs) pso.IsCurrent = false;

                var ru = _unitOfWork.CorporateRiskUpdates.Find(update.ID);
                if (ru != null)
                {
                    ru.SignOff = signOff;
                    var risk = await _unitOfWork.CorporateRisks.Edit((int)ru.RiskID);
                    if (risk != null)
                    {
                        risk.RiskIsOngoing = ru.RiskIsOngoing;
                        risk.RiskProximity = ru.RiskProximity;

                        if (ru.ToBeClosed == true)
                        {
                            ChangeEntityStatus(risk, EntityStatuses.Closed, now);
                            var actions = _unitOfWork.CorporateRiskMitigationActions.Entities.Where(a => a.RiskID == risk.ID && a.EntityStatusID == (int)EntityStatuses.Open);
                            foreach (var rma in actions)
                            {
                                ChangeEntityStatus(rma, EntityStatuses.Closed, now);
                            }
                        }
                        else if (risk.EntityStatusID == (int)EntityStatuses.Closed)
                        {
                            ChangeEntityStatus(risk, EntityStatuses.Open, now);
                        }
                    }
                }
            }

            foreach (var action in report.RiskMitigationActions)
            {
                foreach (var update in action.RiskMitigationActionUpdates)
                {
                    var rmau = _unitOfWork.CorporateRiskMitigationActionUpdates.Find(update.ID);
                    if (rmau != null)
                    {
                        rmau.SignOff = signOff;
                        var rma = await _unitOfWork.CorporateRiskMitigationActions.Edit((int)rmau.RiskMitigationActionID);
                        if (rma != null)
                        {
                            rma.ForecastDate = rmau.ForecastDate;
                            rma.ActualDate = rmau.ActualDate;
                            if (rmau.ToBeClosed == true)
                            {
                                ChangeEntityStatus(rma, EntityStatuses.Closed, now);
                            }
                            else if (rma.EntityStatusID == (int)EntityStatuses.Closed)
                            {
                                ChangeEntityStatus(rma, EntityStatuses.Open, now);
                            }
                        }
                    }
                }
            }
        }

        private async Task SignOffFinancialRiskReport(SignOff signOff)
        {
            var now = DateTime.UtcNow;
            var report = JsonSerializer.Deserialize<SignOffFinancialRiskViewModel>(signOff.ReportJson);

            foreach (var update in report.FinancialRisk.FinancialRiskUpdates)
            {
                // Update IsCurrent flag for previous sign-offs
                var previousSignOffs = _repository.Entities.Where(so => so.IsCurrent == true && so.ReportMonth == signOff.ReportMonth && so.RiskID == signOff.RiskID);
                foreach (var pso in previousSignOffs) pso.IsCurrent = false;

                var ru = _unitOfWork.FinancialRiskUpdates.Find(update.ID);
                if (ru != null)
                {
                    ru.SignOff = signOff;
                    var risk = await _unitOfWork.FinancialRisks.Edit((int)ru.RiskID);
                    if (risk != null)
                    {
                        risk.RiskIsOngoing = ru.RiskIsOngoing;
                        risk.RiskProximity = ru.RiskProximity;

                        if (ru.ToBeClosed == true)
                        {
                            ChangeEntityStatus(risk, EntityStatuses.Closed, now);
                            var actions = _unitOfWork.FinancialRiskMitigationActions.Entities.Where(a => a.RiskID == risk.ID && a.EntityStatusID == (int)EntityStatuses.Open);
                            foreach (var rma in actions)
                            {
                                ChangeEntityStatus(rma, EntityStatuses.Closed, now);
                            }
                        }
                        else if (risk.EntityStatusID == (int)EntityStatuses.Closed)
                        {
                            ChangeEntityStatus(risk, EntityStatuses.Open, now);
                        }
                    }
                }
            }

            foreach (var action in report.FinancialRiskMitigationActions)
            {
                foreach (var update in action.FinancialRiskMitigationActionUpdates)
                {
                    var rmau = _unitOfWork.FinancialRiskMitigationActionUpdates.Find(update.ID);
                    if (rmau != null)
                    {
                        rmau.SignOff = signOff;
                        var rma = await _unitOfWork.FinancialRiskMitigationActions.Edit((int)rmau.RiskMitigationActionID);
                        if (rma != null)
                        {
                            rma.ForecastDate = rmau.ForecastDate;
                            rma.ActualDate = rmau.ActualDate;
                            if (rmau.ToBeClosed == true)
                            {
                                ChangeEntityStatus(rma, EntityStatuses.Closed, now);
                            }
                            else if (rma.EntityStatusID == (int)EntityStatuses.Closed)
                            {
                                ChangeEntityStatus(rma, EntityStatuses.Open, now);
                            }
                        }
                    }
                }
            }
        }

        private async Task CloseProjectEntities(int projectId, DateTime closedDate)
        {
            var project = await _unitOfWork.Projects.Entities
                .Where(p => p.ID == projectId)
                .Include(p => p.WorkStreams).ThenInclude(w => w.Milestones)
                .Include(p => p.Benefits)
                .Include(p => p.Dependencies)
                .Include(p => p.CorporateRisks).ThenInclude(r => r.RiskMitigationActions)
                .Include(p => p.ChildProjects)
                .Include(p => p.ReportingEntities)
                .SingleOrDefaultAsync();

            if (project != null)
            {
                ChangeEntityStatus(project, EntityStatuses.Closed, closedDate);

                foreach (var workstream in project.WorkStreams)
                {
                    if (workstream.EntityStatusID == (int)EntityStatuses.Open)
                    {
                        ChangeEntityStatus(workstream, EntityStatuses.Closed, closedDate);
                    }

                    foreach (var milestone in workstream.Milestones)
                    {
                        if (milestone.EntityStatusID == (int)EntityStatuses.Open)
                        {
                            ChangeEntityStatus(milestone, EntityStatuses.Closed, closedDate);
                        }
                    }
                }

                foreach (var benefit in project.Benefits)
                {
                    if (benefit.EntityStatusID == (int)EntityStatuses.Open)
                    {
                        ChangeEntityStatus(benefit, EntityStatuses.Closed, closedDate);
                    }
                }

                foreach (var dependency in project.Dependencies)
                {
                    if (dependency.EntityStatusID == (int)EntityStatuses.Open)
                    {
                        ChangeEntityStatus(dependency, EntityStatuses.Closed, closedDate);
                    }
                }

                foreach (var risk in project.CorporateRisks)
                {
                    if (risk.EntityStatusID == (int)EntityStatuses.Open)
                    {
                        ChangeEntityStatus(risk, EntityStatuses.Closed, closedDate);
                    }

                    foreach (var rma in risk.RiskMitigationActions)
                    {
                        if (rma.EntityStatusID == (int)EntityStatuses.Open)
                        {
                            ChangeEntityStatus(rma, EntityStatuses.Closed, closedDate);
                        }
                    }
                }

                foreach (var subProject in project.ChildProjects)
                {
                    await CloseProjectEntities(subProject.ID, closedDate);
                }

                foreach (var reportingEntity in project.ReportingEntities)
                {
                    if (reportingEntity.EntityStatusID == (int)EntityStatuses.Open)
                    {
                        ChangeEntityStatus(reportingEntity, EntityStatuses.Closed, closedDate);
                    }
                }
            }
        }

        public Task<SignOff> LastApprovedDirectorateReportForPeriod(int directorateId, DateTime reportPeriod)
        {
            return _repository.Entities
                .Include(e => e.SignOffUser)
                .SingleOrDefaultAsync(e => e.IsCurrent == true && e.DirectorateID == directorateId && e.ReportMonth == reportPeriod);
        }

        public Task<SignOff> LastApprovedProjectReportForPeriod(int projectId, DateTime reportPeriod)
        {
            return _repository.Entities
                .Include(e => e.SignOffUser)
                .SingleOrDefaultAsync(e => e.IsCurrent == true && e.ProjectID == projectId && e.ReportMonth == reportPeriod);
        }

        public Task<SignOff> LastApprovedPartnerOrganisationReportForPeriod(int partnerOrganisationId, DateTime reportPeriod)
        {
            return _repository.Entities
                .Include(e => e.SignOffUser)
                .SingleOrDefaultAsync(e => e.IsCurrent == true && e.PartnerOrganisationID == partnerOrganisationId && e.ReportMonth == reportPeriod);
        }

        public Task<SignOff> LastApprovedRiskReportForPeriod(int riskId, DateTime reportPeriod)
        {
            return _repository.Entities
                .Include(e => e.SignOffUser)
                .SingleOrDefaultAsync(e => e.IsCurrent == true && e.RiskID == riskId && e.ReportMonth == reportPeriod);
        }

        public Task<SignOff> LastApprovedFinancialRiskReportForPeriod(int financialRiskId, DateTime reportPeriod)
        {
            return _repository.Entities
                .Include(e => e.SignOffUser)
                .SingleOrDefaultAsync(e => e.IsCurrent == true && e.RiskID == financialRiskId && e.ReportMonth == reportPeriod);
        }
    }
}
