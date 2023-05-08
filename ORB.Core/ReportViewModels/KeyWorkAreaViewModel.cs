using System;
using System.Collections.Generic;

namespace ORB.Core.ReportViewModels
{
    public class KeyWorkAreaViewModel : ReportingEntityViewModel
    {
        public int DirectorateID { get; set; }
        public int? LeadUserID { get; set; }
        public int? RagOptionID { get; set; }

        public UserViewModel LeadUser { get; set; }
        public RagOptionViewModel RagOption { get; set; }
        public ICollection<KeyWorkAreaAttributeViewModel> Attributes { get; set; }
        public ICollection<KeyWorkAreaContributorViewModel> Contributors { get; set; }
        public ICollection<KeyWorkAreaUpdateViewModel> KeyWorkAreaUpdates { get; set; }
    }
}
