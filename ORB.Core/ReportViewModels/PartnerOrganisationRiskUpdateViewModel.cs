using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ORB.Core.ReportViewModels
{
    public class PartnerOrganisationRiskUpdateViewModel : EntityUpdateViewModel
    {
        public string Comment { get; set; }
        public int? RagOptionID { get; set; }
        public int? PartnerOrganisationRiskID { get; set; }
        public int? RiskProbabilityID { get; set; }
        public int? RiskImpactLevelID { get; set; }
        public int? BeisRiskProbabilityID { get; set; }
        public int? BeisRiskImpactLevelID { get; set; }
        public bool? ToBeClosed { get; set; }
        public DateTime? UpdatePeriod { get; set; }
        public bool? IsCurrent { get; set; }
        public DateTime? RiskProximity { get; set; }
        public bool? RiskIsOngoing { get; set; }
        public int? SignOffID { get; set; }
        public int? BeisRagOptionID { get; set; }

        public RiskImpactLevelViewModel RiskImpactLevel { get; set; }
        public RiskProbabilityViewModel RiskProbability { get; set; }
        public RiskImpactLevelViewModel BeisRiskImpactLevel { get; set; }
        public RiskProbabilityViewModel BeisRiskProbability { get; set; }
    }
}
