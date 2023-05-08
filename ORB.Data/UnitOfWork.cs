using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using ORB.Core;
using ORB.Core.Models;
using ORB.Core.Repositories;
using ORB.Data.Repositories;
using System;
using System.Security.Principal;
using System.Threading.Tasks;

namespace ORB.Data
{
    public class UnitOfWork : IUnitOfWork
    {
        private bool disposed = false;
        private readonly OrbContext _context;
        private readonly ApiPrincipal _user;
        private readonly IOptions<UserSettings> _options;
        private AttributeRepository _attributeRepository;
        private AttributeTypeRepository _attributeTypeRepository;
        private BenefitRepository _benefitRepository;
        private BenefitTypeRepository _benefitTypeRepository;
        private BenefitUpdateRepository _benefitUpdateRepository;
        private CommitmentRepository _commitmentRepository;
        private CommitmentUpdateRepository _commitmentUpdateRepository;
        private ContributorRepository _contributorRepository;
        private CorporateRiskMitigationActionRepository _corporateRiskMitigationActionRepository;
        private CorporateRiskMitigationActionUpdateRepository _corporateRiskMitigationActionUpdateRepository;
        private CorporateRiskRepository _corporateRiskRepository;
        private CorporateRiskRiskMitigationActionRepository _corporateRiskRiskMitigationActionRepository;
        private CorporateRiskUpdateRepository _corporateRiskUpdateRepository;
        private DepartmentalObjectiveRepository _departmentalObjectiveRepository;
        private DependencyRepository _dependencyRepository;
        private DependencyUpdateRepository _dependencyUpdateRepository;
        private DirectorateRepository _directorateRepository;
        private DirectorateUpdateRepository _directorateUpdateRepository;
        private EntityStatusRepository _entityStatusRepository;
        private FinancialRiskMitigationActionRepository _financialRiskMitigationActionRepository;
        private FinancialRiskMitigationActionUpdateRepository _financialRiskMitigationActionUpdateRepository;
        private FinancialRiskRepository _financialRiskRepository;
        private FinancialRiskUpdateRepository _financialRiskUpdateRepository;
        private FinancialRiskUserGroupRepository _financialRiskUserGroupRepository;
        private GroupRepository _groupRepository;
        private KeyWorkAreaRepository _keyWorkAreaRepository;
        private KeyWorkAreaUpdateRepository _keyWorkAreaUpdateRepository;
        private MeasurementUnitRepository _measurementUnitRepository;
        private MetricRepository _metricRepository;
        private MetricUpdateRepository _metricUpdateRepository;
        private MilestoneRepository _milestoneRepository;
        private MilestoneTypeRepository _milestoneTypeRepository;
        private MilestoneUpdateRepository _milestoneUpdateRepository;
        private PartnerOrganisationRepository _partnerOrganisationRepository;
        private PartnerOrganisationRiskMitigationActionRepository _partnerOrganisationRiskMitigationActionRepository;
        private PartnerOrganisationRiskMitigationActionUpdateRepository _partnerOrganisationRiskMitigationActionUpdateRepository;
        private PartnerOrganisationRiskRepository _partnerOrganisationRiskRepository;
        private PartnerOrganisationRiskRiskTypeRepository _partnerOrganisationRiskRiskTypeRepository;
        private PartnerOrganisationRiskUpdateRepository _partnerOrganisationRiskUpdateRepository;
        private PartnerOrganisationUpdateRepository _partnerOrganisationUpdateRepository;
        private ProjectBusinessCaseTypeRepository _projectBusinessCaseTypeRepository;
        private ProjectPhaseRepository _projectPhaseRepository;
        private ProjectRepository _projectRepository;
        private ProjectUpdateRepository _projectUpdateRepository;
        private RagOptionRepository _ragOptionRepository;
        private ReportingEntityRepository _reportingEntityRepository;
        private ReportingEntityTypeRepository _reportingEntityTypeRepository;
        private ReportingEntityUpdateRepository _reportingEntityUpdateRepository;
        private ReportingFrequencyRepository _reportingFrequencyRepository;
        private ReportStagingRepository _reportStagingRepository;
        private RiskAppetiteRepository _riskAppetiteRepository;
        private RiskDiscussionForumRepository _riskDiscussionForumRepository;
        private RiskImpactLevelRepository _riskImpactLevelRepository;
        private RiskProbabilityRepository _riskProbabilityRepository;
        private RiskRegisterRepository _riskRegisterRepository;
        private RiskRiskTypeRepository _riskRiskTypeRepository;
        private RiskTypeRepository _riskTypeRepository;
        private RoleRepository _roleRepository;
        private SignOffRepository _signOffRepository;
        private ThresholdRepository _thresholdRepository;
        private ThresholdAppetiteRepository _thresholdAppetiteRepository;
        private UserDirectorateRepository _userDirectorateRepository;
        private UserGroupRepository _userGroupRepository;
        private UserPartnerOrganisationRepository _userPartnerOrganisationRepository;
        private UserProjectRepository _userProjectRepository;
        private UserRepository _userRepository;
        private UserRoleRepository _userRoleRepository;
        private WorkStreamRepository _workStreamRepository;
        private WorkStreamUpdateRepository _workStreamUpdateRepository;
        private HealthCheckAlertRepository _healthCheckAlertRepository;

        public UnitOfWork(OrbContext context, ApiPrincipal user, IOptions<UserSettings> options)
        {
            _context = context;
            _user = user;
            _options = options;
        }

        public IAttributeRepository Attributes => _attributeRepository ??= new AttributeRepository(_user, _context, _options);
        public IEntityRepository<AttributeType> AttributeTypes => _attributeTypeRepository ??= new AttributeTypeRepository(_user, _context, _options);
        public IEntityRepository<Benefit> Benefits => _benefitRepository ??= new BenefitRepository(_user, _context, _options);
        public IEntityRepository<BenefitType> BenefitTypes => _benefitTypeRepository ??= new BenefitTypeRepository(_user, _context, _options);
        public IEntityUpdateRepository<BenefitUpdate> BenefitUpdates => _benefitUpdateRepository ??= new BenefitUpdateRepository(_user, _context, _options);
        public IEntityRepository<Commitment> Commitments => _commitmentRepository ??= new CommitmentRepository(_user, _context, _options);
        public IEntityUpdateRepository<CommitmentUpdate> CommitmentUpdates => _commitmentUpdateRepository ??= new CommitmentUpdateRepository(_user, _context, _options);
        public IContributorRepository Contributors => _contributorRepository ??= new ContributorRepository(_user, _context, _options);
        public IEntityRepository<CorporateRiskMitigationAction> CorporateRiskMitigationActions => _corporateRiskMitigationActionRepository ??= new CorporateRiskMitigationActionRepository(_user, _context, _options);
        public IEntityUpdateRepository<CorporateRiskMitigationActionUpdate> CorporateRiskMitigationActionUpdates => _corporateRiskMitigationActionUpdateRepository ??= new CorporateRiskMitigationActionUpdateRepository(_user, _context, _options);
        public IRiskRiskMitigationActionRepository<CorporateRiskRiskMitigationAction> CorporateRiskRiskMitigationActions => _corporateRiskRiskMitigationActionRepository ??= new CorporateRiskRiskMitigationActionRepository(_user, _context, _options);
        public IEntityRepository<CorporateRisk> CorporateRisks => _corporateRiskRepository ??= new CorporateRiskRepository(_user, _context, _options);
        public IEntityUpdateRepository<CorporateRiskUpdate> CorporateRiskUpdates => _corporateRiskUpdateRepository ??= new CorporateRiskUpdateRepository(_user, _context, _options);
        public IEntityRepository<DepartmentalObjective> DepartmentalObjectives => _departmentalObjectiveRepository ??= new DepartmentalObjectiveRepository(_user, _context, _options);
        public IEntityRepository<Dependency> Dependencies => _dependencyRepository ??= new DependencyRepository(_user, _context, _options);
        public IEntityUpdateRepository<DependencyUpdate> DependencyUpdates => _dependencyUpdateRepository ??= new DependencyUpdateRepository(_user, _context, _options);
        public IEntityRepository<Directorate> Directorates => _directorateRepository ??= new DirectorateRepository(_user, _context, _options);
        public IEntityUpdateRepository<DirectorateUpdate> DirectorateUpdates => _directorateUpdateRepository ??= new DirectorateUpdateRepository(_user, _context, _options);
        public IEntityRepository<EntityStatus> EntityStatuses => _entityStatusRepository ??= new EntityStatusRepository(_user, _context, _options);
        public IEntityRepository<FinancialRiskMitigationAction> FinancialRiskMitigationActions => _financialRiskMitigationActionRepository ??= new FinancialRiskMitigationActionRepository(_user, _context, _options);
        public IEntityUpdateRepository<FinancialRiskMitigationActionUpdate> FinancialRiskMitigationActionUpdates => _financialRiskMitigationActionUpdateRepository ??= new FinancialRiskMitigationActionUpdateRepository(_user, _context, _options);
        public IEntityRepository<FinancialRisk> FinancialRisks => _financialRiskRepository ??= new FinancialRiskRepository(_user, _context, _options);
        public IEntityUpdateRepository<FinancialRiskUpdate> FinancialRiskUpdates => _financialRiskUpdateRepository ??= new FinancialRiskUpdateRepository(_user, _context, _options);
        public IUserMappingRepository<FinancialRiskUserGroup> FinancialRiskUserGroups => _financialRiskUserGroupRepository ??= new FinancialRiskUserGroupRepository(_user, _context, _options);
        public IEntityRepository<Group> Groups => _groupRepository ??= new GroupRepository(_user, _context, _options);
        public IEntityRepository<KeyWorkArea> KeyWorkAreas => _keyWorkAreaRepository ??= new KeyWorkAreaRepository(_user, _context, _options);
        public IEntityUpdateRepository<KeyWorkAreaUpdate> KeyWorkAreaUpdates => _keyWorkAreaUpdateRepository ??= new KeyWorkAreaUpdateRepository(_user, _context, _options);
        public IEntityRepository<MeasurementUnit> MeasurementUnits => _measurementUnitRepository ??= new MeasurementUnitRepository(_user, _context, _options);
        public IEntityRepository<Metric> Metrics => _metricRepository ??= new MetricRepository(_user, _context, _options);
        public IEntityUpdateRepository<MetricUpdate> MetricUpdates => _metricUpdateRepository ??= new MetricUpdateRepository(_user, _context, _options);
        public IEntityRepository<Milestone> Milestones => _milestoneRepository ??= new MilestoneRepository(_user, _context, _options);
        public IEntityRepository<MilestoneType> MilestoneTypes => _milestoneTypeRepository ??= new MilestoneTypeRepository(_user, _context, _options);
        public IEntityUpdateRepository<MilestoneUpdate> MilestoneUpdates => _milestoneUpdateRepository ??= new MilestoneUpdateRepository(_user, _context, _options);
        public IPartnerOrganisationRiskRiskTypeRepository PartnerOrganisationRiskRiskTypes => _partnerOrganisationRiskRiskTypeRepository ??= new PartnerOrganisationRiskRiskTypeRepository(_user, _context, _options);
        public IEntityRepository<PartnerOrganisationRisk> PartnerOrganisationRisks => _partnerOrganisationRiskRepository ??= new PartnerOrganisationRiskRepository(_user, _context, _options);
        public IEntityRepository<PartnerOrganisation> PartnerOrganisations => _partnerOrganisationRepository ??= new PartnerOrganisationRepository(_user, _context, _options);
        public IEntityRepository<PartnerOrganisationRiskMitigationAction> PartnerOrganisationRiskMitigationActions => _partnerOrganisationRiskMitigationActionRepository ??= new PartnerOrganisationRiskMitigationActionRepository(_user, _context, _options);
        public IEntityUpdateRepository<PartnerOrganisationRiskMitigationActionUpdate> PartnerOrganisationRiskMitigationActionUpdates => _partnerOrganisationRiskMitigationActionUpdateRepository ??= new PartnerOrganisationRiskMitigationActionUpdateRepository(_user, _context, _options);
        public IEntityUpdateRepository<PartnerOrganisationRiskUpdate> PartnerOrganisationRiskUpdates => _partnerOrganisationRiskUpdateRepository ??= new PartnerOrganisationRiskUpdateRepository(_user, _context, _options);
        public IEntityUpdateRepository<PartnerOrganisationUpdate> PartnerOrganisationUpdates => _partnerOrganisationUpdateRepository ??= new PartnerOrganisationUpdateRepository(_user, _context, _options);
        public IEntityRepository<ProjectBusinessCaseType> ProjectBusinessCaseTypes => _projectBusinessCaseTypeRepository ??= new ProjectBusinessCaseTypeRepository(_user, _context, _options);
        public IEntityRepository<ProjectPhase> ProjectPhases => _projectPhaseRepository ??= new ProjectPhaseRepository(_user, _context, _options);
        public IEntityRepository<Project> Projects => _projectRepository ??= new ProjectRepository(_user, _context, _options);
        public IEntityUpdateRepository<ProjectUpdate> ProjectUpdates => _projectUpdateRepository ??= new ProjectUpdateRepository(_user, _context, _options);
        public IEntityRepository<RagOption> RagOptions => _ragOptionRepository ??= new RagOptionRepository(_user, _context, _options);
        public IEntityRepository<CustomReportingEntity> ReportingEntities => _reportingEntityRepository ??= new ReportingEntityRepository(_user, _context, _options);
        public IEntityRepository<CustomReportingEntityType> ReportingEntityTypes => _reportingEntityTypeRepository ??= new ReportingEntityTypeRepository(_user, _context, _options);
        public IEntityUpdateRepository<CustomReportingEntityUpdate> ReportingEntityUpdates => _reportingEntityUpdateRepository ??= new ReportingEntityUpdateRepository(_user, _context, _options);
        public IEntityRepository<ReportingFrequency> ReportingFrequencies => _reportingFrequencyRepository ??= new ReportingFrequencyRepository(_user, _context, _options);
        public IReportStagingRepository ReportStagings => _reportStagingRepository ??= new ReportStagingRepository(_user, _context, _options);
        public IEntityRepository<RiskAppetite> RiskAppetites => _riskAppetiteRepository ??= new RiskAppetiteRepository(_user, _context, _options);
        public IEntityRepository<RiskDiscussionForum> RiskDiscussionForums => _riskDiscussionForumRepository ??= new RiskDiscussionForumRepository(_user, _context, _options);
        public IEntityRepository<RiskImpactLevel> RiskImpactLevels => _riskImpactLevelRepository ??= new RiskImpactLevelRepository(_user, _context, _options);
        public IEntityRepository<RiskProbability> RiskProbabilities => _riskProbabilityRepository ??= new RiskProbabilityRepository(_user, _context, _options);
        public IEntityRepository<RiskRegister> RiskRegisters => _riskRegisterRepository ??= new RiskRegisterRepository(_user, _context, _options);
        public IRiskRiskTypeRepository RiskRiskTypes => _riskRiskTypeRepository ??= new RiskRiskTypeRepository(_user, _context, _options);
        public IEntityRepository<RiskType> RiskTypes => _riskTypeRepository ??= new RiskTypeRepository(_user, _context, _options);
        public IEntityRepository<Role> Roles => _roleRepository ??= new RoleRepository(_user, _context, _options);
        public ISignOffRepository SignOffs => _signOffRepository ??= new SignOffRepository(_user, _context, _options, CorporateRisks, FinancialRisks);
        public IEntityRepository<Threshold> Thresholds => _thresholdRepository ??= new ThresholdRepository(_user, _context, _options);
        public IThresholdAppetiteRepository ThresholdAppetites => _thresholdAppetiteRepository ??= new ThresholdAppetiteRepository(_user, _context, _options);
        public IUserMappingRepository<UserDirectorate> UserDirectorates => _userDirectorateRepository ??= new UserDirectorateRepository(_user, _context, _options);
        public IUserMappingRepository<UserGroup> UserGroups => _userGroupRepository ??= new UserGroupRepository(_user, _context, _options);
        public IUserMappingRepository<UserPartnerOrganisation> UserPartnerOrganisations => _userPartnerOrganisationRepository ??= new UserPartnerOrganisationRepository(_user, _context, _options);
        public IUserMappingRepository<UserProject> UserProjects => _userProjectRepository ??= new UserProjectRepository(_user, _context, _options);
        public IUserMappingRepository<UserRole> UserRoles => _userRoleRepository ??= new UserRoleRepository(_user, _context, _options);
        public IUserRepository Users => _userRepository ??= new UserRepository(_user, _context, _options);
        public IEntityRepository<WorkStream> WorkStreams => _workStreamRepository ??= new WorkStreamRepository(_user, _context, _options);
        public IEntityUpdateRepository<WorkStreamUpdate> WorkStreamUpdates => _workStreamUpdateRepository ??= new WorkStreamUpdateRepository(_user, _context, _options);
        public IEntityRepository<HealthCheckAlert> HealthCheckAlerts => _healthCheckAlertRepository ??= new HealthCheckAlertRepository(_user, _context, _options);

        public async Task<int> SaveChanges()
        {
            return await _context.SaveChangesAsync();
        }

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        protected virtual void Dispose(bool disposing)
        {
            if (!disposed)
            {
                if (disposing)
                {
                    _context.Dispose();
                }

                disposed = true;
            }
        }
    }
}