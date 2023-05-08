using System;
using System.Collections.Generic;

namespace ORB.Core.Models
{
    public class WorkStream : ReportingSubEntity
    {
        public WorkStream()
        {
            Milestones = new HashSet<Milestone>();
            WorkStreamUpdates = new HashSet<WorkStreamUpdate>();
        }

        public string WorkStreamCode { get; set; }
        public int ProjectID { get; set; }
        public int? RagOptionID { get; set; }

        public virtual Project Project { get; set; }
        public virtual RagOption RagOption { get; set; }
        public virtual ICollection<Milestone> Milestones { get; set; }
        public virtual ICollection<WorkStreamUpdate> WorkStreamUpdates { get; set; }
    }
}
