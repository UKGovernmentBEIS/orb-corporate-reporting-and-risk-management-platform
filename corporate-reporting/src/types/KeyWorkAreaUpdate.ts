import { IKeyWorkArea } from "./KeyWorkArea";
import { IReportingProgressUpdate, ReportingProgressUpdate } from "./ReportingProgressUpdate";

export interface IKeyWorkAreaUpdate extends IReportingProgressUpdate {
    KeyWorkAreaID: number;
    KeyWorkArea?: IKeyWorkArea;
}

export class KeyWorkAreaUpdate extends ReportingProgressUpdate implements IKeyWorkAreaUpdate {
    public KeyWorkAreaID = null;

    constructor(keyWorkAreaId: number, period?: Date) {
        super(period);
        this.KeyWorkAreaID = keyWorkAreaId;
    }
}