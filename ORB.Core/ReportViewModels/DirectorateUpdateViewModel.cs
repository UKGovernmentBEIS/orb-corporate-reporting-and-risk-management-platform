using System;
using System.Collections.Generic;

namespace ORB.Core.ReportViewModels
{
    public class DirectorateUpdateViewModel : EntityUpdateViewModel
    {
        public string Comment { get; set; }
        public int? RagOptionID { get; set; }
        public int? DirectorateID { get; set; }
        public int? OverallRagOptionID { get; set; }
        public int? FinanceRagOptionID { get; set; }
        public string FinanceComment { get; set; }
        public int? PeopleRagOptionID { get; set; }
        public string PeopleComment { get; set; }
        public int? MilestonesRagOptionID { get; set; }
        public string MilestonesComment { get; set; }
        public int? MetricsRagOptionID { get; set; }
        public string MetricsComment { get; set; }
        public string ProgressUpdate { get; set; }
        public string FutureActions { get; set; }
        public string Escalations { get; set; }
        public bool? ToBeClosed { get; set; }
        public DateTime? UpdatePeriod { get; set; }

        public virtual RagOptionViewModel FinanceRagOption { get; set; }
        public virtual RagOptionViewModel MetricsRagOption { get; set; }
        public virtual RagOptionViewModel MilestonesRagOption { get; set; }
        public virtual RagOptionViewModel OverallRagOption { get; set; }
        public virtual RagOptionViewModel PeopleRagOption { get; set; }
    }
}
