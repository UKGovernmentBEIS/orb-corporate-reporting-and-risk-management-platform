import { WebPartContext } from '@microsoft/sp-webpart-base';
import { EntityUpdateService } from './EntityUpdateService';
import { IWorkStreamUpdate, IDataAPI } from '../types';

export class WorkStreamUpdateService extends EntityUpdateService<IWorkStreamUpdate> {
    constructor(spfxContext: WebPartContext, api: IDataAPI) {
        super(spfxContext, api, `/WorkStreamUpdates`);
    }

    public async readLatestUpdateForPeriod(workStreamId: number, period: Date): Promise<IWorkStreamUpdate> {
        const ws = await this.readAll(
            `?$top=1`
            + `&$expand=UpdateUser`
            + `&$filter=WorkStreamID eq ${workStreamId} and UpdatePeriod eq ${period.toISOString()}`
            + `&$orderby=UpdateDate desc`
        );
        if (ws.length > 0)
            return ws[0];
    }

    public async readLastSignedOffUpdateForPeriod(workStreamId: number, period: Date): Promise<IWorkStreamUpdate> {
        const ws = await this.readAll(
            `?$top=1`
            + `&$filter=WorkStreamID eq ${workStreamId} and UpdatePeriod eq ${period.toISOString()} and SignOffID ne null`
            + `&$orderby=SignOffID desc`
        );
        if (ws.length > 0)
            return ws[0];
    }
}