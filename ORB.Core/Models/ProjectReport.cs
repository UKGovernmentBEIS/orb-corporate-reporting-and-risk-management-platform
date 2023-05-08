using System;
using System.Collections.Generic;
using System.Text;

namespace ORB.Core.Models
{
    public class ProjectReport
    {
        public ProjectUpdate ProjectUpdate { get; set; }
        public ICollection<WorkStreamUpdate> WorkStreamUpdates { get; set; }
        public ICollection<MilestoneUpdate> MilestoneUpdates { get; set; }
        public ICollection<BenefitUpdate> BenefitUpdates { get; set; }
        public ICollection<DependencyUpdate> DependencyUpdates { get; set; }
    }
}
