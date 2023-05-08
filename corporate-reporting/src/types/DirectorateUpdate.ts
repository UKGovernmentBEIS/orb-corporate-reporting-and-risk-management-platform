import { IDirectorate } from "./Directorate";
import { IRagOption } from "./RagOption";
import { IReportingProgressUpdate, ReportingProgressUpdate } from "./ReportingProgressUpdate";

export interface IDirectorateUpdate extends IReportingProgressUpdate {
    DirectorateID: number;
    OverallRagOptionID: number;
    FinanceRagOptionID: number;
    FinanceComment: string;
    PeopleRagOptionID: number;
    PeopleComment: string;
    MilestonesRagOptionID: number;
    MilestonesComment: string;
    MetricsRagOptionID: number;
    MetricsComment: string;
    ProgressUpdate: string;
    FutureActions: string;
    Escalations: string;
    Directorate?: IDirectorate;
    OverallRagOption?: IRagOption;
    FinanceRagOption?: IRagOption;
    PeopleRagOption?: IRagOption;
    MilestonesRagOption?: IRagOption;
    MetricsRagOption?: IRagOption;
}

export class DirectorateUpdate extends ReportingProgressUpdate implements IDirectorateUpdate {
    public DirectorateID = null;
    public OverallRagOptionID = null;
    public FinanceRagOptionID = null;
    public FinanceComment = '';
    public PeopleRagOptionID = null;
    public PeopleComment = '';
    public MilestonesRagOptionID = null;
    public MilestonesComment = '';
    public MetricsRagOptionID = null;
    public MetricsComment = '';
    public ProgressUpdate = '';
    public FutureActions = '';
    public Escalations = '';

    public Directorate = null;
    public UpdateUser = null;

    constructor(directorateId?: number, period?: Date) {
        super(period);
        this.DirectorateID = directorateId;
    }
}