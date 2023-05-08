using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;

namespace ORB.Core.Models
{
    public partial class RiskImpactLevel : Entity
    {
        public RiskImpactLevel()
        {
            PartnerOrganisationRiskBeistargetRiskImpactLevels = new HashSet<PartnerOrganisationRisk>();
            PartnerOrganisationRiskBeisunmitigatedRiskImpactLevels = new HashSet<PartnerOrganisationRisk>();
            PartnerOrganisationRiskTargetRiskImpactLevels = new HashSet<PartnerOrganisationRisk>();
            PartnerOrganisationRiskUnmitigatedRiskImpactLevels = new HashSet<PartnerOrganisationRisk>();
            PartnerOrganisationRiskUpdateBeisRiskImpactLevels = new HashSet<PartnerOrganisationRiskUpdate>();
            PartnerOrganisationRiskUpdateRiskImpactLevels = new HashSet<PartnerOrganisationRiskUpdate>();
            RagOptionsMappings = new HashSet<RagOptionsMapping>();
            CorporateRiskTargetRiskImpactLevels = new HashSet<CorporateRisk>();
            CorporateRiskUnmitigatedRiskImpactLevels = new HashSet<CorporateRisk>();
            CorporateRiskUpdates = new HashSet<CorporateRiskUpdate>();
            FinancialRiskTargetRiskImpactLevels = new HashSet<FinancialRisk>();
            FinancialRiskUnmitigatedRiskImpactLevels = new HashSet<FinancialRisk>();
            FinancialRiskUpdates = new HashSet<FinancialRiskUpdate>();
            ThresholdAppetites = new HashSet<ThresholdAppetite>();
        }

        public string Description { get; set; }
        public DateTime? StartUpdatePeriod { get; set; }
        public DateTime? EndUpdatePeriod { get; set; }

        [InverseProperty("BeistargetRiskImpactLevel")]
        public virtual ICollection<PartnerOrganisationRisk> PartnerOrganisationRiskBeistargetRiskImpactLevels { get; set; }
        [InverseProperty("BeisunmitigatedRiskImpactLevel")]
        public virtual ICollection<PartnerOrganisationRisk> PartnerOrganisationRiskBeisunmitigatedRiskImpactLevels { get; set; }
        [InverseProperty("TargetRiskImpactLevel")]
        public virtual ICollection<PartnerOrganisationRisk> PartnerOrganisationRiskTargetRiskImpactLevels { get; set; }
        [InverseProperty("UnmitigatedRiskImpactLevel")]
        public virtual ICollection<PartnerOrganisationRisk> PartnerOrganisationRiskUnmitigatedRiskImpactLevels { get; set; }
        [InverseProperty("BeisRiskImpactLevel")]
        public virtual ICollection<PartnerOrganisationRiskUpdate> PartnerOrganisationRiskUpdateBeisRiskImpactLevels { get; set; }
        [InverseProperty("RiskImpactLevel")]
        public virtual ICollection<PartnerOrganisationRiskUpdate> PartnerOrganisationRiskUpdateRiskImpactLevels { get; set; }
        public virtual ICollection<RagOptionsMapping> RagOptionsMappings { get; set; }
        [InverseProperty("TargetRiskImpactLevel")]
        public virtual ICollection<CorporateRisk> CorporateRiskTargetRiskImpactLevels { get; set; }
        [InverseProperty("UnmitigatedRiskImpactLevel")]
        public virtual ICollection<CorporateRisk> CorporateRiskUnmitigatedRiskImpactLevels { get; set; }
        public virtual ICollection<CorporateRiskUpdate> CorporateRiskUpdates { get; set; }
        [InverseProperty("TargetRiskImpactLevel")]
        public virtual ICollection<FinancialRisk> FinancialRiskTargetRiskImpactLevels { get; set; }
        [InverseProperty("UnmitigatedRiskImpactLevel")]
        public virtual ICollection<FinancialRisk> FinancialRiskUnmitigatedRiskImpactLevels { get; set; }
        public virtual ICollection<FinancialRiskUpdate> FinancialRiskUpdates { get; set; }
        public virtual ICollection<ThresholdAppetite> ThresholdAppetites { get; set; }
    }
}
