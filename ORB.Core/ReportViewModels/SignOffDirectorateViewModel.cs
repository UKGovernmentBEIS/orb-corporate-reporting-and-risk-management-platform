using System;
using System.Collections.Generic;

namespace ORB.Core.ReportViewModels
{
    public class SignOffDirectorateViewModel
    {
        public DirectorateViewModel Directorate { get; set; }
        public ICollection<CommitmentViewModel> Commitments { get; set; }
        public ICollection<KeyWorkAreaViewModel> KeyWorkAreas { get; set; }
        public ICollection<DirectorateMilestoneViewModel> Milestones { get; set; }
        public ICollection<MetricViewModel> Metrics { get; set; }
        public ICollection<ProjectViewModel> Projects { get; set; }
        public ICollection<CustomReportingEntityTypeViewModel> ReportingEntityTypes { get; set; }
    }

    public class SignOffDirectorateDto : SignOffDto // Can't get OData to return complex object from $expand...
    {
        public string Directorate { get; set; }
        public string Commitments { get; set; }
        public string KeyWorkAreas { get; set; }
        public string Milestones { get; set; }
        public string Metrics { get; set; }
        public string Projects { get; set; }
        public string ReportingEntityTypes { get; set; }
    }
}