import { IProgressUpdateWithDeliveryDates, ProgressUpdateWithDeliveryDates } from "./ProgressUpdate";

export interface ICustomReportingEntityUpdate extends IProgressUpdateWithDeliveryDates {
    ReportingEntityID: number;
    CurrentPerformance: number | string;
}

export class CustomReportingEntityUpdate extends ProgressUpdateWithDeliveryDates implements ICustomReportingEntityUpdate {
    public ReportingEntityID = null;
    public CurrentPerformance = '';

    constructor(reportingEntityId: number, period?: Date) {
        super(period);
        this.ReportingEntityID = reportingEntityId;
    }
}
