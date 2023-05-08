using System;
using System.Collections.Generic;
using ORB.Core.Models;

namespace ORB.Core.ReportViewModels
{
    public class CustomReportingEntityTypeViewModel : Entity
    {
        public string Description { get; set; }
        public int ReportTypeID { get; set; }
        public bool? IsHeadlineSection { get; set; }
        public bool? UpdateHasRag { get; set; }
        public bool? UpdateHasNarrative { get; set; }
        public bool? UpdateHasDeliveryDates { get; set; }
        public bool? HasUpperAndLowerTargets { get; set; }
        public bool? UpdateHasMeasurement { get; set; }
        public ICollection<ReportingFieldViewModel> CustomFields { get; set; }

        public ICollection<CustomReportingEntityViewModel> ReportingEntities { get; set; }
    }
}
