using System;
using System.Collections.Generic;

namespace ORB.Core.Models
{
    public class BenefitUpdate : EntityUpdate
    {
        public int? BenefitID { get; set; }
        public int? RagOptionID { get; set; }
        public string Comment { get; set; }
        public decimal? CurrentPerformance { get; set; }
        public bool? ToBeClosed { get; set; }
        public DateTime? UpdatePeriod { get; set; }
        public DateTime? ForecastDate { get; set; }
        public DateTime? ActualDate { get; set; }

        public virtual Benefit Benefit { get; set; }
        public virtual RagOption RagOption { get; set; }
    }
}
