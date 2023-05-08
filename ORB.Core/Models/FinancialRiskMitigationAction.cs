using System;
using System.Collections.Generic;

namespace ORB.Core.Models
{
    public partial class FinancialRiskMitigationAction : RiskMitigationAction
    {
        public FinancialRiskMitigationAction() : base()
        {
            FinancialRiskRiskMitigationActions = new HashSet<FinancialRiskRiskMitigationAction>();
            FinancialRiskMitigationActionUpdates = new HashSet<FinancialRiskMitigationActionUpdate>();
        }

        public virtual FinancialRisk FinancialRisk { get; set; }
        public virtual ICollection<FinancialRiskRiskMitigationAction> FinancialRiskRiskMitigationActions { get; set; }
        public virtual ICollection<FinancialRiskMitigationActionUpdate> FinancialRiskMitigationActionUpdates { get; set; }
    }
}
