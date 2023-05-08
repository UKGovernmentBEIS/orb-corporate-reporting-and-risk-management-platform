using System;
using ORB.Core.Models;

namespace ORB.Core.ReportViewModels
{
    public partial class ReportStagingDto : Entity
    {
        public int ProjectID { get; set; }
        public string ReportJson { get; set; }
        public int SubmittedByUserID { get; set; }
        public DateTime SubmittedDate { get; set; }
    }
}
