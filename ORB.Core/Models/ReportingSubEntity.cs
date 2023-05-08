using System;
using System.Collections.Generic;

namespace ORB.Core.Models
{
    public abstract class ReportingSubEntity : ReportingEntity
    {
        public int? LeadUserID { get; set; }

        public virtual User LeadUser { get; set; }
    }
}
