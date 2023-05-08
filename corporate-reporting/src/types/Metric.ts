import { IDirectorate } from "./Directorate";
import { IUser } from "./User";
import { IEntity } from "./Entity";
import { IReportingEntity, ReportingEntity } from "./ReportingEntity";
import { IMetricUpdate } from "./MetricUpdate";

export interface IMetric extends IReportingEntity {
    MetricCode: string;
    DirectorateID: number;
    Description: string;
    MeasurementUnitID: number;
    TargetPerformanceUpperLimit: number | string;
    TargetPerformanceLowerLimit: number | string;
    LeadUserID: number;
    RagOptionID: number;
    Directorate?: IDirectorate;
    LeadUser?: IUser;
    MeasurementUnit?: IEntity;
    MetricUpdates?: IMetricUpdate[];
}

export class Metric extends ReportingEntity implements IMetric {
    public MetricCode = '';
    public DirectorateID = null;
    public Description = '';
    public ReportingFrequency = null;
    public MeasurementUnitID = null;
    public TargetPerformanceUpperLimit = '';
    public TargetPerformanceLowerLimit = '';
    public LeadUserID = null;
    public RagOptionID = null;
}