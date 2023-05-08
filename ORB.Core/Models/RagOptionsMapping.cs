using System;
using System.Collections.Generic;

namespace ORB.Core.Models
{
    public partial class RagOptionsMapping
    {
        public int ID { get; set; }
        public int RiskProbabilityID { get; set; }
        public int RiskImpactLevelID { get; set; }
        public int RagOptionID { get; set; }

        public virtual RagOption RagOption { get; set; }
        public virtual RiskImpactLevel RiskImpactLevel { get; set; }
        public virtual RiskProbability RiskProbability { get; set; }
    }
}
