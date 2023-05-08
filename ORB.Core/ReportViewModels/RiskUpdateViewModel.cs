using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using ORB.Core.Models;

namespace ORB.Core.ReportViewModels
{
    public class RiskUpdateViewModel : EntityUpdateViewModel
    {
        public int? RiskID { get; set; }
        public int? RiskProbabilityID { get; set; }
        public int? RiskImpactLevelID { get; set; }
        public string Comment { get; set; }
        public int? RagOptionID { get; set; }
        public bool? Escalate { get; set; }
        public int? EscalateToRiskRegisterID { get; set; }
        public bool? DeEscalate { get; set; }
        public bool? ToBeClosed { get; set; }
        public DateTime? UpdatePeriod { get; set; }
        public string RiskMitigationActionUpdates { get; set; }
        public bool? IsCurrent { get; set; }
        public bool? SendNotifications { get; set; }
        public int? RiskRegisterID { get; set; }
        public DateTime? RiskProximity { get; set; }
        public string RiskCode { get; set; }
        public bool? RiskIsOngoing { get; set; }
        public int? SignOffID { get; set; }
        public bool? RiskAppetiteBreachAuthorised { get; set; }
        public string Narrative { get; set; }
        public string ClosureReason { get; set; }
        public ICollection<Hyperlink> Attachments { get; set; }
        public bool? ToBeDiscussed { get; set; }
        public ICollection<string> DiscussionForum { get; set; }

        public RiskImpactLevelViewModel RiskImpactLevel { get; set; }
        public RiskProbabilityViewModel RiskProbability { get; set; }
    }
}