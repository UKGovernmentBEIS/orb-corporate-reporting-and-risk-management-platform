using System;
using System.Collections.Generic;

namespace ORB.Core.Models
{
    public partial class RiskMitigationAction : ReportingSubEntity
    {
        public RiskMitigationAction()
        {
        }

        public int RiskID { get; set; }
        public int? RiskMitigationActionCode { get; set; }
        public DateTime? BaselineDate { get; set; }
        public DateTime? ForecastDate { get; set; }
        public DateTime? ActualDate { get; set; }
        public int? OwnerUserID { get; set; }
        public bool? ActionIsOngoing { get; set; }
        public byte? OngoingActionReviewFrequency { get; set; }
        public byte? OngoingActionReviewDueDay { get; set; }
        public DateTime? OngoingActionReviewStartDate { get; set; }

        public virtual User OwnerUser { get; set; }
    }
}
