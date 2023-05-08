using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ORB.Core.ReportViewModels
{
    public class PartnerOrganisationRiskMitigationActionUpdateViewModel : EntityUpdateViewModel
    {
        public int? PartnerOrganisationRiskMitigationActionID { get; set; }
        public int? RagOptionID { get; set; }
        public string Comment { get; set; }
        public DateTime? ForecastDate { get; set; }
        public DateTime? ActualDate { get; set; }
        public bool? ToBeClosed { get; set; }
        public DateTime? UpdatePeriod { get; set; }
        public int? SignOffID { get; set; }
    }
}
