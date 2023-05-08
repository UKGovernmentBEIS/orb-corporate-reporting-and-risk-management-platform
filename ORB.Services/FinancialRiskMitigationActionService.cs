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
    public class FinancialRiskMitigationActionService : RiskMitigationActionService<FinancialRiskMitigationAction>, IEntityService<FinancialRiskMitigationAction>
    {
        public FinancialRiskMitigationActionService(IUnitOfWork unitOfWork) : base(unitOfWork, unitOfWork.FinancialRiskMitigationActions, new RiskMitigationActionValidator<FinancialRiskMitigationAction>()) { }

        protected override void SetReportingCycle(FinancialRiskMitigationAction rma)
        {
            base.SetReportingCycle(rma);

            var risk = _unitOfWork.FinancialRisks.Find(rma.RiskID);
            if (risk != null)
            {
                ReportingCycleService.CopyReportingCycle(risk, rma);
            }
        }
    }
}
