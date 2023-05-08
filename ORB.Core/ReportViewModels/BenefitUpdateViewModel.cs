using System;
using System.Collections.Generic;

namespace ORB.Core.ReportViewModels
{
    public class BenefitUpdateViewModel : EntityUpdateViewModel
    {
        public int? BenefitID { get; set; }
        public int? RagOptionID { get; set; }
        public string Comment { get; set; }
        public decimal? CurrentPerformance { get; set; }
        public bool? ToBeClosed { get; set; }
        public DateTime? UpdatePeriod { get; set; }
        public DateTime? ForecastDate { get; set; }
        public DateTime? ActualDate { get; set; }

        public RagOptionViewModel RagOption { get; set; }
    }
}
