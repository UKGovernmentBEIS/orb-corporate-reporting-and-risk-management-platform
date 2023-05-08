import { IEntity } from "./Entity";
import { IProject } from "./Project";
import { IRagOption } from "./RagOption";
import { IReportingProgressUpdate, ReportingProgressUpdate } from "./ReportingProgressUpdate";

export interface IProjectUpdate extends IReportingProgressUpdate {
    ProjectID: number;
    OverallRagOptionID: number;
    FinanceRagOptionID: number;
    FinanceComment: string;
    PeopleRagOptionID: number;
    PeopleComment: string;
    MilestonesRagOptionID: number;
    MilestonesComment: string;
    BenefitsRagOptionID: number;
    BenefitsComment: string;
    ProgressUpdate: string;
    FutureActions: string;
    Escalations: string;

    ProjectPhaseID: number;
    BusinessCaseTypeID: number;
    BusinessCaseDate: Date;
    WholeLifeCost: number | string;
    WholeLifeBenefit: number | string;
    NetPresentValue: number | string;

    Project?: IProject;
    ProjectPhase?: IEntity;
    BusinessCaseType?: IEntity;
    OverallRagOption?: IRagOption;
    FinanceRagOption?: IRagOption;
    PeopleRagOption?: IRagOption;
    MilestonesRagOption?: IRagOption;
    BenefitsRagOption?: IRagOption;
}

export class ProjectUpdate extends ReportingProgressUpdate implements IProjectUpdate {
    public ProjectID = null;
    public OverallRagOptionID = null;
    public FinanceRagOptionID = null;
    public FinanceComment = '';
    public PeopleRagOptionID = null;
    public PeopleComment = '';
    public MilestonesRagOptionID = null;
    public MilestonesComment = '';
    public BenefitsRagOptionID = null;
    public BenefitsComment = '';
    public ProgressUpdate = '';
    public FutureActions = '';
    public Escalations = '';

    public ProjectPhaseID = null;
    public BusinessCaseTypeID = null;
    public BusinessCaseDate = null;
    public WholeLifeCost = '';
    public WholeLifeBenefit = '';
    public NetPresentValue = '';

    public UpdateUser = null;
    public Project: IProject = null;

    constructor(projectId?: number, period?: Date) {
        super(period);
        this.ProjectID = projectId;
    }
}