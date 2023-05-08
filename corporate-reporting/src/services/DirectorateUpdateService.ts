import { WebPartContext } from '@microsoft/sp-webpart-base';
import { EntityUpdateService } from './EntityUpdateService';
import { IDirectorateUpdate, IDataAPI } from '../types';

export class DirectorateUpdateService extends EntityUpdateService<IDirectorateUpdate> {
    constructor(spfxContext: WebPartContext, api: IDataAPI) {
        super(spfxContext, api, `/DirectorateUpdates`);
    }

    public async readLatestUpdateForPeriod(directorateId: number, period: Date): Promise<IDirectorateUpdate> {
        const du = await this.readAll(
            `?$top=1`
            + `&$expand=UpdateUser,Directorate($select=ID,Title,Objectives)`
            + `&$filter=DirectorateID eq ${directorateId} and UpdatePeriod eq ${period.toISOString()}`
            + `&$orderby=UpdateDate desc`
        );
        if (du.length > 0)
            return du[0];
    }

    public async readLastSignedOffUpdateForPeriod(directorateId: number, period: Date): Promise<IDirectorateUpdate> {
        const du = await this.readAll(
            `?$top=1`
            + `&$expand=OverallRagOption,FinanceRagOption,MetricsRagOption,MilestonesRagOption,PeopleRagOption`
            + `&$filter=DirectorateID eq ${directorateId} and UpdatePeriod eq ${period.toISOString()} and SignOffID ne null`
            + `&$orderby=SignOffID desc`
        );
        if (du.length > 0)
            return du[0];
    }
}