using System;
using System.Collections.Generic;
using System.Linq;
using ORB.Core.Models;

namespace ORB.Core.ReportViewModels
{
    public abstract class MilestoneViewModel : ReportingEntityViewModel
    {
        public string MilestoneCode { get; set; }
        public DateTime? BaselineDate { get; set; }
        public DateTime? ForecastDate { get; set; }
        public DateTime? ActualDate { get; set; }
        public int? MilestoneTypeID { get; set; }
        public int? LeadUserID { get; set; }
        public int? RagOptionID { get; set; }
        public DateTime? StartDate { get; set; }

        public UserViewModel LeadUser { get; set; }
        public ICollection<MilestoneAttributeViewModel> Attributes { get; set; }
        public ICollection<MilestoneUpdateViewModel> MilestoneUpdates { get; set; }
    }
}
