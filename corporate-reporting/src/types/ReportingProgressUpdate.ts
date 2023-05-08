import { IProgressUpdate, ProgressUpdate, IProgressUpdateWithDeliveryDates } from "./ProgressUpdate";

export interface IReportingProgressUpdate extends IProgressUpdate {
    SignOffID: number;
}

export interface IReportingProgressUpdateWithDeliveryDates extends IReportingProgressUpdate, IProgressUpdateWithDeliveryDates { }

export class ReportingProgressUpdate extends ProgressUpdate implements IReportingProgressUpdate {
    public SignOffID = null;
}

export class ReportingProgressUpdateWithDeliveryDates extends ReportingProgressUpdate implements IReportingProgressUpdateWithDeliveryDates {
    public ForecastDate = null;
    public ActualDate = null;
}
