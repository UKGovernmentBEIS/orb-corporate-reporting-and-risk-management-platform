using System;
using System.Collections.Generic;

namespace ORB.Core.Models
{
    public partial class PartnerOrganisationRiskUpdate : EntityUpdate
    {
        public string Comment { get; set; }
        public int? RagOptionID { get; set; }
        public int? BeisRagOptionID { get; set; }
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

        public virtual RagOption BeisRagOption { get; set; }
        public virtual RiskImpactLevel BeisRiskImpactLevel { get; set; }
        public virtual RiskProbability BeisRiskProbability { get; set; }
        public virtual PartnerOrganisationRisk PartnerOrganisationRisk { get; set; }
        public virtual RagOption RagOption { get; set; }
        public virtual RiskImpactLevel RiskImpactLevel { get; set; }
        public virtual RiskProbability RiskProbability { get; set; }
    }
}
