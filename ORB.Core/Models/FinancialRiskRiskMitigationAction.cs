using System;
using System.Collections.Generic;

namespace ORB.Core.Models
{
    public partial class FinancialRiskRiskMitigationAction : RiskRiskMitigationAction
    {
        public virtual FinancialRisk Risk { get; set; }
        public virtual FinancialRiskMitigationAction RiskMitigationAction { get; set; }
    }
}
