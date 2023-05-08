export interface IReportDueDates {
    Next: Date;
    Previous: Date;
}

export class ReportDueDates implements IReportDueDates {
    public Next = null;
    public Previous = null;
}
