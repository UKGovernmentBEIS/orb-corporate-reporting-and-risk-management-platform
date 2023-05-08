import { WebPartContext } from '@microsoft/sp-webpart-base';
import { EntityUpdateService } from './EntityUpdateService';
import { IKeyWorkAreaUpdate, IDataAPI } from '../types';

export class KeyWorkAreaUpdateService extends EntityUpdateService<IKeyWorkAreaUpdate> {
    constructor(spfxContext: WebPartContext, api: IDataAPI) {
        super(spfxContext, api, `/KeyWorkAreaUpdates`);
    }

    public async readLatestUpdateForPeriod(keyWorkAreaId: number, period: Date): Promise<IKeyWorkAreaUpdate> {
        const kwa = await this.readAll(
            `?$top=1`
            + `&$expand=UpdateUser`
            + `&$filter=KeyWorkAreaID eq ${keyWorkAreaId} and UpdatePeriod eq ${period.toISOString()}`
            + `&$orderby=UpdateDate desc`
        );
        if (kwa.length > 0)
            return kwa[0];
    }

    public async readLastSignedOffUpdateForPeriod(keyWorkAreaId: number, period: Date): Promise<IKeyWorkAreaUpdate> {
        const kwa = await this.readAll(
            `?$top=1`
            + `&$filter=KeyWorkAreaID eq ${keyWorkAreaId} and UpdatePeriod eq ${period.toISOString()} and SignOffID ne null`
            + `&$orderby=SignOffID desc`
        );
        if (kwa.length > 0)
            return kwa[0];
    }
}