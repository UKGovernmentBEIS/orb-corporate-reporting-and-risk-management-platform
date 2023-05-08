using ORB.Core.Models;
using ORB.Core.Repositories;
using System;
using System.Threading.Tasks;

namespace ORB.Core
{
    public interface IUnitOfWork : IDisposable
    {
        IAttributeRepository Attributes { get; }
        IEntityRepository<AttributeType> AttributeTypes { get; }
        IEntityRepository<Benefit> Benefits { get; }
        IEntityRepository<BenefitType> BenefitTypes { get; }
        IEntityUpdateRepository<BenefitUpdate> BenefitUpdates { get; }
        IEntityRepository<Commitment> Commitments { get; }
        IEntityUpdateRepository<CommitmentUpdate> CommitmentUpdates { get; }
        IContributorRepository Contributors { get; }
        IEntityRepository<CorporateRiskMitigationAction> CorporateRiskMitigationActions { get; }
        IEntityUpdateRepository<CorporateRiskMitigationActionUpdate> CorporateRiskMitigationActionUpdates { get; }
        IRiskRiskMitigationActionRepository<CorporateRiskRiskMitigationAction> CorporateRiskRiskMitigationActions { get; }
        IEntityRepository<CorporateRisk> CorporateRisks { get; }
        IEntityUpdateRepository<CorporateRiskUpdate> CorporateRiskUpdates { get; }
        IEntityRepository<DepartmentalObjective> DepartmentalObjectives { get; }
        IEntityRepository<Dependency> Dependencies { get; }
        IEntityUpdateRepository<DependencyUpdate> DependencyUpdates { get; }
        IEntityRepository<Directorate> Directorates { get; }
        IEntityUpdateRepository<DirectorateUpdate> DirectorateUpdates { get; }
        IEntityRepository<EntityStatus> EntityStatuses { get; }
        IEntityRepository<FinancialRiskMitigationAction> FinancialRiskMitigationActions { get; }
        IEntityUpdateRepository<FinancialRiskMitigationActionUpdate> FinancialRiskMitigationActionUpdates { get; }
        IEntityRepository<FinancialRisk> FinancialRisks { get; }
        IEntityUpdateRepository<FinancialRiskUpdate> FinancialRiskUpdates { get; }
        IUserMappingRepository<FinancialRiskUserGroup> FinancialRiskUserGroups { get; }
        IEntityRepository<Group> Groups { get; }
        IEntityRepository<KeyWorkArea> KeyWorkAreas { get; }
        IEntityUpdateRepository<KeyWorkAreaUpdate> KeyWorkAreaUpdates { get; }
        IEntityRepository<MeasurementUnit> MeasurementUnits { get; }
        IEntityRepository<Metric> Metrics { get; }
        IEntityUpdateRepository<MetricUpdate> MetricUpdates { get; }
        IEntityRepository<Milestone> Milestones { get; }
        IEntityRepository<MilestoneType> MilestoneTypes { get; }
        IEntityUpdateRepository<MilestoneUpdate> MilestoneUpdates { get; }
        IEntityRepository<PartnerOrganisation> PartnerOrganisations { get; }
        IEntityRepository<PartnerOrganisationRiskMitigationAction> PartnerOrganisationRiskMitigationActions { get; }
        IEntityUpdateRepository<PartnerOrganisationRiskMitigationActionUpdate> PartnerOrganisationRiskMitigationActionUpdates { get; }
        IPartnerOrganisationRiskRiskTypeRepository PartnerOrganisationRiskRiskTypes { get; }
        IEntityRepository<PartnerOrganisationRisk> PartnerOrganisationRisks { get; }
        IEntityUpdateRepository<PartnerOrganisationRiskUpdate> PartnerOrganisationRiskUpdates { get; }
        IEntityUpdateRepository<PartnerOrganisationUpdate> PartnerOrganisationUpdates { get; }
        IEntityRepository<ProjectBusinessCaseType> ProjectBusinessCaseTypes { get; }
        IEntityRepository<ProjectPhase> ProjectPhases { get; }
        IEntityRepository<Project> Projects { get; }
        IEntityUpdateRepository<ProjectUpdate> ProjectUpdates { get; }
        IEntityRepository<RagOption> RagOptions { get; }
        IEntityRepository<CustomReportingEntity> ReportingEntities { get; }
        IEntityRepository<CustomReportingEntityType> ReportingEntityTypes { get; }
        IEntityUpdateRepository<CustomReportingEntityUpdate> ReportingEntityUpdates { get; }
        IEntityRepository<ReportingFrequency> ReportingFrequencies { get; }
        IReportStagingRepository ReportStagings { get; }
        IEntityRepository<RiskAppetite> RiskAppetites { get; }
        IEntityRepository<RiskDiscussionForum> RiskDiscussionForums { get; }
        IEntityRepository<RiskImpactLevel> RiskImpactLevels { get; }
        IEntityRepository<RiskProbability> RiskProbabilities { get; }
        IEntityRepository<RiskRegister> RiskRegisters { get; }
        IRiskRiskTypeRepository RiskRiskTypes { get; }
        IEntityRepository<RiskType> RiskTypes { get; }
        IEntityRepository<Role> Roles { get; }
        ISignOffRepository SignOffs { get; }
        IEntityRepository<Threshold> Thresholds { get; }
        IThresholdAppetiteRepository ThresholdAppetites { get; }
        IUserMappingRepository<UserDirectorate> UserDirectorates { get; }
        IUserMappingRepository<UserGroup> UserGroups { get; }
        IUserMappingRepository<UserPartnerOrganisation> UserPartnerOrganisations { get; }
        IUserMappingRepository<UserProject> UserProjects { get; }
        IUserRepository Users { get; }
        IUserMappingRepository<UserRole> UserRoles { get; }
        IEntityRepository<WorkStream> WorkStreams { get; }
        IEntityUpdateRepository<WorkStreamUpdate> WorkStreamUpdates { get; }
        IEntityRepository<HealthCheckAlert> HealthCheckAlerts { get; }
        Task<int> SaveChanges();
    }
}