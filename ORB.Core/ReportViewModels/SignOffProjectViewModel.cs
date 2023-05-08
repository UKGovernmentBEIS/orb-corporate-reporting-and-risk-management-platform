using System.Collections.Generic;

namespace ORB.Core.ReportViewModels
{
    public class SignOffProjectViewModel
    {
        public ProjectViewModel Project { get; set; }
        public ICollection<BenefitViewModel> Benefits { get; set; }
        public ICollection<DependencyViewModel> Dependencies { get; set; }
        public ICollection<ProjectMilestoneViewModel> Milestones { get; set; }
        public ICollection<WorkStreamViewModel> WorkStreams { get; set; }
        public ICollection<ProjectViewModel> Projects { get; set; }
        public ICollection<CustomReportingEntityTypeViewModel> ReportingEntityTypes { get; set; }
    }

    public class SignOffProjectDto : SignOffDto // Can't get OData to return complex object from $expand...
    {
        public string Project { get; set; }
        public string Benefits { get; set; }
        public string Dependencies { get; set; }
        public string Milestones { get; set; }
        public string WorkStreams { get; set; }
        public string Projects { get; set; }
        public string ReportingEntityTypes { get; set; }
    }
}
