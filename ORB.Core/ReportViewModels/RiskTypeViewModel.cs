using ORB.Core.Models;
using System;
using System.Collections.Generic;
using System.Text;

namespace ORB.Core.ReportViewModels
{
    public class RiskTypeViewModel : Entity
    {
        public int? ThresholdID { get; set; }

        public ThresholdViewModel Threshold { get; set; }
    }
}
