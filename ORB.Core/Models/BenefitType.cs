using System;
using System.Collections.Generic;

namespace ORB.Core.Models
{
    public class BenefitType : Entity
    {
        public BenefitType()
        {
            Benefits = new HashSet<Benefit>();
        }

        public virtual ICollection<Benefit> Benefits { get; set; }
    }
}
