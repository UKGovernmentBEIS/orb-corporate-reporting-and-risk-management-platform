using System;
using System.Collections.Generic;

namespace ORB.Core.Models
{
    public class ProjectPhase : Entity
    {
        public ProjectPhase()
        {
            ProjectUpdates = new HashSet<ProjectUpdate>();
        }

        public virtual ICollection<ProjectUpdate> ProjectUpdates { get; set; }
    }
}
