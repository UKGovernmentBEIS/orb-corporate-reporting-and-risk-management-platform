using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;

namespace ORB.Core.Models
{
    public partial class User : EntityWithStatus
    {
        public User()
        {
            Attributes = new HashSet<ORB.Core.Models.Attribute>();
            BenefitLeadUsers = new HashSet<Benefit>();
            BenefitModifiedByUsers = new HashSet<Benefit>();
            BenefitUpdates = new HashSet<BenefitUpdate>();
            CommitmentLeadUsers = new HashSet<Commitment>();
            CommitmentModifiedByUsers = new HashSet<Commitment>();
            CommitmentUpdates = new HashSet<CommitmentUpdate>();
            ContributorContributorUsers = new HashSet<Contributor>();
            ContributorModifiedByUsers = new HashSet<Contributor>();
            CorporateRiskMitigationActionUpdates = new HashSet<CorporateRiskMitigationActionUpdate>();
            CorporateRiskModifiedByUsers = new HashSet<CorporateRisk>();
            CorporateRiskReportApproverUsers = new HashSet<CorporateRisk>();
            CorporateRiskRiskOwnerUsers = new HashSet<CorporateRisk>();
            CorporateRiskUpdates = new HashSet<CorporateRiskUpdate>();
            DependencyLeadUsers = new HashSet<Dependency>();
            DependencyModifiedByUsers = new HashSet<Dependency>();
            DependencyUpdates = new HashSet<DependencyUpdate>();
            DirectorateDirectorUsers = new HashSet<Directorate>();
            DirectorateModifiedByUsers = new HashSet<Directorate>();
            DirectorateReportApproverUsers = new HashSet<Directorate>();
            DirectorateReportingLeadUsers = new HashSet<Directorate>();
            DirectorateUpdates = new HashSet<DirectorateUpdate>();
            FinancialRiskMitigationActionUpdates = new HashSet<FinancialRiskMitigationActionUpdate>();
            FinancialRiskModifiedByUsers = new HashSet<FinancialRisk>();
            FinancialRiskReportApproverUsers = new HashSet<FinancialRisk>();
            FinancialRiskRiskOwnerUsers = new HashSet<FinancialRisk>();
            FinancialRiskUpdates = new HashSet<FinancialRiskUpdate>();
            FinancialRiskUserGroupModifiedByUsers = new HashSet<FinancialRiskUserGroup>();
            FinancialRiskUserGroups = new HashSet<FinancialRiskUserGroup>();
            GroupBusinessPartnerUsers = new HashSet<Group>();
            GroupDirectorGeneralUsers = new HashSet<Group>();
            GroupModifiedByUsers = new HashSet<Group>();
            GroupRiskChampionDeputyDirectorUsers = new HashSet<Group>();
            UsersModifiedByUser = new HashSet<User>();
            KeyWorkAreaLeadUsers = new HashSet<KeyWorkArea>();
            KeyWorkAreaModifiedByUsers = new HashSet<KeyWorkArea>();
            KeyWorkAreaUpdates = new HashSet<KeyWorkAreaUpdate>();
            MetricLeadUsers = new HashSet<Metric>();
            MetricModifiedByUsers = new HashSet<Metric>();
            MetricUpdates = new HashSet<MetricUpdate>();
            MilestoneLeadUsers = new HashSet<Milestone>();
            MilestoneModifiedByUsers = new HashSet<Milestone>();
            MilestoneUpdates = new HashSet<MilestoneUpdate>();
            PartnerOrganisationLeadPolicySponsorUsers = new HashSet<PartnerOrganisation>();
            PartnerOrganisationModifiedByUsers = new HashSet<PartnerOrganisation>();
            PartnerOrganisationReportAuthorUsers = new HashSet<PartnerOrganisation>();
            PartnerOrganisationRiskBeisRiskOwnerUsers = new HashSet<PartnerOrganisationRisk>();
            PartnerOrganisationRiskMitigationActionModifiedByUsers = new HashSet<PartnerOrganisationRiskMitigationAction>();
            PartnerOrganisationRiskMitigationActionOwnerUsers = new HashSet<PartnerOrganisationRiskMitigationAction>();
            PartnerOrganisationRiskMitigationActionUpdates = new HashSet<PartnerOrganisationRiskMitigationActionUpdate>();
            PartnerOrganisationRiskModifiedByUsers = new HashSet<PartnerOrganisationRisk>();
            PartnerOrganisationRiskRiskOwnerUsers = new HashSet<PartnerOrganisationRisk>();
            PartnerOrganisationRiskRiskTypes = new HashSet<PartnerOrganisationRiskRiskType>();
            PartnerOrganisationRiskUpdates = new HashSet<PartnerOrganisationRiskUpdate>();
            PartnerOrganisationUpdates = new HashSet<PartnerOrganisationUpdate>();
            ProjectModifiedByUsers = new HashSet<Project>();
            ProjectProjectManagerUsers = new HashSet<Project>();
            ProjectReportApproverUsers = new HashSet<Project>();
            ProjectReportingLeadUsers = new HashSet<Project>();
            ProjectSeniorResponsibleOwnerUsers = new HashSet<Project>();
            ProjectUpdates = new HashSet<ProjectUpdate>();
            ReportSubmittedByUsers = new HashSet<ReportStaging>();
            RiskMitigationActionModifiedByUsers = new HashSet<RiskMitigationAction>();
            RiskMitigationActionOwnerUsers = new HashSet<RiskMitigationAction>();
            SignOffs = new HashSet<SignOff>();
            UserDirectorateModifiedByUsers = new HashSet<UserDirectorate>();
            UserDirectorates = new HashSet<UserDirectorate>();
            UserGroupModifiedByUsers = new HashSet<UserGroup>();
            UserGroups = new HashSet<UserGroup>();
            UserPartnerOrganisationModifiedByUsers = new HashSet<UserPartnerOrganisation>();
            UserPartnerOrganisations = new HashSet<UserPartnerOrganisation>();
            UserProjectModifiedByUsers = new HashSet<UserProject>();
            UserProjects = new HashSet<UserProject>();
            UserRoleModifiedByUsers = new HashSet<UserRole>();
            UserRoles = new HashSet<UserRole>();
            WorkStreamLeadUsers = new HashSet<WorkStream>();
            WorkStreamModifiedByUsers = new HashSet<WorkStream>();
            WorkStreamUpdates = new HashSet<WorkStreamUpdate>();
        }

        public string Username { get; set; }
        public string EmailAddress { get; set; }
        public DateTime? CreatedDate { get; set; }
        public bool? IsServiceAccount { get; set; }

        public virtual ICollection<ORB.Core.Models.Attribute> Attributes { get; set; }
        [InverseProperty("LeadUser")]
        public virtual ICollection<Benefit> BenefitLeadUsers { get; set; }
        [InverseProperty("ModifiedByUser")]
        public virtual ICollection<Benefit> BenefitModifiedByUsers { get; set; }
        public virtual ICollection<BenefitUpdate> BenefitUpdates { get; set; }
        [InverseProperty("LeadUser")]
        public virtual ICollection<Commitment> CommitmentLeadUsers { get; set; }
        [InverseProperty("ModifiedByUser")]
        public virtual ICollection<Commitment> CommitmentModifiedByUsers { get; set; }
        public virtual ICollection<CommitmentUpdate> CommitmentUpdates { get; set; }
        [InverseProperty("ContributorUser")]
        public virtual ICollection<Contributor> ContributorContributorUsers { get; set; }
        [InverseProperty("ModifiedByUser")]
        public virtual ICollection<Contributor> ContributorModifiedByUsers { get; set; }
        public virtual ICollection<CorporateRiskMitigationActionUpdate> CorporateRiskMitigationActionUpdates { get; set; }
        [InverseProperty("ModifiedByUser")]
        public virtual ICollection<CorporateRisk> CorporateRiskModifiedByUsers { get; set; }
        [InverseProperty("ReportApproverUser")]
        public virtual ICollection<CorporateRisk> CorporateRiskReportApproverUsers { get; set; }
        [InverseProperty("RiskOwnerUser")]
        public virtual ICollection<CorporateRisk> CorporateRiskRiskOwnerUsers { get; set; }
        public virtual ICollection<CorporateRiskUpdate> CorporateRiskUpdates { get; set; }
        [InverseProperty("LeadUser")]
        public virtual ICollection<Dependency> DependencyLeadUsers { get; set; }
        [InverseProperty("ModifiedByUser")]
        public virtual ICollection<Dependency> DependencyModifiedByUsers { get; set; }
        public virtual ICollection<DependencyUpdate> DependencyUpdates { get; set; }
        [InverseProperty("DirectorUser")]
        public virtual ICollection<Directorate> DirectorateDirectorUsers { get; set; }
        [InverseProperty("ModifiedByUser")]
        public virtual ICollection<Directorate> DirectorateModifiedByUsers { get; set; }
        [InverseProperty("ReportApproverUser")]
        public virtual ICollection<Directorate> DirectorateReportApproverUsers { get; set; }
        [InverseProperty("ReportingLeadUser")]
        public virtual ICollection<Directorate> DirectorateReportingLeadUsers { get; set; }
        public virtual ICollection<DirectorateUpdate> DirectorateUpdates { get; set; }
        public virtual ICollection<FinancialRiskMitigationActionUpdate> FinancialRiskMitigationActionUpdates { get; set; }
        [InverseProperty("ModifiedByUser")]
        public virtual ICollection<FinancialRisk> FinancialRiskModifiedByUsers { get; set; }
        [InverseProperty("ReportApproverUser")]
        public virtual ICollection<FinancialRisk> FinancialRiskReportApproverUsers { get; set; }
        [InverseProperty("RiskOwnerUser")]
        public virtual ICollection<FinancialRisk> FinancialRiskRiskOwnerUsers { get; set; }
        public virtual ICollection<FinancialRiskUpdate> FinancialRiskUpdates { get; set; }
        [InverseProperty("ModifiedByUser")]
        public virtual ICollection<FinancialRiskUserGroup> FinancialRiskUserGroupModifiedByUsers { get; set; }
        public virtual ICollection<FinancialRiskUserGroup> FinancialRiskUserGroups { get; set; }
        [InverseProperty("BusinessPartnerUser")]
        public virtual ICollection<Group> GroupBusinessPartnerUsers { get; set; }
        [InverseProperty("DirectorGeneralUser")]
        public virtual ICollection<Group> GroupDirectorGeneralUsers { get; set; }
        [InverseProperty("ModifiedByUser")]
        public virtual ICollection<Group> GroupModifiedByUsers { get; set; }
        [InverseProperty("RiskChampionDeputyDirectorUser")]
        public virtual ICollection<Group> GroupRiskChampionDeputyDirectorUsers { get; set; }
        [InverseProperty("ModifiedByUser")]
        public virtual ICollection<User> UsersModifiedByUser { get; set; }
        [InverseProperty("LeadUser")]
        public virtual ICollection<KeyWorkArea> KeyWorkAreaLeadUsers { get; set; }
        [InverseProperty("ModifiedByUser")]
        public virtual ICollection<KeyWorkArea> KeyWorkAreaModifiedByUsers { get; set; }
        public virtual ICollection<KeyWorkAreaUpdate> KeyWorkAreaUpdates { get; set; }
        [InverseProperty("LeadUser")]
        public virtual ICollection<Metric> MetricLeadUsers { get; set; }
        [InverseProperty("ModifiedByUser")]
        public virtual ICollection<Metric> MetricModifiedByUsers { get; set; }
        public virtual ICollection<MetricUpdate> MetricUpdates { get; set; }
        [InverseProperty("LeadUser")]
        public virtual ICollection<Milestone> MilestoneLeadUsers { get; set; }
        [InverseProperty("ModifiedByUser")]
        public virtual ICollection<Milestone> MilestoneModifiedByUsers { get; set; }
        public virtual ICollection<MilestoneUpdate> MilestoneUpdates { get; set; }
        [InverseProperty("LeadPolicySponsorUser")]
        public virtual ICollection<PartnerOrganisation> PartnerOrganisationLeadPolicySponsorUsers { get; set; }
        [InverseProperty("ModifiedByUser")]
        public virtual ICollection<PartnerOrganisation> PartnerOrganisationModifiedByUsers { get; set; }
        [InverseProperty("ReportAuthorUser")]
        public virtual ICollection<PartnerOrganisation> PartnerOrganisationReportAuthorUsers { get; set; }
        [InverseProperty("BeisRiskOwnerUser")]
        public virtual ICollection<PartnerOrganisationRisk> PartnerOrganisationRiskBeisRiskOwnerUsers { get; set; }
        public virtual ICollection<PartnerOrganisationRisk> PartnerOrganisationRiskLeadUsers { get; set; }
        [InverseProperty("ModifiedByUser")]
        public virtual ICollection<PartnerOrganisationRiskMitigationAction> PartnerOrganisationRiskMitigationActionModifiedByUsers { get; set; }
        [InverseProperty("OwnerUser")]
        public virtual ICollection<PartnerOrganisationRiskMitigationAction> PartnerOrganisationRiskMitigationActionOwnerUsers { get; set; }
        public virtual ICollection<PartnerOrganisationRiskMitigationActionUpdate> PartnerOrganisationRiskMitigationActionUpdates { get; set; }
        [InverseProperty("ModifiedByUser")]
        public virtual ICollection<PartnerOrganisationRisk> PartnerOrganisationRiskModifiedByUsers { get; set; }
        [InverseProperty("RiskOwnerUser")]
        public virtual ICollection<PartnerOrganisationRisk> PartnerOrganisationRiskRiskOwnerUsers { get; set; }
        public virtual ICollection<PartnerOrganisationRiskRiskType> PartnerOrganisationRiskRiskTypes { get; set; }
        public virtual ICollection<PartnerOrganisationRiskUpdate> PartnerOrganisationRiskUpdates { get; set; }
        public virtual ICollection<PartnerOrganisationUpdate> PartnerOrganisationUpdates { get; set; }
        [InverseProperty("ModifiedByUser")]
        public virtual ICollection<Project> ProjectModifiedByUsers { get; set; }
        [InverseProperty("ProjectManagerUser")]
        public virtual ICollection<Project> ProjectProjectManagerUsers { get; set; }
        [InverseProperty("ReportApproverUser")]
        public virtual ICollection<Project> ProjectReportApproverUsers { get; set; }
        [InverseProperty("ReportingLeadUser")]
        public virtual ICollection<Project> ProjectReportingLeadUsers { get; set; }
        [InverseProperty("SeniorResponsibleOwnerUser")]
        public virtual ICollection<Project> ProjectSeniorResponsibleOwnerUsers { get; set; }
        public virtual ICollection<ProjectUpdate> ProjectUpdates { get; set; }
        [InverseProperty("LeadUser")]
        public virtual ICollection<CustomReportingEntity> ReportingEntityLeadUsers { get; set; }
        [InverseProperty("SubmittedByUser")]
        public virtual ICollection<ReportStaging> ReportSubmittedByUsers { get; set; }
        [InverseProperty("ModifiedByUser")]
        public virtual ICollection<RiskMitigationAction> RiskMitigationActionModifiedByUsers { get; set; }
        [InverseProperty("OwnerUser")]
        public virtual ICollection<RiskMitigationAction> RiskMitigationActionOwnerUsers { get; set; }
        public virtual ICollection<SignOff> SignOffs { get; set; }
        [InverseProperty("ModifiedByUser")]
        public virtual ICollection<UserDirectorate> UserDirectorateModifiedByUsers { get; set; }
        public virtual ICollection<UserDirectorate> UserDirectorates { get; set; }
        [InverseProperty("ModifiedByUser")]
        public virtual ICollection<UserGroup> UserGroupModifiedByUsers { get; set; }
        public virtual ICollection<UserGroup> UserGroups { get; set; }
        [InverseProperty("ModifiedByUser")]
        public virtual ICollection<UserPartnerOrganisation> UserPartnerOrganisationModifiedByUsers { get; set; }
        public virtual ICollection<UserPartnerOrganisation> UserPartnerOrganisations { get; set; }
        [InverseProperty("ModifiedByUser")]
        public virtual ICollection<UserProject> UserProjectModifiedByUsers { get; set; }
        public virtual ICollection<UserProject> UserProjects { get; set; }
        [InverseProperty("ModifiedByUser")]
        public virtual ICollection<UserRole> UserRoleModifiedByUsers { get; set; }
        public virtual ICollection<UserRole> UserRoles { get; set; }
        [InverseProperty("LeadUser")]
        public virtual ICollection<WorkStream> WorkStreamLeadUsers { get; set; }
        [InverseProperty("ModifiedByUser")]
        public virtual ICollection<WorkStream> WorkStreamModifiedByUsers { get; set; }
        public virtual ICollection<WorkStreamUpdate> WorkStreamUpdates { get; set; }
    }
}
