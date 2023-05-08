using System;
using System.Collections.Generic;

namespace ORB.Core.Models
{
    public partial class FinancialRiskMitigationActionUpdate : RiskMitigationActionUpdate
    {
        public virtual FinancialRiskMitigationAction FinancialRiskMitigationAction { get; set; }
        public virtual FinancialRiskUpdate FinancialRiskUpdate { get; set; }
    }
}
