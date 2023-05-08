import { Entity, IEntity } from "./Entity";
import { IUser } from "./User";
import { IPartnerOrganisation } from "./PartnerOrganisation";
import { IPartnerOrganisationUpdate } from "./PartnerOrganisationUpdate";
import { IPartnerOrganisationRiskUpdate } from "./PartnerOrganisationRiskUpdate";
import { IPartnerOrganisationRiskMitigationActionUpdate } from "./PartnerOrganisationRiskMitigationActionUpdate";
import { IRiskUpdate } from "./RiskUpdate";
import { IRiskMitigationActionUpdate } from "./RiskMitigationActionUpdate";
import { IDirectorate } from "./Directorate";
import { IProject } from "./Project";
import { IDirectorateUpdate } from "./DirectorateUpdate";
import { IProjectUpdate } from "./ProjectUpdate";
import { IKeyWorkAreaUpdate } from "./KeyWorkAreaUpdate";
import { IWorkStreamUpdate } from "./WorkStreamUpdate";
import { IMetricUpdate } from "./MetricUpdate";
import { IBenefitUpdate } from "./BenefitUpdate";
import { IMilestoneUpdate } from "./MilestoneUpdate";
import { ICommitmentUpdate } from "./CommitmentUpdate";
import { IDependencyUpdate } from "./DependencyUpdate";
import { IKeyWorkArea } from "./KeyWorkArea";
import { IBenefit } from "./Benefit";
import { ICommitment } from "./Commitment";
import { IDependency } from "./Dependency";
import { IMetric } from "./Metric";
import { IMilestone } from "./Milestone";
import { IPartnerOrganisationRisk } from "./PartnerOrganisationRisk";
import { IPartnerOrganisationRiskMitigationAction } from "./PartnerOrganisationRiskMitigationAction";
import { IWorkStream } from "./WorkStream";
import { ICorporateRisk } from "./CorporateRisk";
import { IFinancialRisk } from "./FinancialRisk";
import { ICustomReportingEntityType } from "./CustomReportingEntityType";
import { IFinancialRiskMitigationAction } from "./FinancialRiskMitigationAction";
import { ICorporateRiskMitigationAction } from "./CorporateRiskMitigationAction";
import { ISignOffDto } from ".";

export interface ISignOff extends IEntity {
    SignOffDate: Date;
    SignOffUserID: number;
    ReportMonth: Date;
    DirectorateID: number;
    ProjectID: number;
    PartnerOrganisationID: number;
    RiskID: number;
    SignOffEntities: string;
    ReportJson: string;
    SignOffUser?: IUser;
    Directorate?: IDirectorate;
    Project?: IProject;
    PartnerOrganisation?: IPartnerOrganisation;
    Risk?: ICorporateRisk;
    FinancialRisk?: IFinancialRisk;
    DirectorateUpdates?: IDirectorateUpdate[];
    ProjectUpdates?: IProjectUpdate[];
    PartnerOrganisationUpdates?: IPartnerOrganisationUpdate[];
    KeyWorkAreaUpdates?: IKeyWorkAreaUpdate[];
    WorkStreamUpdates?: IWorkStreamUpdate[];
    MetricUpdates?: IMetricUpdate[];
    BenefitUpdates?: IBenefitUpdate[];
    MilestoneUpdates?: IMilestoneUpdate[];
    CommitmentUpdates?: ICommitmentUpdate[];
    DependencyUpdates?: IDependencyUpdate[];
    RiskUpdates?: IRiskUpdate[];
    RiskMitigationActionUpdates?: IRiskMitigationActionUpdate[];
    PartnerOrganisationRiskUpdates?: IPartnerOrganisationRiskUpdate[];
    PartnerOrganisationRiskMitigationActionUpdates?: IPartnerOrganisationRiskMitigationActionUpdate[];

    // From decompose of ReportJson
    Benefits?: IBenefit[];
    Commitments?: ICommitment[];
    Dependencies?: IDependency[];
    FinancialRiskMitigationActions?: IFinancialRiskMitigationAction[];
    KeyWorkAreas?: IKeyWorkArea[];
    Metrics?: IMetric[];
    Milestones?: IMilestone[];
    Projects?: IProject[];
    PartnerOrganisationRisks?: IPartnerOrganisationRisk[];
    PartnerOrganisationRiskMitigationActions?: IPartnerOrganisationRiskMitigationAction[];
    ReportingEntityTypes?: ICustomReportingEntityType[];
    RiskMitigationActions?: ICorporateRiskMitigationAction[];
    WorkStreams?: IWorkStream[];
}

export class SignOff extends Entity implements ISignOff {
    public SignOffDate = null;
    public SignOffUserID = null;
    public ReportMonth = null;
    public DirectorateID = null;
    public ProjectID = null;
    public PartnerOrganisationID = null;
    public RiskID = null;
    public SignOffEntities = null;
    public ReportJson = null;

    constructor(reportMonth: Date) {
        super();
        this.ReportMonth = reportMonth;
    }
}

export class SignOffEntity {
    public EntityType = null;
    public EntityID = null;

    constructor(entityType: string, entityID: number) {
        this.EntityType = entityType;
        this.EntityID = entityID;
    }
}

export interface ISignOffAndMetadata {
    report: Partial<ISignOff>;
    metadata: ISignOffDto;
}