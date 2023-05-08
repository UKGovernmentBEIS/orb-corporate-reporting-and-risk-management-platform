using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ORB.Core.ReportViewModels
{
    public class RiskMitigationActionViewModel : EntityWithStatusViewModel
    {
        public int? RiskID { get; set; }
        public int? OwnerUserID { get; set; }
        public int? RiskMitigationActionCode { get; set; }
        public string Description { get; set; }
        public DateTime? BaselineDate { get; set; }
        public DateTime? ForecastDate { get; set; }
        public DateTime? ActualDate { get; set; }
        public bool? ActionIsOngoing { get; set; }
        public byte? OngoingActionReviewFrequency { get; set; }
        public byte? OngoingActionReviewDueDay { get; set; }
        public DateTime? OngoingActionReviewStartDate { get; set; }
        public DateTime? NextReviewDate { get; set; }

        public UserViewModel OwnerUser { get; set; }
    }
}
