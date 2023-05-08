using Microsoft.AspNet.OData;
using Microsoft.EntityFrameworkCore;
using ORB.Core;
using ORB.Core.Models;
using ORB.Core.Services;
using ORB.Services.Validations;
using System;
using System.Linq;
using System.Threading.Tasks;

namespace ORB.Services
{
    public class PartnerOrganisationService : ReportingEntityService<PartnerOrganisation>, IReportingEntityService<PartnerOrganisation>
    {
        private byte? _reportingFrequencyBeforePatch;
        private byte? _reportingDueDayBeforePatch;
        private DateTime? _reportingStartDateBeforePatch;
        private DateTime _nextReportDueBeforePatch;

        public PartnerOrganisationService(IUnitOfWork unitOfWork) : base(unitOfWork, unitOfWork.PartnerOrganisations, new PartnerOrganisationValidator(unitOfWork)) { }

        protected override void BeforePatch(PartnerOrganisation partnerOrganisation)
        {
            base.BeforePatch(partnerOrganisation);

            _reportingFrequencyBeforePatch = partnerOrganisation.ReportingFrequency;
            _reportingDueDayBeforePatch = partnerOrganisation.ReportingDueDay;
            _reportingStartDateBeforePatch = partnerOrganisation.ReportingStartDate;
            _nextReportDueBeforePatch = ReportingCycleService.NextReportDue(partnerOrganisation, DateTime.UtcNow);
        }

        protected override void AfterPatch(PartnerOrganisation partnerOrganisation)
        {
            base.AfterPatch(partnerOrganisation);

            if (_reportingFrequencyBeforePatch != partnerOrganisation.ReportingFrequency
                || _reportingDueDayBeforePatch != partnerOrganisation.ReportingDueDay
                || _reportingStartDateBeforePatch != partnerOrganisation.ReportingStartDate)
            {
                CopyReportingCycleToChildren(partnerOrganisation);
            }
        }

        protected override void BeforeClose(PartnerOrganisation entity)
        {
            base.BeforeClose(entity);

            ClosePartnerOrganisationChildren(entity);
        }

        protected override void BeforeRemove(PartnerOrganisation partnerOrganisation)
        {
            _unitOfWork.Contributors.RemoveRange(_unitOfWork.Contributors.Entities.Where(c => c.PartnerOrganisationID == partnerOrganisation.ID));
        }

        private void CopyReportingCycleToChildren(PartnerOrganisation partnerOrganisation)
        {
            var newNextReportDueDate = ReportingCycleService.NextReportDue(partnerOrganisation, DateTime.UtcNow);

            foreach (var milestone in _unitOfWork.Milestones.Entities.Where(m => m.PartnerOrganisationID == partnerOrganisation.ID))
            {
                ReportingCycleService.CopyReportingCycle(partnerOrganisation, milestone);

                foreach (var update in _unitOfWork.MilestoneUpdates.Entities.Where(u => u.MilestoneID == milestone.ID && u.UpdatePeriod == _nextReportDueBeforePatch && u.SignOffID == null))
                {
                    update.UpdatePeriod = newNextReportDueDate;
                }
            }

            foreach (var risk in _unitOfWork.PartnerOrganisationRisks.Entities.Where(r => r.PartnerOrganisationID == partnerOrganisation.ID))
            {
                ReportingCycleService.CopyReportingCycle(partnerOrganisation, risk);

                foreach (var update in _unitOfWork.PartnerOrganisationRiskUpdates.Entities.Where(u => u.PartnerOrganisationRiskID == risk.ID && u.UpdatePeriod == _nextReportDueBeforePatch && u.SignOffID == null))
                {
                    update.UpdatePeriod = newNextReportDueDate;
                }

                foreach (var rma in _unitOfWork.PartnerOrganisationRiskMitigationActions.Entities.Where(a => a.PartnerOrganisationRiskID == risk.ID))
                {
                    ReportingCycleService.CopyReportingCycle(partnerOrganisation, rma);

                    foreach (var update in _unitOfWork.PartnerOrganisationRiskMitigationActionUpdates.Entities.Where(u => u.PartnerOrganisationRiskMitigationActionID == rma.ID && u.UpdatePeriod == _nextReportDueBeforePatch && u.SignOffID == null))
                    {
                        update.UpdatePeriod = newNextReportDueDate;
                    }
                }
            }

            foreach (var entity in _unitOfWork.ReportingEntities.Entities.Where(e => e.PartnerOrganisationID == partnerOrganisation.ID))
            {
                ReportingCycleService.CopyReportingCycle(partnerOrganisation, entity);

                foreach (var update in _unitOfWork.ReportingEntityUpdates.Entities.Where(u => u.ReportingEntityID == entity.ID && u.UpdatePeriod == _nextReportDueBeforePatch && u.SignOffID == null))
                {
                    update.UpdatePeriod = newNextReportDueDate;
                }
            }
        }

        private void ClosePartnerOrganisationChildren(PartnerOrganisation partnerOrganisation)
        {
            var now = DateTime.UtcNow;
            foreach (var milestone in _unitOfWork.Milestones.Entities.Where(m => m.PartnerOrganisationID == partnerOrganisation.ID && m.EntityStatusID == (int)EntityStatuses.Open))
            {
                CloseEntityWithStatus(milestone, now);
            }

            foreach (var risk in _unitOfWork.PartnerOrganisationRisks.Entities.Where(r => r.PartnerOrganisationID == partnerOrganisation.ID && r.EntityStatusID == (int)EntityStatuses.Open))
            {
                CloseEntityWithStatus(risk, now);

                foreach (var action in _unitOfWork.PartnerOrganisationRiskMitigationActions.Entities.Where(a => a.PartnerOrganisationRiskID == risk.ID && a.EntityStatusID == (int)EntityStatuses.Open))
                {
                    CloseEntityWithStatus(action, now);
                }
            }

            foreach (var entity in _unitOfWork.ReportingEntities.Entities.Where(e => e.PartnerOrganisationID == partnerOrganisation.ID && e.EntityStatusID == (int)EntityStatuses.Open))
            {
                CloseEntityWithStatus(entity, now);
            }
        }
    }
}
