using System;
using System.Collections.Generic;

namespace ORB.Core.Models
{
    public partial class CorporateRiskMitigationActionUpdate : RiskMitigationActionUpdate
    {
        public virtual CorporateRiskMitigationAction RiskMitigationAction { get; set; }
        public virtual CorporateRiskUpdate RiskUpdate { get; set; }
    }
}
