import { IAttributeType } from "./AttributeType";
import { IUserGroup } from "./UserGroup";
import { IPartnerOrganisation } from "./PartnerOrganisation";
import { IUserPartnerOrganisation } from "./UserPartnerOrganisation";
import { IPartnerOrganisationRisk } from "./PartnerOrganisationRisk";
import { IEntityWithTimerange } from "./EntityWithTimerange";
import { IThreshold } from "./Threshold";
import { IRiskType } from "./RiskType";
import { IThresholdAppetite } from "./ThresholdAppetite";
import { IEntity } from "./Entity";
import { IDirectorate } from "./Directorate";
import { IGroup } from "./Group";
import { IKeyWorkArea } from "./KeyWorkArea";
import { IProject } from "./Project";
import { IUserDirectorate } from "./UserDirectorate";
import { IUserProject } from "./UserProject";
import { IUser } from "./User";
import { IWorkStream } from "./WorkStream";
import { ICorporateRisk } from "./CorporateRisk";
import { IFinancialRisk } from "./FinancialRisk";
import { IReportingFrequency } from "./ReportingFrequency";
import { IMilestone } from "./Milestone";
import { IBenefit } from "./Benefit";
import { ICommitment } from "./Commitment";
import { IDependency } from "./Dependency";
import { IMetric } from "./Metric";
import { IPartnerOrganisationRiskMitigationAction } from "./PartnerOrganisationRiskMitigationAction";
import { ICustomReportingEntityType } from "./CustomReportingEntityType";

export interface ILookupData {
    AttributeTypes: IAttributeType[];
    Benefits: IBenefit[];
    BenefitTypes: IEntity[];
    Commitments: ICommitment[];
    CorporateRisks: ICorporateRisk[];
    DepartmentalObjectives: IEntity[];
    Dependencies: IDependency[];
    Directorates: IDirectorate[];
    EconomicRingfences: IEntity[];
    EntityStatuses: IEntity[];
    FinancialRisks: IFinancialRisk[];
    FundingClassifications: IEntity[];
    Groups: IGroup[];
    KeyWorkAreas: IKeyWorkArea[];
    MeasurementUnits: IEntity[];
    Metrics: IMetric[];
    Milestones: IMilestone[];
    MilestoneTypes: IEntity[];
    PartnerOrganisationRiskMitigationActions: IPartnerOrganisationRiskMitigationAction[];
    PartnerOrganisationRisks: IPartnerOrganisationRisk[];
    PartnerOrganisations: IPartnerOrganisation[];
    PolicyRingfences: IEntity[];
    ProjectBusinessCaseTypes: IEntity[];
    ProjectPhases: IEntity[];
    Projects: IProject[];
    ReportingEntityTypes: ICustomReportingEntityType[];
    ReportingFrequencies: IReportingFrequency[];
    RiskAppetites: IEntity[];
    RiskDiscussionForums: IEntity[];
    RiskImpactLevels: IEntityWithTimerange[];
    RiskProbabilities: IEntityWithTimerange[];
    RiskRegisters: IEntity[];
    RiskTypes: IRiskType[];
    Roles: IEntity[];
    ThresholdAppetites: IThresholdAppetite[];
    Thresholds: IThreshold[];
    BudgetingEntities: IEntity[];
    UserDirectorates: IUserDirectorate[];
    UserGroups: IUserGroup[];
    UserPartnerOrganisations: IUserPartnerOrganisation[];
    UserProjects: IUserProject[];
    Users: { All: IUser[], Enabled: IUser[] };
    WorkStreams: IWorkStream[];
}

export class LookupData implements ILookupData {
    public AttributeTypes = [];
    public Benefits = [];
    public BenefitTypes = [];
    public Commitments = [];
    public CorporateRisks = [];
    public DepartmentalObjectives = [];
    public Dependencies = [];
    public Directorates = [];
    public EconomicRingfences = [];
    public EntityStatuses = [];
    public FinancialRisks = [];
    public FundingClassifications = [];
    public Groups = [];
    public KeyWorkAreas = [];
    public MeasurementUnits = [];
    public Metrics = [];
    public Milestones = [];
    public MilestoneTypes = [];
    public PartnerOrganisationRiskMitigationActions = [];
    public PartnerOrganisationRisks = [];
    public PartnerOrganisations = [];
    public PolicyRingfences = [];
    public ProjectBusinessCaseTypes = [];
    public ProjectPhases = [];
    public Projects = [];
    public ReportingEntityTypes = [];
    public ReportingFrequencies = [];
    public RiskAppetites = [];
    public RiskDiscussionForums = [];
    public RiskRegisters = [];
    public RiskImpactLevels = [];
    public RiskTypes = [];
    public RiskProbabilities = [];
    public Roles = [];
    public ThresholdAppetites = [];
    public Thresholds = [];
    public BudgetingEntities = [];
    public UserDirectorates = [];
    public UserGroups = [];
    public UserPartnerOrganisations = [];
    public UserProjects = [];
    public Users = { All: [], Enabled: [] };
    public WorkStreams = [];
}

export interface ILoadLookupData {
    attributeTypes: (forceReload?: boolean) => void;
    benefits: (forceReload?: boolean) => void;
    benefitTypes: (forceReload?: boolean) => void;
    commitments: (forceReload?: boolean) => void;
    corporateRisks: (forceReload?: boolean) => void;
    departmentalObjectives: (forceReload?: boolean) => void;
    dependencies: (forceReload?: boolean) => void;
    directorates: (forceReload?: boolean) => void;
    economicRingfences: (forceReload?: boolean) => void;
    entityStatuses: (forceReload?: boolean) => void;
    financialRisks: (forceReload?: boolean) => void;
    fundingClassifications: (forceReload?: boolean) => void;
    groups: (forceReload?: boolean) => void;
    keyWorkAreas: (forceReload?: boolean) => void;
    measurementUnits: (forceReload?: boolean) => void;
    metrics: (forceReload?: boolean) => void;
    milestones: (forceReload?: boolean) => void;
    milestoneTypes: (forceReload?: boolean) => void;
    partnerOrganisationRiskMitigationActions: (forceReload?: boolean) => void;
    partnerOrganisationRisks: (forceReload?: boolean) => void;
    partnerOrganisations: (forceReload?: boolean) => void;
    policyRingfences: (forceReload?: boolean) => void;
    projectBusinessCaseTypes: (forceReload?: boolean) => void;
    projectPhases: (forceReload?: boolean) => void;
    projects: (forceReload?: boolean) => void;
    reportingEntityTypes: (forceReload?: boolean) => void;
    reportingFrequencies: (forceReload?: boolean) => void;
    riskAppetites: (forceReload?: boolean) => void;
    riskDiscussionForums: (forceReload?: boolean) => void;
    riskImpactLevels: (forceReload?: boolean) => void;
    riskProbabilities: (forceReload?: boolean) => void;
    riskRegisters: (forceReload?: boolean) => void;
    riskTypes: (forceReload?: boolean) => void;
    roles: (forceReload?: boolean) => void;
    thresholdAppetites: (forceReload?: boolean) => void;
    thresholds: (forceReload?: boolean) => void;
    budgetingEntities: (forceRelead?: boolean) => void;
    userDirectorates: (forceReload?: boolean) => void;
    userGroups: (forceReload?: boolean) => void;
    userPartnerOrganisations: (forceReload?: boolean) => void;
    userProjects: (forceReload?: boolean) => void;
    users: { all: (forceReload?: boolean) => void, enabled: (forceReload?: boolean) => void };
    workStreams: (forceReload?: boolean) => void;
}

export const LoadLookupData: ILoadLookupData = {
    attributeTypes: () => undefined,
    benefits: () => undefined,
    benefitTypes: () => undefined,
    commitments: () => undefined,
    corporateRisks: () => undefined,
    departmentalObjectives: () => undefined,
    dependencies: () => undefined,
    directorates: () => undefined,
    economicRingfences: () => undefined,
    entityStatuses: () => undefined,
    financialRisks: () => undefined,
    fundingClassifications: () => undefined,
    groups: () => undefined,
    keyWorkAreas: () => undefined,
    measurementUnits: () => undefined,
    metrics: () => undefined,
    milestones: () => undefined,
    milestoneTypes: () => undefined,
    partnerOrganisationRiskMitigationActions: () => undefined,
    partnerOrganisationRisks: () => undefined,
    partnerOrganisations: () => undefined,
    policyRingfences: () => undefined,
    projectBusinessCaseTypes: () => undefined,
    projectPhases: () => undefined,
    projects: () => undefined,
    reportingEntityTypes: () => undefined,
    reportingFrequencies: () => undefined,
    riskAppetites: () => undefined,
    riskDiscussionForums: () => undefined,
    riskImpactLevels: () => undefined,
    riskProbabilities: () => undefined,
    riskRegisters: () => undefined,
    riskTypes: () => undefined,
    roles: () => undefined,
    thresholdAppetites: () => undefined,
    thresholds: () => undefined,
    budgetingEntities: () => undefined,
    userDirectorates: () => undefined,
    userGroups: () => undefined,
    userPartnerOrganisations: () => undefined,
    userProjects: () => undefined,
    users: { all: () => undefined, enabled: () => undefined },
    workStreams: () => undefined
};
