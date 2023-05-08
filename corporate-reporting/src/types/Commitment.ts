import { IReportingEntityWithDeliveryDates, ReportingEntityWithDeliveryDates } from "./ReportingEntity";
import { IDirectorate } from "./Directorate";
import { IUser } from "./User";
import { ICommitmentUpdate } from "./CommitmentUpdate";

export interface ICommitment extends IReportingEntityWithDeliveryDates {
    DirectorateID: number;
    RagOptionID: number;
    LeadUserID: number;
    Directorate?: IDirectorate;
    LeadUser?: IUser;
    CommitmentUpdates?: ICommitmentUpdate[];
}

export class Commitment extends ReportingEntityWithDeliveryDates implements ICommitment {
    public DirectorateID = null;
    public RagOptionID = null;
    public LeadUserID = null;
}