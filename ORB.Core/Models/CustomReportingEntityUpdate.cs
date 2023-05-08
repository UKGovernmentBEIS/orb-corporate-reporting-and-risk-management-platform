using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;

namespace ORB.Core.Models
{
    public partial class CustomReportingEntityUpdate : EntityUpdate
    {
        public int ReportingEntityID { get; set; }
        public int? RagOptionID { get; set; }
        public string Comment { get; set; }
        public decimal? CurrentPerformance { get; set; }
        public DateTime? ForecastDate { get; set; }
        public DateTime? ActualDate { get; set; }
        public bool? ToBeClosed { get; set; }
        public DateTime? UpdatePeriod { get; set; }

        public virtual CustomReportingEntity ReportingEntity { get; set; }
        public virtual RagOption RagOption { get; set; }
    }
}
