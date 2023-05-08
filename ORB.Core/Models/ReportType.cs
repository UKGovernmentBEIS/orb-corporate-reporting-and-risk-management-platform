using System;
using System.Collections.Generic;

namespace ORB.Core.Models
{
    public class ReportType : EntityWithEditor
    {
        public ReportType()
        {
            ReportingEntityTypes = new HashSet<CustomReportingEntityType>();
        }

        public string Description { get; set; }
        public DateTime? CreatedDate { get; set; }

        public virtual ICollection<CustomReportingEntityType> ReportingEntityTypes { get; set; }
    }
}
