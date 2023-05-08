using System;
using System.Collections.Generic;

namespace ORB.Core.Models
{
    public partial class CorporateRiskRiskMitigationAction : RiskRiskMitigationAction
    {
        public virtual CorporateRisk Risk { get; set; }
        public virtual CorporateRiskMitigationAction RiskMitigationAction { get; set; }
    }
}
