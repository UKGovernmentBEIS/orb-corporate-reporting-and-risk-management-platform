using System;
using System.Collections.Generic;

namespace ORB.Core.Models
{
    public class MeasurementUnit : Entity
    {
        public MeasurementUnit()
        {
            Benefits = new HashSet<Benefit>();
            Metrics = new HashSet<Metric>();
        }

        public virtual ICollection<Benefit> Benefits { get; set; }
        public virtual ICollection<Metric> Metrics { get; set; }
    }
}
