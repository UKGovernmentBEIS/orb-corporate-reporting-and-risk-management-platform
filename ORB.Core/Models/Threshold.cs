using System;
using System.Collections.Generic;

namespace ORB.Core.Models
{
    public partial class Threshold : Entity
    {
        public Threshold()
        {
            RiskTypes = new HashSet<RiskType>();
            ThresholdAppetites = new HashSet<ThresholdAppetite>();
        }

        public int Priority { get; set; }

        public virtual ICollection<RiskType> RiskTypes { get; set; }
        public virtual ICollection<ThresholdAppetite> ThresholdAppetites { get; set; }
    }
}
