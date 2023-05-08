using System;
using System.Collections.Generic;

namespace ORB.Core.Models
{
    public class CustomReportingEntityType : Entity
    {
        public CustomReportingEntityType()
        {
            CustomFields = new HashSet<ReportingField>();
            ReportingEntities = new HashSet<CustomReportingEntity>();
        }

        public string Description { get; set; }
        public DateTime? CreatedDate { get; set; }
        public int ReportTypeID { get; set; }
        public bool? InheritReportSchedule { get; set; }
        public bool? IsHeadlineSection { get; set; }
        public bool? UpdateHasRag { get; set; }
        public bool? UpdateRagIsRequired { get; set; }
        public bool? UpdateHasNarrative { get; set; }
        public bool? UpdateNarrativeIsRequired { get; set; }
        public int? UpdateNarrativeMaxChars { get; set; }
        public bool? UpdateHasDeliveryDates { get; set; }
        public bool? UpdateDeliveryDatesIsRequired { get; set; }
        public bool? HasUpperAndLowerTargets { get; set; }
        public bool? UpdateHasMeasurement { get; set; }
        public bool? UpdateMeasurementIsRequired { get; set; }
        public ICollection<ReportingField> CustomFields { get; set; }

        public virtual ReportType ReportType { get; set; }
        public virtual ICollection<CustomReportingEntity> ReportingEntities { get; set; }
    }
}
