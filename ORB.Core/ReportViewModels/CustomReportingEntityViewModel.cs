using System;
using System.Collections.Generic;
using ORB.Core.Models;

namespace ORB.Core.ReportViewModels
{
    public class CustomReportingEntityViewModel : ReportingEntityViewModel
    {
        public int ReportingEntityTypeID { get; set; }
        public int? DirectorateID { get; set; }
        public int? ProjectID { get; set; }
        public int? PartnerOrganisationID { get; set; }
        public int? LeadUserID { get; set; }
        public DateTime? CreatedDate { get; set; }
        public int? MeasurementUnitID { get; set; }
        public decimal? TargetPerformanceUpperLimit { get; set; }
        public decimal? TargetPerformanceLowerLimit { get; set; }
        public DateTime? BaselineDate { get; set; }
        public DateTime? ForecastDate { get; set; }
        public DateTime? ActualDate { get; set; }
        public IDictionary<string, object> Properties { get; set; }

        public UserViewModel LeadUser { get; set; }
        public Entity MeasurementUnit { get; set; }
        public ICollection<CustomReportingEntityAttributeViewModel> Attributes { get; set; }
        public ICollection<CustomReportingEntityContributorViewModel> Contributors { get; set; }
        public ICollection<CustomReportingEntityUpdateViewModel> ReportingEntityUpdates { get; set; }
    }
}
