using System.Collections.Generic;

namespace ORB.Core.ReportViewModels
{
    public class DirectorateViewModel : ReportingEntityViewModel
    {
        public int GroupID { get; set; }
        public int? DirectorUserID { get; set; }
        public string Objectives { get; set; }
        public int? ModifiedByUserID { get; set; }
        public int? ReportApproverUserID { get; set; }
        public int? ReportingLeadUserID { get; set; }

        public ICollection<DirectorateUpdateViewModel> DirectorateUpdates { get; set; }
        public UserViewModel DirectorUser { get; set; }
        public GroupViewModel Group { get; set; }
        public UserViewModel ReportApproverUser { get; set; }
        public UserViewModel ReportingLeadUser { get; set; }
    }
}