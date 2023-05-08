using System.Collections.Generic;

namespace ORB.Core.ReportViewModels
{
    public class RiskDirectorateViewModel : ReportingEntityViewModel
    {
        public int GroupID { get; set; }
        public int? DirectorUserID { get; set; }
        public string Objectives { get; set; }
        public int? ModifiedByUserID { get; set; }
        public int? ReportApproverUserID { get; set; }
        public int? ReportingLeadUserID { get; set; }

        public RiskGroupViewModel Group { get; set; }
    }
}