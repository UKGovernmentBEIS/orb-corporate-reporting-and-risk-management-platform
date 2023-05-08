using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ORB.Core.ReportViewModels
{
    public class RiskViewModel : ReportingEntityViewModel
    {
        public string RiskCode { get; set; }
        public int? GroupID { get; set; }
        public int DirectorateID { get; set; }
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
        public int? DepartmentalObjectiveID { get; set; }
        public int? ModifiedByUserID { get; set; }
        public bool? IsProjectRisk { get; set; }
        public int? ProjectID { get; set; }
        public DateTime? RiskProximity { get; set; }
        public bool? RiskIsOngoing { get; set; }
        public int? LinkedRiskID { get; set; }
        public int? ReportApproverUserID { get; set; }
        public DateTime? CreatedDate { get; set; }
        public DateTime? RiskRegisteredDate { get; set; }

        public RiskGroupViewModel Group { get; set; }
        public RiskDirectorateViewModel Directorate { get; set; }
        public ICollection<RiskAttributeViewModel> Attributes { get; set; }
        public RiskAppetiteViewModel RiskAppetite { get; set; }
        public RiskImpactLevelViewModel TargetRiskImpactLevel { get; set; }
        public RiskImpactLevelViewModel UnmitigatedRiskImpactLevel { get; set; }
        public RiskProbabilityViewModel TargetRiskProbability { get; set; }
        public RiskProbabilityViewModel UnmitigatedRiskProbability { get; set; }
        public UserViewModel RiskOwnerUser { get; set; }
    }
}