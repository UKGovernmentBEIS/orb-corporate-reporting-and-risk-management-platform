using System;
using System.Collections.Generic;

namespace ORB.Core.Models
{
    public partial class CorporateRiskUpdate : RiskUpdate
    {
        public CorporateRiskUpdate() : base()
        {
            RiskMitigationActionUpdatesNavigation = new HashSet<CorporateRiskMitigationActionUpdate>();
        }

        public virtual CorporateRisk Risk { get; set; }
        public virtual ICollection<CorporateRiskMitigationActionUpdate> RiskMitigationActionUpdatesNavigation { get; set; }
    }
}
