using System;
using System.Collections.Generic;
using System.Text;

namespace ORB.Core
{
    public interface IReportDueDates
    {
        DateTime Next { get; set; }
        DateTime Previous { get; set; }
    }

    public class ReportDueDates : IReportDueDates
    {
        public DateTime Next { get; set; }
        public DateTime Previous { get; set; }
    }
}
