using System;
using System.Collections.Generic;

namespace ORB.Core.Models
{
    public partial class Metric : ReportingSubEntity
    {
        public Metric()
        {
            MetricUpdates = new HashSet<MetricUpdate>();
        }

        public string MetricCode { get; set; }
        public int DirectorateID { get; set; }
        public int? MeasurementUnitID { get; set; }
        public decimal? TargetPerformanceUpperLimit { get; set; }
        public decimal? TargetPerformanceLowerLimit { get; set; }
        public int? RagOptionID { get; set; }

        public virtual Directorate Directorate { get; set; }
        public virtual MeasurementUnit MeasurementUnit { get; set; }
        public virtual RagOption RagOption { get; set; }
        public virtual ICollection<MetricUpdate> MetricUpdates { get; set; }
    }
}
