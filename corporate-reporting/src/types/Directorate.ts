import { IReportingEntity, ReportingEntity } from "./ReportingEntity";
import { IUser } from "./User";
import { IGroup } from "./Group";
import { IUserDirectorate } from "./UserDirectorate";
import { ICommitment } from "./Commitment";
import { IKeyWorkArea } from "./KeyWorkArea";
import { IMetric } from "./Metric";
import { IRisk } from "./Risk";
import { IDirectorateUpdate } from "./DirectorateUpdate";

export interface IDirectorate extends IReportingEntity {
    DirectorUserID: number;
    Objectives: string;
    GroupID: number;
    ReportApproverUserID: number;
    ReportingLeadUserID: number;
    DirectorateUpdates?: IDirectorateUpdate[];
    DirectorUser?: IUser;
    Group?: IGroup;
    ReportApproverUser?: IUser;
    ReportingLeadUser?: IUser;
    UserDirectorates?: IUserDirectorate[];
    Commitments?: ICommitment[];
    KeyWorkAreas?: IKeyWorkArea[];
    Metrics?: IMetric[];
    Risks?: IRisk[];
}

export class Directorate extends ReportingEntity implements IDirectorate {
    public DirectorUserID = null;
    public Objectives = '';
    public GroupID = null;
    public ReportApproverUserID = null;
    public ReportingLeadUserID = null;
}