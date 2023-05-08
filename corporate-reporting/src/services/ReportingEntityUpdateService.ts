import { WebPartContext } from '@microsoft/sp-webpart-base';
import { IDataAPI } from '../types';
import { EntityUpdateService } from './EntityUpdateService';
import { ICustomReportingEntityUpdate } from '../types/CustomReportingEntityUpdate';

export class ReportingEntityUpdateService extends EntityUpdateService<ICustomReportingEntityUpdate> {
    public readonly parentEntities = ['ReportingEntity'];

    constructor(spfxContext: WebPartContext, api: IDataAPI) {
        super(spfxContext, api, `/ReportingEntityUpdates`);
    }

    public async readLatestUpdateForPeriod(entityId: number, period: Date): Promise<ICustomReportingEntityUpdate> {
        const reu = await this.readAll(
            `?$top=1`
            + `&$expand=UpdateUser`
            + `&$filter=ReportingEntityID eq ${entityId} and UpdatePeriod eq ${period.toISOString()}`
            + `&$orderby=UpdateDate desc`
        );
        if (reu.length > 0)
            return reu[0];
    }

    public async readLastSignedOffUpdateForPeriod(entityId: number, period: Date): Promise<ICustomReportingEntityUpdate> {
        const reu = await this.readAll(
            `?$top=1`
            + `&$filter=ReportingEntityID eq ${entityId} and UpdatePeriod eq ${period.toISOString()} and SignOffID ne null`
            + `&$orderby=SignOffID desc`
        );
        if (reu.length > 0)
            return reu[0];
    }
}