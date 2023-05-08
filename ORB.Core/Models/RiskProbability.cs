using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;

namespace ORB.Core.Models
{
    public partial class RiskProbability : Entity
    {
        public RiskProbability()
        {
            PartnerOrganisationRiskBeistargetRiskProbabilities = new HashSet<PartnerOrganisationRisk>();
            PartnerOrganisationRiskBeisunmitigatedRiskProbabilities = new HashSet<PartnerOrganisationRisk>();
            PartnerOrganisationRiskTargetRiskProbabilities = new HashSet<PartnerOrganisationRisk>();
            PartnerOrganisationRiskUnmitigatedRiskProbabilities = new HashSet<PartnerOrganisationRisk>();
            PartnerOrganisationRiskUpdateBeisRiskProbabilities = new HashSet<PartnerOrganisationRiskUpdate>();
            PartnerOrganisationRiskUpdateRiskProbabilities = new HashSet<PartnerOrganisationRiskUpdate>();
            RagOptionsMappings = new HashSet<RagOptionsMapping>();
            CorporateRiskTargetRiskProbabilities = new HashSet<CorporateRisk>();
            CorporateRiskUnmitigatedRiskProbabilities = new HashSet<CorporateRisk>();
            CorporateRiskUpdates = new HashSet<CorporateRiskUpdate>();
            FinancialRiskTargetRiskProbabilities = new HashSet<FinancialRisk>();
            FinancialRiskUnmitigatedRiskProbabilities = new HashSet<FinancialRisk>();
            FinancialRiskUpdates = new HashSet<FinancialRiskUpdate>();
            ThresholdAppetites = new HashSet<ThresholdAppetite>();
        }

        public DateTime? StartUpdatePeriod { get; set; }
        public DateTime? EndUpdatePeriod { get; set; }

        [InverseProperty("BeistargetRiskProbability")]
        public virtual ICollection<PartnerOrganisationRisk> PartnerOrganisationRiskBeistargetRiskProbabilities { get; set; }
        [InverseProperty("BeisunmitigatedRiskProbability")]
        public virtual ICollection<PartnerOrganisationRisk> PartnerOrganisationRiskBeisunmitigatedRiskProbabilities { get; set; }
        [InverseProperty("TargetRiskProbability")]
        public virtual ICollection<PartnerOrganisationRisk> PartnerOrganisationRiskTargetRiskProbabilities { get; set; }
        [InverseProperty("UnmitigatedRiskProbability")]
        public virtual ICollection<PartnerOrganisationRisk> PartnerOrganisationRiskUnmitigatedRiskProbabilities { get; set; }
        [InverseProperty("BeisRiskProbability")]
        public virtual ICollection<PartnerOrganisationRiskUpdate> PartnerOrganisationRiskUpdateBeisRiskProbabilities { get; set; }
        [InverseProperty("RiskProbability")]
        public virtual ICollection<PartnerOrganisationRiskUpdate> PartnerOrganisationRiskUpdateRiskProbabilities { get; set; }
        public virtual ICollection<RagOptionsMapping> RagOptionsMappings { get; set; }
        [InverseProperty("TargetRiskProbability")]
        public virtual ICollection<CorporateRisk> CorporateRiskTargetRiskProbabilities { get; set; }
        [InverseProperty("UnmitigatedRiskProbability")]
        public virtual ICollection<CorporateRisk> CorporateRiskUnmitigatedRiskProbabilities { get; set; }
        public virtual ICollection<CorporateRiskUpdate> CorporateRiskUpdates { get; set; }
        [InverseProperty("TargetRiskProbability")]
        public virtual ICollection<FinancialRisk> FinancialRiskTargetRiskProbabilities { get; set; }
        [InverseProperty("UnmitigatedRiskProbability")]
        public virtual ICollection<FinancialRisk> FinancialRiskUnmitigatedRiskProbabilities { get; set; }
        public virtual ICollection<FinancialRiskUpdate> FinancialRiskUpdates { get; set; }
        public virtual ICollection<ThresholdAppetite> ThresholdAppetites { get; set; }
    }
}
