using System;
using System.Collections.Generic;

namespace ORB.Core.Models
{
    public partial class PartnerOrganisationRiskMitigationAction : ReportingSubEntity
    {
        public PartnerOrganisationRiskMitigationAction()
        {
            PartnerOrganisationRiskMitigationActionUpdates = new HashSet<PartnerOrganisationRiskMitigationActionUpdate>();
        }

        public int PartnerOrganisationRiskID { get; set; }
        public int? RiskMitigationActionCode { get; set; }
        public DateTime? BaselineDate { get; set; }
        public DateTime? ForecastDate { get; set; }
        public DateTime? ActualDate { get; set; }
        public int? OwnerUserID { get; set; }
        public bool? ActionIsOngoing { get; set; }

        public virtual User OwnerUser { get; set; }
        public virtual PartnerOrganisationRisk PartnerOrganisationRisk { get; set; }
        public virtual ICollection<PartnerOrganisationRiskMitigationActionUpdate> PartnerOrganisationRiskMitigationActionUpdates { get; set; }
    }
}
