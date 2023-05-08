import { IMetric } from "./Metric";
import { IReportingProgressUpdate, ReportingProgressUpdate } from "./ReportingProgressUpdate";

export interface IMetricUpdate extends IReportingProgressUpdate {
    MetricID: number;
    CurrentPerformance: number | string;
    Metric?: IMetric;
}

export class MetricUpdate extends ReportingProgressUpdate implements IMetricUpdate {
    public MetricID = null;
    public CurrentPerformance = '';

    constructor(metricId: number, period?: Date) {
        super(period);
        this.MetricID = metricId;
    }
}