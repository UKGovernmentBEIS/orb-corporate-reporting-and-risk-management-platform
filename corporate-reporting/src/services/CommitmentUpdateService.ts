import { WebPartContext } from '@microsoft/sp-webpart-base';
import { EntityUpdateService } from './EntityUpdateService';
import { ICommitmentUpdate, IDataAPI } from '../types';

export class CommitmentUpdateService extends EntityUpdateService<ICommitmentUpdate> {
    constructor(spfxContext: WebPartContext, api: IDataAPI) {
        super(spfxContext, api, `/CommitmentUpdates`);
    }

    public async readLatestUpdateForPeriod(commitmentId: number, period: Date): Promise<ICommitmentUpdate> {
        const cu = await this.readAll(
            `?$top=1`
            + `&$expand=UpdateUser`
            + `&$filter=CommitmentID eq ${commitmentId} and UpdatePeriod eq ${period.toISOString()}`
            + `&$orderby=UpdateDate desc`
        );
        if (cu.length > 0)
            return cu[0];
    }

    public async readLastSignedOffUpdateForPeriod(commitmentId: number, period: Date): Promise<ICommitmentUpdate> {
        const cu = await this.readAll(
            `?$top=1`
            + `&$filter=CommitmentID eq ${commitmentId} and UpdatePeriod eq ${period.toISOString()} and SignOffID ne null`
            + `&$orderby=SignOffID desc`
        );
        if (cu.length > 0)
            return cu[0];
    }
}