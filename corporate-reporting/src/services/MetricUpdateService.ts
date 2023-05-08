import { WebPartContext } from '@microsoft/sp-webpart-base';
import { EntityUpdateService } from './EntityUpdateService';
import { IMetricUpdate, IDataAPI, IMetric } from '../types';

export class MetricUpdateService extends EntityUpdateService<IMetricUpdate> {
    constructor(spfxContext: WebPartContext, api: IDataAPI) {
        super(spfxContext, api, `/MetricUpdates`);
    }

    public async readLatestUpdateForPeriod(metricId: number, period: Date): Promise<IMetricUpdate> {
        return (await this.readAll(
            `?$top=1`
            + `&$expand=UpdateUser`
            + `&$filter=MetricID eq ${metricId} and UpdatePeriod eq ${period.toISOString()}`
            + `&$orderby=UpdateDate desc`
        ))?.[0];
    }

    public async readLatestUpdateBetweenDates(metricId: number, from: Date, to: Date): Promise<IMetricUpdate> {
        return (await this.readAll(
            `?$top=1`
            + `&$expand=UpdateUser`
            + `&$filter=MetricID eq ${metricId} and UpdatePeriod gt ${from.toISOString()} and UpdatePeriod le ${to.toISOString()}`
            + `&$orderby=UpdateDate desc`
        ))?.[0];
    }

    public async readLastSignedOffUpdateForPeriod(metricId: number, period: Date): Promise<IMetricUpdate> {
        return (await this.readAll(
            `?$top=1`
            + `&$filter=MetricID eq ${metricId} and UpdatePeriod eq ${period.toISOString()} and SignOffID ne null`
            + `&$orderby=SignOffID desc`
        ))?.[0];
    }

    public readUpdateForMetricArray(metrics: IMetric[], date: Date): Promise<IMetricUpdate[]> {
        if (metrics) {
            const updates: Promise<IMetricUpdate>[] = metrics.map(m => {
                return this.readLastSignedOffUpdateForPeriod(m.ID, date);
            });
            return Promise.all(updates);
        }
    }

    public async readLastSignedOffUpdateBeforeDate(metricId: number, beforeDate: Date): Promise<IMetricUpdate> {
        return (await this.readAll(
            `?$top=1`
            + `&$filter=MetricID eq ${metricId} and UpdatePeriod le ${beforeDate.toISOString()} and SignOffID ne null`
            + `&$orderby=UpdatePeriod desc`
        ))?.[0];
    }
}