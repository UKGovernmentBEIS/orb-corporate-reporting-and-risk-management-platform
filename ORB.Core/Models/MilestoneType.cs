using System;
using System.Collections.Generic;

namespace ORB.Core.Models
{
    public class MilestoneType : Entity
    {
        public MilestoneType()
        {
            Milestones = new HashSet<Milestone>();
        }

        public virtual ICollection<Milestone> Milestones { get; set; }
    }
}
