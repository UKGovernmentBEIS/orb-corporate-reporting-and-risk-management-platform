using System;

namespace ORB.Core.Models
{
    public class ReportingFrequency : Entity
    {
        public int? RemindAuthorsDaysBeforeDue { get; set; }
        public int? RemindApproverDaysBeforeDue { get; set; }
        public int? EarlyUpdateWarningDays { get; set; }
    }
}
