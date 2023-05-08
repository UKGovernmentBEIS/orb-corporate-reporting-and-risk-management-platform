using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;

namespace ORB.Core.Models
{
    public class Project : ReportingEntity
    {
        public Project()
        {
            Benefits = new HashSet<Benefit>();
            ChildProjects = new HashSet<Project>();
            Dependencies = new HashSet<Dependency>();
            ProjectUpdates = new HashSet<ProjectUpdate>();
            ReportingEntities = new HashSet<CustomReportingEntity>();
            ReportStagings = new HashSet<ReportStaging>();
            SignOffs = new HashSet<SignOff>();
            UserProjects = new HashSet<UserProject>();
            WorkStreams = new HashSet<WorkStream>();
        }

        public int? SeniorResponsibleOwnerUserID { get; set; }
        public int? ProjectManagerUserID { get; set; }
        public string Objectives { get; set; }
        public DateTime? StartDate { get; set; }
        public DateTime? EndDate { get; set; }
        public int? DirectorateID { get; set; }
        public int? ReportApproverUserID { get; set; }
        public bool? ShowOnDirectorateReport { get; set; }
        public int? ParentProjectID { get; set; }
        public int? ReportingLeadUserID { get; set; }
        public string CorporateProjectID { get; set; }
        public string IntegrationID { get; set; }
        public DateTime? IntegrationLastModified { get; set; }

        public virtual Directorate Directorate { get; set; }
        public virtual Project ParentProject { get; set; }
        public virtual User ProjectManagerUser { get; set; }
        public virtual User ReportApproverUser { get; set; }
        public virtual User ReportingLeadUser { get; set; }
        public virtual User SeniorResponsibleOwnerUser { get; set; }
        public virtual ICollection<Benefit> Benefits { get; set; }
        public virtual ICollection<Project> ChildProjects { get; set; }
        public virtual ICollection<CorporateRisk> CorporateRisks { get; set; }
        public virtual ICollection<Dependency> Dependencies { get; set; }
        public virtual ICollection<FinancialRisk> FinancialRisks { get; set; }
        public virtual ICollection<ProjectUpdate> ProjectUpdates { get; set; }
        [InverseProperty("Project")]
        public virtual ICollection<CustomReportingEntity> ReportingEntities { get; set; }
        public virtual ICollection<ReportStaging> ReportStagings { get; set; }
        public virtual ICollection<SignOff> SignOffs { get; set; }
        public virtual ICollection<UserProject> UserProjects { get; set; }
        public virtual ICollection<WorkStream> WorkStreams { get; set; }
    }
}
