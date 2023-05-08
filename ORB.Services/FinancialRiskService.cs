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
    public class FinancialRiskService : ReportingEntityService<FinancialRisk>, IReportingEntityService<FinancialRisk>
    {
        public FinancialRiskService(IUnitOfWork unitOfWork, IOptions<RiskSettings> options) : base(unitOfWork, unitOfWork.FinancialRisks, new FinancialRiskValidator())
        {

        }

        protected async override Task AfterAdd(FinancialRisk entity)
        {
            SetRiskCode(entity);
            await _unitOfWork.SaveChanges();
        }

        protected override void BeforeClose(FinancialRisk entity)
        {
            base.BeforeClose(entity);

            CloseRisksRiskMitigationActions(entity);
        }

        protected override void BeforeRemove(FinancialRisk risk)
        {
            _unitOfWork.Attributes.RemoveRange(_unitOfWork.Attributes.Entities.Where(a => a.RiskID == risk.ID));
            _unitOfWork.Contributors.RemoveRange(_unitOfWork.Contributors.Entities.Where(c => c.RiskID == risk.ID));
            _unitOfWork.RiskRiskTypes.RemoveRange(_unitOfWork.RiskRiskTypes.Entities.Where(rrt => rrt.RiskID == risk.ID));
        }

        private void SetRiskCode(FinancialRisk risk)
        {
            risk.RiskCode = $"{_unitOfWork.RiskRegisters.Find((int)RiskRegisters.Financial).RiskCodePrefix}{risk.ID}";
        }

        private void CloseRisksRiskMitigationActions(FinancialRisk risk)
        {
            var now = DateTime.UtcNow;
            foreach (var action in _unitOfWork.FinancialRiskMitigationActions.Entities.Where(a => a.RiskID == risk.ID && a.EntityStatusID == (int)EntityStatuses.Open))
            {
                CloseEntityWithStatus(action, now);
            }
        }
    }
}
