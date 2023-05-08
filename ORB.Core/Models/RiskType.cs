using System;
using System.Collections.Generic;

namespace ORB.Core.Models
{
    public partial class RiskType : Entity
    {
        public RiskType()
        {
            PartnerOrganisationRiskRiskTypes = new HashSet<PartnerOrganisationRiskRiskType>();
            RiskRiskTypes = new HashSet<RiskRiskType>();
        }

        public int? ThresholdID { get; set; }

        public virtual Threshold Threshold { get; set; }
        public virtual ICollection<PartnerOrganisationRiskRiskType> PartnerOrganisationRiskRiskTypes { get; set; }
        public virtual ICollection<RiskRiskType> RiskRiskTypes { get; set; }
    }
}
