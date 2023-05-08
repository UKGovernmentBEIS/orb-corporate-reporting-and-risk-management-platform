using Microsoft.AspNet.OData;
using Microsoft.Extensions.Options;
using ORB.Core;
using ORB.Core.Models;
using ORB.Core.Services;
using ORB.Services.Validations;
using System;
using System.Linq;
using System.Threading.Tasks;

namespace ORB.Services
{
    public class PartnerOrganisationRiskService : EntityWithStatusService<PartnerOrganisationRisk>, IEntityService<PartnerOrganisationRisk>
    {
        private readonly RiskSettings _settings;
        private int _partnerOrganisationBeforePatch;

        public PartnerOrganisationRiskService(IUnitOfWork unitOfWork, IOptions<RiskSettings> options) : base(unitOfWork, unitOfWork.PartnerOrganisationRisks)
        {
            _settings = options.Value;
        }

        protected override void BeforeAdd(PartnerOrganisationRisk entity)
        {
            base.BeforeAdd(entity);

            SetReportingCycle(entity);
        }

        protected async override Task AfterAdd(PartnerOrganisationRisk entity)
        {
            SetRiskCode(entity);

            await _unitOfWork.SaveChanges();
        }

        protected override void BeforePatch(PartnerOrganisationRisk entity)
        {
            base.BeforePatch(entity);

            _partnerOrganisationBeforePatch = entity.PartnerOrganisationID;
        }

        protected override void AfterPatch(PartnerOrganisationRisk entity)
        {
            base.AfterPatch(entity);

            SetRiskCode(entity);

            if (_partnerOrganisationBeforePatch != entity.PartnerOrganisationID)
            {
                SetReportingCycle(entity);
            }
        }

        protected override void BeforeClose(PartnerOrganisationRisk entity)
        {
            base.BeforeClose(entity);

            ClosePartnerOrganisationRisksPartnerOrganisationRiskMitigationActions(entity);
        }

        protected override void BeforeRemove(PartnerOrganisationRisk partnerOrganisationRisk)
        {
            _unitOfWork.Contributors.RemoveRange(_unitOfWork.Contributors.Entities.Where(c => c.PartnerOrganisationRiskID == partnerOrganisationRisk.ID));
            _unitOfWork.PartnerOrganisationRiskRiskTypes.RemoveRange(_unitOfWork.PartnerOrganisationRiskRiskTypes.Entities.Where(rrt => rrt.PartnerOrganisationRiskID == partnerOrganisationRisk.ID));
        }

        private void SetRiskCode(PartnerOrganisationRisk risk)
        {
            if (_settings.PartnerOrganisationRiskPrefix != null)
            {
                risk.RiskCode = $"{_settings.PartnerOrganisationRiskPrefix}{risk.ID}";
            }
        }

        private void SetReportingCycle(PartnerOrganisationRisk risk)
        {
            var partnerOrg = _unitOfWork.PartnerOrganisations.Find(risk.PartnerOrganisationID);
            if (partnerOrg != null)
            {
                ReportingCycleService.CopyReportingCycle(partnerOrg, risk);
            }
        }

        private void ClosePartnerOrganisationRisksPartnerOrganisationRiskMitigationActions(PartnerOrganisationRisk risk)
        {
            var now = DateTime.UtcNow;
            foreach (var action in _unitOfWork.PartnerOrganisationRiskMitigationActions.Entities.Where(a => a.PartnerOrganisationRiskID == risk.ID && a.EntityStatusID == (int)EntityStatuses.Open))
            {
                CloseEntityWithStatus(action, now);
            }
        }
    }
}
