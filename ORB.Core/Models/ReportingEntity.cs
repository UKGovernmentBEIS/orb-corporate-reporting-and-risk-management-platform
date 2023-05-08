using System;
using System.Collections.Generic;

namespace ORB.Core.Models
{
    public abstract class ReportingEntity : EntityWithStatus, IReportingCycle
    {
        protected ReportingEntity()
        {
            Attributes = new HashSet<ORB.Core.Models.Attribute>();
            Contributors = new HashSet<Contributor>();
        }

        public string Description { get; set; }
        public byte? ReportingFrequency { get; set; }
        public byte? ReportingDueDay { get; set; }
        public DateTime? ReportingStartDate { get; set; }

        public virtual ICollection<Contributor> Contributors { get; set; }
        public virtual ICollection<ORB.Core.Models.Attribute> Attributes { get; set; }
    }
}
