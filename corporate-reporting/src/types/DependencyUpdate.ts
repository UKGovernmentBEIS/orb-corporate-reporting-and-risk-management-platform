import { IDependency } from "./Dependency";
import { IReportingProgressUpdateWithDeliveryDates, ReportingProgressUpdateWithDeliveryDates } from "./ReportingProgressUpdate";

export interface IDependencyUpdate extends IReportingProgressUpdateWithDeliveryDates {
    DependencyID: number;
    Dependency?: IDependency;
}

export class DependencyUpdate extends ReportingProgressUpdateWithDeliveryDates implements IDependencyUpdate {
    public DependencyID = null;

    constructor(dependencyId: number, period?: Date) {
        super(period);
        this.DependencyID = dependencyId;
    }
}