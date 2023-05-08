using System;
using System.Collections.Generic;

namespace ORB.Core.ReportViewModels
{
    public class MetricUpdateViewModel : EntityUpdateViewModel
    {
        public int MetricID { get; set; }
        public int? RagOptionID { get; set; }
        public string Comment { get; set; }
        public decimal? CurrentPerformance { get; set; }
        public bool? ToBeClosed { get; set; }
        public DateTime? UpdatePeriod { get; set; }

        public RagOptionViewModel RagOption { get; set; }
    }
}
