using System;
using System.Collections.Generic;
using System.Linq;

namespace ORB.Core.ReportViewModels
{
    public class PartnerOrganisationRiskMitigationActionViewModel : ReportingEntityViewModel
    {
        public int? PartnerOrganisationRiskID { get; set; }
        public int? RiskMitigationActionCode { get; set; }
        public DateTime? BaselineDate { get; set; }
        public DateTime? ForecastDate { get; set; }
        public DateTime? ActualDate { get; set; }
        public int? OwnerUserID { get; set; }
        public bool? ActionIsOngoing { get; set; }
        public int? ModifiedByUserID { get; set; }

        public ICollection<PartnerOrganisationRiskMitigationActionUpdateViewModel> PartnerOrganisationRiskMitigationActionUpdates { get; set; }
        public UserViewModel OwnerUser { get; set; }
    }
}
