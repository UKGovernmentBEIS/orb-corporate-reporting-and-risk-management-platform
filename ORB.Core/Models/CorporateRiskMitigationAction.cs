using System;
using System.Collections.Generic;

namespace ORB.Core.Models
{
    public partial class CorporateRiskMitigationAction : RiskMitigationAction
    {
        public CorporateRiskMitigationAction() : base()
        {
            CorporateRiskRiskMitigationActions = new HashSet<CorporateRiskRiskMitigationAction>();
            RiskMitigationActionUpdates = new HashSet<CorporateRiskMitigationActionUpdate>();
        }

        public virtual CorporateRisk Risk { get; set; }
        public virtual ICollection<CorporateRiskRiskMitigationAction> CorporateRiskRiskMitigationActions { get; set; }
        public virtual ICollection<CorporateRiskMitigationActionUpdate> RiskMitigationActionUpdates { get; set; }
    }
}
