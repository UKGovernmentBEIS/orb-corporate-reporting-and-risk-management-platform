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
    public class PartnerOrganisationRiskMitigationActionService : EntityWithStatusService<PartnerOrganisationRiskMitigationAction>, IEntityService<PartnerOrganisationRiskMitigationAction>
    {
        private int _riskBeforePatch;

        public PartnerOrganisationRiskMitigationActionService(IUnitOfWork unitOfWork) : base(unitOfWork, unitOfWork.PartnerOrganisationRiskMitigationActions) { }

        protected override void BeforeAdd(PartnerOrganisationRiskMitigationAction entity)
        {
            base.BeforeAdd(entity);

            SetPartnerOrganisationRiskMitigationActionSequentialId(entity);
            SetReportingCycle(entity);
        }

        protected override void BeforePatch(PartnerOrganisationRiskMitigationAction entity)
        {
            base.BeforePatch(entity);

            _riskBeforePatch = entity.PartnerOrganisationRiskID;
        }

        protected override void AfterPatch(PartnerOrganisationRiskMitigationAction entity)
        {
            base.AfterPatch(entity);

            if (_riskBeforePatch != entity.PartnerOrganisationRiskID)
            {
                SetReportingCycle(entity);
            }
        }

        protected override void BeforeRemove(PartnerOrganisationRiskMitigationAction porma)
        {
            _unitOfWork.Contributors.RemoveRange(_unitOfWork.Contributors.Entities.Where(c => c.PartnerOrganisationRiskMitigationActionID == porma.ID));
        }

        private void SetPartnerOrganisationRiskMitigationActionSequentialId(PartnerOrganisationRiskMitigationAction porma)
        {
            var lastRiskAction = _repository.Entities.OrderByDescending(a => a.ID).FirstOrDefault(a => a.PartnerOrganisationRiskID == porma.PartnerOrganisationRiskID);
            if (lastRiskAction != null)
            {
                porma.RiskMitigationActionCode = lastRiskAction.RiskMitigationActionCode + 1;
            }
            else
            {
                porma.RiskMitigationActionCode = 1;
            }
        }

        private void SetReportingCycle(PartnerOrganisationRiskMitigationAction porma)
        {
            var risk = _unitOfWork.PartnerOrganisationRisks.Find(porma.PartnerOrganisationRiskID);
            if (risk != null)
            {
                ReportingCycleService.CopyReportingCycle(risk, porma);
            }
        }
    }
}
