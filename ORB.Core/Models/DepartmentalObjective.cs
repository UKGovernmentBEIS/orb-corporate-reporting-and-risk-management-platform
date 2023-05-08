using System;
using System.Collections.Generic;

namespace ORB.Core.Models
{
    public partial class DepartmentalObjective : Entity
    {
        public DepartmentalObjective()
        {
            PartnerOrganisationRisks = new HashSet<PartnerOrganisationRisk>();
            Risks = new HashSet<CorporateRisk>();
        }

        public virtual ICollection<PartnerOrganisationRisk> PartnerOrganisationRisks { get; set; }
        public virtual ICollection<CorporateRisk> Risks { get; set; }
    }
}
