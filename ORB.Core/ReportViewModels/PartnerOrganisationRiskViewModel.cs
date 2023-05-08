using System;
using System.Collections.Generic;
using System.Linq;
using ORB.Core.Models;

namespace ORB.Core.ReportViewModels
{
    public class PartnerOrganisationRiskViewModel : ReportingEntityViewModel
    {
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
        public int? RiskAppetiteID { get; set; }
        public int? BeisRiskAppetiteID { get; set; }
        public int? DepartmentalObjectiveID { get; set; }
        public DateTime? RiskProximity { get; set; }
        public bool? RiskIsOngoing { get; set; }
        public int? ModifiedByUserID { get; set; }
        public int? BEISUnmitigatedRiskProbabilityID { get; set; }
        public int? BEISUnmitigatedRiskImpactLevelID { get; set; }
        public int? BEISTargetRiskProbabilityID { get; set; }
        public int? BEISTargetRiskImpactLevelID { get; set; }

        public ICollection<PartnerOrganisationRiskUpdateViewModel> PartnerOrganisationRiskUpdates { get; set; }
        public UserViewModel RiskOwnerUser { get; set; }
        public RiskImpactLevelViewModel UnmitigatedRiskImpactLevel { get; set; }
        public RiskProbabilityViewModel UnmitigatedRiskProbability { get; set; }
        public RiskImpactLevelViewModel BEISUnmitigatedRiskImpactLevel { get; set; }
        public RiskProbabilityViewModel BEISUnmitigatedRiskProbability { get; set; }
        public RiskImpactLevelViewModel TargetRiskImpactLevel { get; set; }
        public RiskProbabilityViewModel TargetRiskProbability { get; set; }
        public RiskImpactLevelViewModel BEISTargetRiskImpactLevel { get; set; }
        public RiskProbabilityViewModel BEISTargetRiskProbability { get; set; }
    }
}
