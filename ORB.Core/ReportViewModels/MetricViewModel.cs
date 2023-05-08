using ORB.Core.Models;
using System;
using System.Collections.Generic;

namespace ORB.Core.ReportViewModels
{
    public class MetricViewModel : ReportingEntityViewModel
    {
        public string MetricCode { get; set; }
        public int DirectorateID { get; set; }
        public int? MeasurementUnitID { get; set; }
        public decimal? TargetPerformanceUpperLimit { get; set; }
        public decimal? TargetPerformanceLowerLimit { get; set; }
        public int? LeadUserID { get; set; }
        public int? RagOptionID { get; set; }

        public UserViewModel LeadUser { get; set; }
        public Entity MeasurementUnit { get; set; }
        public ICollection<MetricAttributeViewModel> Attributes { get; set; }
        public ICollection<MetricUpdateViewModel> MetricUpdates { get; set; }
    }
}
