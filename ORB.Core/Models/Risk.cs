using System;
using System.Collections.Generic;

namespace ORB.Core.Models
{
    public partial class Risk : ReportingEntity
    {
        public Risk()
        {
            SignOffs = new HashSet<SignOff>();
        }

        public string RiskCode { get; set; }
        public int? GroupID { get; set; }
        public int? DirectorateID { get; set; }
        public int? RiskOwnerUserID { get; set; }
        public int? RagOptionID { get; set; }
        public int? RiskRegisterID { get; set; }
        public string RiskEventDescription { get; set; }
        public string RiskCauseDescription { get; set; }
        public string RiskImpactDescription { get; set; }
        public int? UnmitigatedRiskProbabilityID { get; set; }
        public int? UnmitigatedRiskImpactLevelID { get; set; }
        public int? TargetRiskProbabilityID { get; set; }
        public int? TargetRiskImpactLevelID { get; set; }
        public int? RiskAppetiteID { get; set; }
        public bool? IsProjectRisk { get; set; }
        public int? ProjectID { get; set; }
        public DateTime? RiskProximity { get; set; }
        public bool? RiskIsOngoing { get; set; }
        public int? LinkedRiskID { get; set; }
        public int? ReportApproverUserID { get; set; }
        public DateTime? CreatedDate { get; set; }
        public DateTime? RiskRegisteredDate { get; set; }

        public virtual Group Group { get; set; }
        public virtual Directorate Directorate { get; set; }
        public virtual Project Project { get; set; }
        public virtual RagOption RagOption { get; set; }
        public virtual User ReportApproverUser { get; set; }
        public virtual RiskAppetite RiskAppetite { get; set; }
        public virtual User RiskOwnerUser { get; set; }
        public virtual RiskRegister RiskRegister { get; set; }
        public virtual RiskImpactLevel TargetRiskImpactLevel { get; set; }
        public virtual RiskProbability TargetRiskProbability { get; set; }
        public virtual RiskImpactLevel UnmitigatedRiskImpactLevel { get; set; }
        public virtual RiskProbability UnmitigatedRiskProbability { get; set; }
        public virtual ICollection<SignOff> SignOffs { get; set; }
    }
}
