using System;
using System.Collections.Generic;

namespace ORB.Core.Models
{
    public partial class ThresholdAppetite : ObjectWithId
    {
        public int ThresholdID { get; set; }
        public int RiskImpactLevelID { get; set; }
        public int RiskProbabilityID { get; set; }
        public bool Acceptable { get; set; }

        public virtual RiskImpactLevel RiskImpactLevel { get; set; }
        public virtual RiskProbability RiskProbability { get; set; }
        public virtual Threshold Threshold { get; set; }
    }
}
