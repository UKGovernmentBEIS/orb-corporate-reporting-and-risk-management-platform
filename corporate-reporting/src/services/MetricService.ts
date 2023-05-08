import { WebPartContext } from '@microsoft/sp-webpart-base';
import { EntityWithStatusService } from './EntityWithStatusService';
import { ContextService } from './ContextService';
import { IMetric, IDataAPI, IEntityChildren } from '../types';
import { EntityStatus } from '../refData/EntityStatus';
import { Period } from '../refData/Period';

export class MetricService extends EntityWithStatusService<IMetric> {
    public readonly parentEntities = ['Directorate', 'LeadUser', 'MeasurementUnit'];
    protected childrenEntities = ['Contributors($expand=ContributorUser)', 'Attributes($expand=AttributeType)'];

    constructor(spfxContext: WebPartContext, api: IDataAPI) {
        super(spfxContext, api, `/Metrics`);
    }

    public readAllForList(includeClosedMetrics?: boolean): Promise<IMetric[]> {
        return this.readAll(
            `?$select=ID,Title,TargetPerformanceLowerLimit,TargetPerformanceUpperLimit`
            + `&$orderby=Title`
            + `&$expand=EntityStatus($select=Title),Directorate($select=Title),LeadUser($select=Title),Contributors($select=ContributorUser;$expand=ContributorUser($select=Title))`
            + (includeClosedMetrics ? `` : `&$filter=EntityStatusID eq ${EntityStatus.Open}`)
        );
    }

    public readMyMetrics(): Promise<IMetric[]> {
        const username = encodeURIComponent(ContextService.Username(this.spfxContext));
        const filters = [
            `LeadUser/Username eq '${username}'`,
            `Contributors/any(c: c/ContributorUser/Username eq '${username}')`
        ];
        return this.readAll(`?$filter=EntityStatusID eq ${EntityStatus.Open} and (${filters.join(' or ')})`);
    }

    public readDirectorateMetrics(directoratetId: number): Promise<IMetric[]> {
        if (directoratetId) {
            return this.readAll(`?$expand=LeadUser&$filter=EntityStatusID eq ${EntityStatus.Open} and DirectorateID eq ${directoratetId}`);
        }
        return Promise.resolve([]);
    }

    public async readDirectorateOpenMetricsCount(directorateId: number): Promise<number> {
        if (directorateId) {
            return (await this.readAll(`?$select=ID&$filter=EntityStatusID eq ${EntityStatus.Open} and DirectorateID eq ${directorateId}`)).length;
        }
        return Promise.resolve(0);
    }

    public readDirectorateMetricsInPeriod(directoratetId: number, period: Period): Promise<IMetric[]> {
        if (directoratetId) {
            return this.readAll(`/GetMetricsDueInPeriod(DirectorateId=${directoratetId},Period=${period})?$expand=LeadUser,MeasurementUnit,Attributes($expand=AttributeType),Contributors`);
        }
        return Promise.resolve([]);
    }

    public entityChildren = (id: number): Promise<IEntityChildren[]> => {
        return this.entityChildrenSingle(id, 'Metric updates', 'MetricUpdates', false);
    }
}