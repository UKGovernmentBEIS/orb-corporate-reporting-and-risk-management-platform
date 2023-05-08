using System;
using System.Collections.Generic;

namespace ORB.Core.Models
{
    public partial class EntityStatus : Entity
    {
        public EntityStatus()
        {
            Benefits = new HashSet<Benefit>();
            Commitments = new HashSet<Commitment>();
            CorporateRiskMitigationActions = new HashSet<CorporateRiskMitigationAction>();
            Dependencies = new HashSet<Dependency>();
            Directorates = new HashSet<Directorate>();
            FinancialRiskMitigationActions = new HashSet<FinancialRiskMitigationAction>();
            Risks = new HashSet<Risk>();
            Groups = new HashSet<Group>();
            KeyWorkAreas = new HashSet<KeyWorkArea>();
            Metrics = new HashSet<Metric>();
            Milestones = new HashSet<Milestone>();
            PartnerOrganisationRiskMitigationActions = new HashSet<PartnerOrganisationRiskMitigationAction>();
            PartnerOrganisationRisks = new HashSet<PartnerOrganisationRisk>();
            PartnerOrganisations = new HashSet<PartnerOrganisation>();
            Projects = new HashSet<Project>();

            Users = new HashSet<User>();
            WorkStreams = new HashSet<WorkStream>();
        }

        public virtual ICollection<Benefit> Benefits { get; set; }
        public virtual ICollection<Commitment> Commitments { get; set; }
        public virtual ICollection<Dependency> Dependencies { get; set; }
        public virtual ICollection<Directorate> Directorates { get; set; }
        public virtual ICollection<Group> Groups { get; set; }
        public virtual ICollection<KeyWorkArea> KeyWorkAreas { get; set; }
        public virtual ICollection<Metric> Metrics { get; set; }
        public virtual ICollection<Milestone> Milestones { get; set; }
        public virtual ICollection<PartnerOrganisationRiskMitigationAction> PartnerOrganisationRiskMitigationActions { get; set; }
        public virtual ICollection<PartnerOrganisationRisk> PartnerOrganisationRisks { get; set; }
        public virtual ICollection<PartnerOrganisation> PartnerOrganisations { get; set; }
        public virtual ICollection<Project> Projects { get; set; }
        public virtual ICollection<CorporateRiskMitigationAction> CorporateRiskMitigationActions { get; set; }
        public virtual ICollection<FinancialRiskMitigationAction> FinancialRiskMitigationActions { get; set; }
        public virtual ICollection<Risk> Risks { get; set; }
        public virtual ICollection<User> Users { get; set; }
        public virtual ICollection<WorkStream> WorkStreams { get; set; }
    }
}
