import {
    AttributeService, AttributeTypeService, BenefitService, BenefitUpdateService, UserRoleService,
    RoleService, BenefitTypeService, ContributorService, DepartmentalObjectiveService, DirectorateService,
    EntityStatusService, GroupService, KeyWorkAreaService, MeasurementUnitService, MilestoneTypeService,
    PartnerOrganisationService, ProjectService,
    RiskAppetiteService, RiskRegisterService, RiskImpactLevelService, RiskProbabilityService,
    RiskRiskTypeService, RiskTypeService, UserDirectorateService, UserGroupService, UserPartnerOrganisationService,
    UserProjectService, UserService, WorkStreamService, DependencyService, MetricService,
    MilestoneService, CommitmentService, CommitmentUpdateService, DependencyUpdateService, DirectorateUpdateService,
    KeyWorkAreaUpdateService, MetricUpdateService, MilestoneUpdateService, PartnerOrganisationUpdateService,
    ProjectUpdateService, WorkStreamUpdateService, SignOffService, RiskPermissionsService,
    PartnerOrganisationRiskMitigationActionService, PartnerOrganisationRiskMitigationActionUpdateService,
    PartnerOrganisationRiskService, PartnerOrganisationRiskUpdateService, PartnerOrganisationRiskRiskTypeService,
    ProjectPhaseService, ProjectBusinessCaseTypeService, HealthCheckService, ITokenRefreshService, ThresholdService,
    ThresholdAppetiteService, ISiteService, ReportDueDatesService, IReportBuilderService, ReportingFrequencyService,
    FinancialRiskService, CorporateRiskUpdateService, FinancialRiskUpdateService, CorporateRiskMitigationActionService,
    CorporateRiskService, FinancialRiskMitigationActionService, IListService, CorporateRiskMitigationActionUpdateService,
    FinancialRiskMitigationActionUpdateService, FinancialRiskUserGroupService, ReportingEntityService,
    ReportingEntityTypeService, ReportingEntityUpdateService, CorporateRiskRiskMitigationActionService,
    RiskDiscussionForumService
} from "../services";

export interface IDataServices {
    attributeService?: AttributeService;
    attributeTypeService?: AttributeTypeService;
    benefitService?: BenefitService;
    benefitTypeService?: BenefitTypeService;
    benefitUpdateService?: BenefitUpdateService;
    commitmentService?: CommitmentService;
    commitmentUpdateService?: CommitmentUpdateService;
    contributorService?: ContributorService;
    corporateRiskMitigationActionService?: CorporateRiskMitigationActionService;
    corporateRiskMitigationActionUpdateService?: CorporateRiskMitigationActionUpdateService;
    corporateRiskRiskMitigationActionService?: CorporateRiskRiskMitigationActionService;
    corporateRiskService?: CorporateRiskService;
    corporateRiskUpdateService?: CorporateRiskUpdateService;
    departmentalObjectivesService?: DepartmentalObjectiveService;
    dependencyService?: DependencyService;
    dependencyUpdateService?: DependencyUpdateService;
    directorateService?: DirectorateService;
    directorateUpdateService?: DirectorateUpdateService;
    economicRingfenceService?: IListService;
    entityStatusService?: EntityStatusService;
    financialRiskMitigationActionService?: FinancialRiskMitigationActionService;
    financialRiskMitigationActionUpdateService?: FinancialRiskMitigationActionUpdateService;
    financialRiskService?: FinancialRiskService;
    financialRiskUpdateService?: FinancialRiskUpdateService;
    financialRiskUserGroupService?: FinancialRiskUserGroupService;
    fundingClassificationService?: IListService;
    groupService?: GroupService;
    healthCheckService?: HealthCheckService;
    keyWorkAreaService?: KeyWorkAreaService;
    keyWorkAreaUpdateService?: KeyWorkAreaUpdateService;
    measurementUnitService?: MeasurementUnitService;
    metricService?: MetricService;
    metricUpdateService?: MetricUpdateService;
    milestoneService?: MilestoneService;
    milestoneTypeService?: MilestoneTypeService;
    milestoneUpdateService?: MilestoneUpdateService;
    partnerOrganisationRiskMitigationActionService?: PartnerOrganisationRiskMitigationActionService;
    partnerOrganisationRiskMitigationActionUpdateService?: PartnerOrganisationRiskMitigationActionUpdateService;
    partnerOrganisationRiskRiskTypeService?: PartnerOrganisationRiskRiskTypeService;
    partnerOrganisationRiskService?: PartnerOrganisationRiskService;
    partnerOrganisationRiskUpdateService?: PartnerOrganisationRiskUpdateService;
    partnerOrganisationService?: PartnerOrganisationService;
    partnerOrganisationUpdateService?: PartnerOrganisationUpdateService;
    policyRingfenceService?: IListService;
    projectBusinessCaseTypeService?: ProjectBusinessCaseTypeService;
    projectPhaseService?: ProjectPhaseService;
    projectService?: ProjectService;
    projectUpdateService?: ProjectUpdateService;
    reportBuilderService?: IReportBuilderService;
    reportDueDatesService?: ReportDueDatesService;
    reportingEntityService?: ReportingEntityService;
    reportingEntityTypeService?: ReportingEntityTypeService;
    reportingEntityUpdateService?: ReportingEntityUpdateService;
    reportingFrequencyService?: ReportingFrequencyService;
    riskAppetiteService?: RiskAppetiteService;
    riskDiscussionForumService?: RiskDiscussionForumService;
    riskPermissionsService?: RiskPermissionsService;
    riskRegisterService?: RiskRegisterService;
    riskImpactLevelService?: RiskImpactLevelService;
    riskProbabilityService?: RiskProbabilityService;
    riskRiskTypeService?: RiskRiskTypeService;
    riskTypeService?: RiskTypeService;
    roleService?: RoleService;
    signOffService?: SignOffService;
    siteService?: ISiteService;
    thresholdService?: ThresholdService;
    thresholdAppetiteService?: ThresholdAppetiteService;
    tokenRefreshService?: ITokenRefreshService;
    budgetingEntitiesService?: IListService;
    userDirectorateService?: UserDirectorateService;
    userGroupService?: UserGroupService;
    userPartnerOrganisationService?: UserPartnerOrganisationService;
    userProjectService?: UserProjectService;
    userRoleService?: UserRoleService;
    userService?: UserService;
    workStreamService?: WorkStreamService;
    workStreamUpdateService?: WorkStreamUpdateService;
}
