using System;
using System.Collections.Generic;

namespace ORB.Core.Models
{
    public partial class RiskRiskType : Entity
    {
        public int RiskID { get; set; }
        public int RiskTypeID { get; set; }

        public virtual CorporateRisk CorporateRisk { get; set; }
        public virtual RiskType RiskType { get; set; }
    }
}
