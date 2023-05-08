using System;
using System.Collections.Generic;
using System.Linq;
using ORB.Core.Models;

namespace ORB.Core.ReportViewModels
{
    public class DependencyViewModel : ReportingEntityViewModel
    {
        public int ProjectID { get; set; }
        public string ThirdParty { get; set; }
        public int? RagOptionID { get; set; }
        public int? LeadUserID { get; set; }
        public int? ModifiedByUserID { get; set; }
        public DateTime? StartDate { get; set; }
        public DateTime? EndDate { get; set; }
        public DateTime? BaselineDate { get; set; }
        public DateTime? ForecastDate { get; set; }
        public DateTime? ActualDate { get; set; }

        public UserViewModel LeadUser { get; set; }
        public ICollection<DependencyUpdateViewModel> DependencyUpdates { get; set; }
        public ICollection<DependencyAttributeViewModel> Attributes { get; set; }
    }
}
