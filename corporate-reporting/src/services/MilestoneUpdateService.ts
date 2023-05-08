import { WebPartContext } from '@microsoft/sp-webpart-base';
import { EntityUpdateService } from './EntityUpdateService';
import { IMilestoneUpdate, IDataAPI } from '../types';

export class MilestoneUpdateService extends EntityUpdateService<IMilestoneUpdate> {
    constructor(spfxContext: WebPartContext, api: IDataAPI) {
        super(spfxContext, api, `/MilestoneUpdates`);
    }

    public async readLatestUpdateForPeriod(milestoneId: number, period: Date): Promise<IMilestoneUpdate> {
        const mu = await this.readAll(
            `?$top=1`
            + `&$expand=UpdateUser`
            + `&$filter=MilestoneID eq ${milestoneId} and UpdatePeriod eq ${period.toISOString()}`
            + `&$orderby=UpdateDate desc`
        );
        if (mu.length > 0)
            return mu[0];
    }

    public async readLastSignedOffUpdateForPeriod(milestoneId: number, period: Date): Promise<IMilestoneUpdate> {
        const mu = await this.readAll(
            `?$top=1`
            + `&$filter=MilestoneID eq ${milestoneId} and UpdatePeriod eq ${period.toISOString()} and SignOffID ne null`
            + `&$orderby=SignOffID desc`
        );
        if (mu.length > 0)
            return mu[0];
    }
}