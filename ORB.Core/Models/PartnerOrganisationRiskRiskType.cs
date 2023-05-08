using System;
using System.Collections.Generic;

namespace ORB.Core.Models
{
    public partial class PartnerOrganisationRiskRiskType : EntityWithEditor
    {
        public int PartnerOrganisationRiskID { get; set; }
        public int RiskTypeID { get; set; }

        public virtual PartnerOrganisationRisk PartnerOrganisationRisk { get; set; }
        public virtual RiskType RiskType { get; set; }
    }
}
