using System;
using System.Collections.Generic;
using System.Text;

namespace ORB.Core
{
    public interface IReportPeriod
    {
        DateTime Start { get; set; }
        DateTime End { get; set; }
    }

    public class ReportPeriod : IReportPeriod
    {
        public DateTime Start { get; set; }
        public DateTime End { get; set; }
    }
}
