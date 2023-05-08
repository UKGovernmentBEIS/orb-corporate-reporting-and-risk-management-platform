using System;
using System.Collections.Generic;

namespace ORB.Core.Models
{
    public class CustomReportingEntity : ReportingSubEntity
    {
        public CustomReportingEntity()
        {
            ReportingEntityUpdates = new HashSet<CustomReportingEntityUpdate>();
        }

        public int ReportingEntityTypeID { get; set; }
        public int? DirectorateID { get; set; }
        public int? ProjectID { get; set; }
        public int? PartnerOrganisationID { get; set; }
        public DateTime? CreatedDate { get; set; }
        public int? MeasurementUnitID { get; set; }
        public decimal? TargetPerformanceUpperLimit { get; set; }
        public decimal? TargetPerformanceLowerLimit { get; set; }
        public DateTime? BaselineDate { get; set; }
        public DateTime? ForecastDate { get; set; }
        public DateTime? ActualDate { get; set; }
        public IDictionary<string, object> Properties { get; set; }

        public virtual CustomReportingEntityType ReportingEntityType { get; set; }
        public virtual Directorate Directorate { get; set; }
        public virtual Project Project { get; set; }
        public virtual PartnerOrganisation PartnerOrganisation { get; set; }
        public virtual MeasurementUnit MeasurementUnit { get; set; }
        public virtual ICollection<CustomReportingEntityUpdate> ReportingEntityUpdates { get; set; }
    }
}
