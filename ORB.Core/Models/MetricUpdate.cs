using System;
using System.Collections.Generic;

namespace ORB.Core.Models
{
    public partial class MetricUpdate : EntityUpdate
    {
        public int MetricID { get; set; }
        public int? RagOptionID { get; set; }
        public string Comment { get; set; }
        public decimal? CurrentPerformance { get; set; }
        public bool? ToBeClosed { get; set; }
        public DateTime? UpdatePeriod { get; set; }

        public virtual Metric Metric { get; set; }
        public virtual RagOption RagOption { get; set; }
    }
}
