using System;
using System.Collections.Generic;

namespace ORB.Core.Models
{
    public partial class KeyWorkArea : ReportingSubEntity
    {
        public KeyWorkArea()
        {
            KeyWorkAreaUpdates = new HashSet<KeyWorkAreaUpdate>();
            Milestones = new HashSet<Milestone>();
        }

        public int DirectorateID { get; set; }
        public int? RagOptionID { get; set; }

        public virtual Directorate Directorate { get; set; }
        public virtual RagOption RagOption { get; set; }
        public virtual ICollection<KeyWorkAreaUpdate> KeyWorkAreaUpdates { get; set; }
        public virtual ICollection<Milestone> Milestones { get; set; }
    }
}
