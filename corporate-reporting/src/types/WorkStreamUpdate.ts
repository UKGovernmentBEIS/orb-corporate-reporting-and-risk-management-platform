import { IWorkStream } from "./WorkStream";
import { IReportingProgressUpdate, ReportingProgressUpdate } from "./ReportingProgressUpdate";

export interface IWorkStreamUpdate extends IReportingProgressUpdate {
    WorkStreamID: number;
    WorkStream?: IWorkStream;
}

export class WorkStreamUpdate extends ReportingProgressUpdate implements IWorkStreamUpdate {
    public WorkStreamID = null;

    constructor(workStreamId: number, period?: Date) {
        super(period);
        this.WorkStreamID = workStreamId;
    }
}