using System;

namespace ORB.Core.Models
{
    public partial class ReportStaging : Entity
    {
        public int ProjectID { get; set; }
        public string ReportJson { get; set; }
        public int SubmittedByUserID { get; set; }
        public DateTime SubmittedDate { get; set; }

        public virtual Project Project { get; set; }
        public virtual User SubmittedByUser { get; set; }
    }
}
