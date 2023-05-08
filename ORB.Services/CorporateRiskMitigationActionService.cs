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
    public class CorporateRiskMitigationActionService : RiskMitigationActionService<CorporateRiskMitigationAction>, IEntityService<CorporateRiskMitigationAction>
    {
        public CorporateRiskMitigationActionService(IUnitOfWork unitOfWork) : base(unitOfWork, unitOfWork.CorporateRiskMitigationActions, new RiskMitigationActionValidator<CorporateRiskMitigationAction>()) { }

        protected override void SetReportingCycle(CorporateRiskMitigationAction rma)
        {
            base.SetReportingCycle(rma);

            var risk = _unitOfWork.CorporateRisks.Find(rma.RiskID);
            if (risk != null)
            {
                ReportingCycleService.CopyReportingCycle(risk, rma);
            }
        }
    }
}
