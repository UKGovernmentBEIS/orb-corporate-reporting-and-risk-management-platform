using System;
using System.Collections.Generic;

namespace ORB.Core.ReportViewModels
{
    public class CommitmentViewModel : ReportingEntityViewModel
    {
        public int DirectorateID { get; set; }
        public DateTime? BaselineDate { get; set; }
        public DateTime? ForecastDate { get; set; }
        public DateTime? ActualDate { get; set; }
        public int? RagOptionID { get; set; }
        public int? LeadUserID { get; set; }

        public UserViewModel LeadUser { get; set; }
        public ICollection<CommitmentAttributeViewModel> Attributes { get; set; }
        public ICollection<CommitmentUpdateViewModel> CommitmentUpdates { get; set; }
    }
}
