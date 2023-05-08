using System;
using System.Collections.Generic;

namespace ORB.Core.Models
{
    public class ProjectBusinessCaseType : Entity
    {
        public ProjectBusinessCaseType()
        {
            ProjectUpdates = new HashSet<ProjectUpdate>();
        }

        public virtual ICollection<ProjectUpdate> ProjectUpdates { get; set; }
    }
}
