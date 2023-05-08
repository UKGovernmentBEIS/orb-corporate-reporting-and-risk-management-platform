using System.ComponentModel.DataAnnotations.Schema;
using System.Collections.Generic;

namespace ORB.Core.Models
{
    public partial class RiskAppetite : Entity
    {
        public RiskAppetite()
        {
            PartnerOrganisationRiskBeisRiskAppetites = new HashSet<PartnerOrganisationRisk>();
            PartnerOrganisationRiskRiskAppetites = new HashSet<PartnerOrganisationRisk>();
            CorporateRisks = new HashSet<CorporateRisk>();
            FinancialRisks = new HashSet<FinancialRisk>();
        }

        [InverseProperty("BeisRiskAppetite")]
        public virtual ICollection<PartnerOrganisationRisk> PartnerOrganisationRiskBeisRiskAppetites { get; set; }
        [InverseProperty("RiskAppetite")]
        public virtual ICollection<PartnerOrganisationRisk> PartnerOrganisationRiskRiskAppetites { get; set; }
        public virtual ICollection<CorporateRisk> CorporateRisks { get; set; }
        public virtual ICollection<FinancialRisk> FinancialRisks { get; set; }
    }
}
