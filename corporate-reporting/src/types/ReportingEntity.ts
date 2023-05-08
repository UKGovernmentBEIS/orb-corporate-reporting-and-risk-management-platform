import { IEntityWithStatus, EntityWithStatus } from "./EntityWithStatus";
import { IEntityAttributes } from "./EntityAttributes";
import { IEntityContributors } from "./EntityContributors";
import { IEntityReportingCycle } from "./ReportingCycle";

export interface IReportingEntity extends IEntityWithStatus, IEntityAttributes, IEntityContributors, IEntityReportingCycle {
    Description: string;
}

export class ReportingEntity extends EntityWithStatus implements IReportingEntity {
    public Description = '';
    public ReportingFrequency = null;
    public ReportingDueDay = null;
    // public ReportingStartDate = null;
    public Attributes = [];
    public Contributors = [];
}

export interface IReportingEntityWithDeliveryDates extends IReportingEntity {
    BaselineDate: Date;
    ForecastDate: Date;
    ActualDate: Date;
}

export class ReportingEntityWithDeliveryDates extends ReportingEntity implements IReportingEntityWithDeliveryDates {
    public BaselineDate = null;
    public ForecastDate = null;
    public ActualDate = null;
}
