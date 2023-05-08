using System;
using System.Collections.Generic;

namespace ORB.Core.Models
{
    public partial class PartnerOrganisationRisk : ReportingSubEntity
    {
        public PartnerOrganisationRisk()
        {
            PartnerOrganisationRiskMitigationActions = new HashSet<PartnerOrganisationRiskMitigationAction>();
            PartnerOrganisationRiskRiskTypes = new HashSet<PartnerOrganisationRiskRiskType>();
            PartnerOrganisationRiskUpdates = new HashSet<PartnerOrganisationRiskUpdate>();
        }

        public string RiskCode { get; set; }
        public int PartnerOrganisationID { get; set; }
        public int? RiskOwnerUserID { get; set; }
        public int? BeisRiskOwnerUserID { get; set; }
        public int? RagOptionID { get; set; }
        public string RiskEventDescription { get; set; }
        public string RiskCauseDescription { get; set; }
        public string RiskImpactDescription { get; set; }
        public int? UnmitigatedRiskProbabilityID { get; set; }
        public int? UnmitigatedRiskImpactLevelID { get; set; }
        public int? TargetRiskProbabilityID { get; set; }
        public int? TargetRiskImpactLevelID { get; set; }
        public int? BEISUnmitigatedRiskProbabilityID { get; set; }
        public int? BEISUnmitigatedRiskImpactLevelID { get; set; }
        public int? BEISTargetRiskProbabilityID { get; set; }
        public int? BEISTargetRiskImpactLevelID { get; set; }
        public int? RiskAppetiteID { get; set; }
        public int? BeisRiskAppetiteID { get; set; }
        public int? DepartmentalObjectiveID { get; set; }
        public DateTime? RiskProximity { get; set; }
        public bool? RiskIsOngoing { get; set; }

        public virtual RiskAppetite BeisRiskAppetite { get; set; }
        public virtual User BeisRiskOwnerUser { get; set; }
        public virtual RiskImpactLevel BEISTargetRiskImpactLevel { get; set; }
        public virtual RiskProbability BEISTargetRiskProbability { get; set; }
        public virtual RiskImpactLevel BEISUnmitigatedRiskImpactLevel { get; set; }
        public virtual RiskProbability BEISUnmitigatedRiskProbability { get; set; }
        public virtual DepartmentalObjective DepartmentalObjective { get; set; }
        public virtual PartnerOrganisation PartnerOrganisation { get; set; }
        public virtual RagOption RagOption { get; set; }
        public virtual RiskAppetite RiskAppetite { get; set; }
        public virtual User RiskOwnerUser { get; set; }
        public virtual RiskImpactLevel TargetRiskImpactLevel { get; set; }
        public virtual RiskProbability TargetRiskProbability { get; set; }
        public virtual RiskImpactLevel UnmitigatedRiskImpactLevel { get; set; }
        public virtual RiskProbability UnmitigatedRiskProbability { get; set; }
        public virtual ICollection<PartnerOrganisationRiskMitigationAction> PartnerOrganisationRiskMitigationActions { get; set; }
        public virtual ICollection<PartnerOrganisationRiskRiskType> PartnerOrganisationRiskRiskTypes { get; set; }
        public virtual ICollection<PartnerOrganisationRiskUpdate> PartnerOrganisationRiskUpdates { get; set; }
    }
}
