using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ORB.Core.ReportViewModels
{
    public class PartnerOrganisationUpdateViewModel : EntityUpdateViewModel
    {
        public string Comment { get; set; }
        public int? RagOptionID { get; set; }
        public int? PartnerOrganisationID { get; set; }
        public int? OverallRagOptionID { get; set; }
        public int? FinanceRagOptionID { get; set; }
        public string FinanceComment { get; set; }
        public int? PeopleRagOptionID { get; set; }
        public string PeopleComment { get; set; }
        public int? MilestonesRagOptionID { get; set; }
        public string MilestonesComment { get; set; }
        public int? KPIRagOptionID { get; set; }
        public string KPIComment { get; set; }
        public string ProgressUpdate { get; set; }
        public string FutureActions { get; set; }
        public string Escalations { get; set; }
        public int? SignOffID { get; set; }
        public bool? ToBeClosed { get; set; }
        public DateTime? UpdatePeriod { get; set; }
    }
}
