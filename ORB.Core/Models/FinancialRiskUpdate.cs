using System;
using System.Collections.Generic;

namespace ORB.Core.Models
{
    public partial class FinancialRiskUpdate : RiskUpdate
    {
        public FinancialRiskUpdate() : base()
        {
            FinancialRiskMitigationActionUpdatesNavigation = new HashSet<FinancialRiskMitigationActionUpdate>();
        }
        
        public FinancialRiskMeasurements Measurements { get; set; }

        public virtual FinancialRisk FinancialRisk { get; set; }
        public virtual ICollection<FinancialRiskMitigationActionUpdate> FinancialRiskMitigationActionUpdatesNavigation { get; set; }
    }
}
