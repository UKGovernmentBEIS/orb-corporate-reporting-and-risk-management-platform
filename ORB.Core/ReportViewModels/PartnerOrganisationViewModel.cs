using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ORB.Core.ReportViewModels
{
    public class PartnerOrganisationViewModel : ReportingEntityViewModel
    {
        public int DirectorateID { get; set; }
        public int? LeadPolicySponsorUserID { get; set; }
        public int? ReportAuthorUserID { get; set; }
        public int? ModifiedByUserID { get; set; }
        public string Objectives { get; set; }
        public DateTime? CreatedDate { get; set; }

        public ICollection<PartnerOrganisationUpdateViewModel> PartnerOrganisationUpdates { get; set; }
    }
}
