import { ReportingEntity, IReportingEntity } from "./ReportingEntity";
import { IDirectorate } from "./Directorate";
import { IUser } from "./User";
import { IMilestone } from "./Milestone";
import { IKeyWorkAreaUpdate } from "./KeyWorkAreaUpdate";

export interface IKeyWorkArea extends IReportingEntity {
    DirectorateID: number;
    LeadUserID: number;
    RagOptionID: number;
    Directorate?: IDirectorate;
    KeyWorkAreaUpdates?: IKeyWorkAreaUpdate[];
    LeadUser?: IUser;
    Milestones?: IMilestone[];
}

export class KeyWorkArea extends ReportingEntity implements IKeyWorkArea {
    public DirectorateID = null;
    public LeadUserID = null;
    public RagOptionID = null;
}