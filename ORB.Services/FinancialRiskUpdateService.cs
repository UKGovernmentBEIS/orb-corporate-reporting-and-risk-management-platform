using Microsoft.AspNet.OData;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
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
    public class FinancialRiskUpdateService : EntityUpdateService<FinancialRiskUpdate>, IEntityUpdateService<FinancialRiskUpdate>
    {
        public FinancialRiskUpdateService(ILogger<FinancialRiskUpdateService> logger, IOptions<EmailSettings> options, IEmailService emailService, IUnitOfWork unitOfWork)
            : base(unitOfWork, unitOfWork.FinancialRiskUpdates, new RiskUpdateValidator<FinancialRiskUpdate>())
        {

        }

        protected override void BeforeAdd(FinancialRiskUpdate riskUpdate)
        {
            base.BeforeAdd(riskUpdate);

            riskUpdate.IsCurrent = true;

            var lastApprovals = _repository.Entities.Where(ru => ru.IsCurrent == true && ru.UpdatePeriod == riskUpdate.UpdatePeriod && ru.RiskID == riskUpdate.RiskID);
            foreach (var l in lastApprovals) l.IsCurrent = false;
        }
    }
}
