using ORB.Core.Models;
using System;
using System.Collections.Generic;

namespace ORB.Core.ReportViewModels
{
    public class ProjectViewModel : ReportingEntityViewModel
    {
        public int? SeniorResponsibleOwnerUserID { get; set; }
        public int? ProjectManagerUserID { get; set; }
        public string Objectives { get; set; }
        public DateTime? StartDate { get; set; }
        public DateTime? EndDate { get; set; }
        public int? DirectorateID { get; set; }
        public int? ModifiedByUserID { get; set; }
        public int? ReportApproverUserID { get; set; }
        public bool? ShowOnDirectorateReport { get; set; }
        public int? ParentProjectID { get; set; }
        public int? ReportingLeadUserID { get; set; }

        public UserViewModel SeniorResponsibleOwnerUser { get; set; }
        public ICollection<ProjectAttributeViewModel> Attributes { get; set; }
        public ICollection<ProjectUpdateViewModel> ProjectUpdates { get; set; }
    }
}
