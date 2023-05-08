using System;
using System.Collections.Generic;

namespace ORB.Core.ReportViewModels
{
    public class KeyWorkAreaUpdateViewModel : EntityUpdateViewModel
    {
        public int KeyWorkAreaID { get; set; }
        public int? RagOptionID { get; set; }
        public string Comment { get; set; }
        public bool? ToBeClosed { get; set; }
        public DateTime? UpdatePeriod { get; set; }

        public RagOptionViewModel RagOption { get; set; }
    }
}
