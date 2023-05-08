using System;
using System.Collections.Generic;

namespace ORB.Core.Models
{
    public class Benefit : ReportingSubEntity
    {
        public Benefit()
        {
            BenefitUpdates = new HashSet<BenefitUpdate>();
        }

        public int ProjectID { get; set; }
        public int? BenefitTypeID { get; set; }
        public int? MeasurementUnitID { get; set; }
        public decimal? TargetPerformanceLowerLimit { get; set; }
        public decimal? TargetPerformanceUpperLimit { get; set; }
        public int? RagOptionID { get; set; }
        public DateTime? BaselineDate { get; set; }
        public DateTime? ForecastDate { get; set; }
        public DateTime? ActualDate { get; set; }

        public virtual BenefitType BenefitType { get; set; }
        public virtual MeasurementUnit MeasurementUnit { get; set; }
        public virtual Project Project { get; set; }
        public virtual RagOption RagOption { get; set; }
        public virtual ICollection<BenefitUpdate> BenefitUpdates { get; set; }
    }
}
