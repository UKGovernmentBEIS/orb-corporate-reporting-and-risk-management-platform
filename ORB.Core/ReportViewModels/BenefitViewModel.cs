using System;
using System.Collections.Generic;
using System.Linq;
using ORB.Core.Models;

namespace ORB.Core.ReportViewModels
{
    public class BenefitViewModel : ReportingEntityViewModel
    {
        public int ProjectID { get; set; }
        public int? BenefitTypeID { get; set; }
        public int? MeasurementUnitID { get; set; }
        public decimal? TargetPerformanceLowerLimit { get; set; }
        public decimal? TargetPerformanceUpperLimit { get; set; }
        public int? LeadUserID { get; set; }
        public int? RagOptionID { get; set; }
        public int? ModifiedByUserID { get; set; }
        public DateTime? BaselineDate { get; set; }
        public DateTime? ForecastDate { get; set; }

        public ICollection<BenefitUpdateViewModel> BenefitUpdates { get; set; }
        public ICollection<BenefitAttributeViewModel> Attributes { get; set; }
        public Entity BenefitType { get; set; }
        public Entity MeasurementUnit { get; set; }
        public UserViewModel LeadUser { get; set; }
    }
}
