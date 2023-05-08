using System;
using System.Collections.Generic;
using System.Linq;
using ORB.Core.Models;

namespace ORB.Core.ReportViewModels
{
    public class WorkStreamViewModel : ReportingEntityViewModel
    {
        public string WorkStreamCode { get; set; }
        public int ProjectID { get; set; }
        public int? LeadUserID { get; set; }
        public int? RagOptionID { get; set; }
        public int? ModifiedByUserID { get; set; }

        public UserViewModel LeadUser { get; set; }
        public ICollection<WorkStreamAttributeViewModel> Attributes { get; set; }
        public ICollection<WorkStreamUpdateViewModel> WorkStreamUpdates { get; set; }
    }
}
