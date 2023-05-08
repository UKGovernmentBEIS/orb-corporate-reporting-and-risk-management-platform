using System;
using System.Collections.Generic;
using System.Text;

namespace ORB.Core
{
    public interface IReportingCycle
    {
        byte? ReportingFrequency { get; set; }
        byte? ReportingDueDay { get; set; }
        DateTime? ReportingStartDate { get; set; }
    }

    public class ReportingCycle : IReportingCycle
    {
        public byte? ReportingFrequency { get; set; }
        public byte? ReportingDueDay { get; set; }
        public DateTime? ReportingStartDate { get; set; }
    }
}
