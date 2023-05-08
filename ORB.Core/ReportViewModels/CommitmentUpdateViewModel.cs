using System;
using System.Collections.Generic;

namespace ORB.Core.ReportViewModels
{
    public class CommitmentUpdateViewModel : EntityUpdateViewModel
    {
        public int CommitmentID { get; set; }
        public int? RagOptionID { get; set; }
        public string Comment { get; set; }
        public DateTime? ForecastDate { get; set; }
        public DateTime? ActualDate { get; set; }
        public bool? ToBeClosed { get; set; }
        public DateTime? UpdatePeriod { get; set; }

        public RagOptionViewModel RagOption { get; set; }
    }
}
