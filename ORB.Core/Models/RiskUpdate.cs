using System;
using System.Collections.Generic;

namespace ORB.Core.Models
{
    public partial class RiskUpdate : EntityUpdate
    {
        public string Comment { get; set; }
        public int? RagOptionID { get; set; }
        public int? RiskID { get; set; }
        public int? RiskProbabilityID { get; set; }
        public int? RiskImpactLevelID { get; set; }
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
        public bool? RiskAppetiteBreachAuthorised { get; set; }
        public string Narrative { get; set; }
        public string ClosureReason { get; set; }
        public ICollection<Hyperlink> Attachments { get; set; }
        public bool? ToBeDiscussed { get; set; }
        public ICollection<string> DiscussionForum { get; set; }

        public virtual RagOption RagOption { get; set; }
        public virtual RiskImpactLevel RiskImpactLevel { get; set; }
        public virtual RiskProbability RiskProbability { get; set; }
        public virtual RiskRegister EscalateToRiskRegister { get; set; }
        public virtual RiskRegister RiskRegister { get; set; }
    }
}
