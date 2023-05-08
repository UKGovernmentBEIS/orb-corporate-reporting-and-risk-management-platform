import { ICommitment } from "./Commitment";
import { IReportingProgressUpdateWithDeliveryDates, ReportingProgressUpdateWithDeliveryDates } from "./ReportingProgressUpdate";

export interface ICommitmentUpdate extends IReportingProgressUpdateWithDeliveryDates {
    CommitmentID: number;
    Commitment?: ICommitment;
}

export class CommitmentUpdate extends ReportingProgressUpdateWithDeliveryDates implements ICommitmentUpdate {
    public CommitmentID = null;

    constructor(commitmentId: number, period?: Date) {
        super(period);
        this.CommitmentID = commitmentId;
    }
}