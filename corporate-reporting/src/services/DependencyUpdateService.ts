import { WebPartContext } from '@microsoft/sp-webpart-base';
import { EntityUpdateService } from './EntityUpdateService';
import { IDependencyUpdate, IDataAPI } from '../types';

export class DependencyUpdateService extends EntityUpdateService<IDependencyUpdate> {
    constructor(spfxContext: WebPartContext, api: IDataAPI) {
        super(spfxContext, api, `/DependencyUpdates`);
    }

    public async readLatestUpdateForPeriod(dependencyId: number, period: Date): Promise<IDependencyUpdate> {
        const d = await this.readAll(
            `?$top=1`
            + `&$expand=UpdateUser`
            + `&$filter=DependencyID eq ${dependencyId} and UpdatePeriod eq ${period.toISOString()}`
            + `&$orderby=UpdateDate desc`
        );
        if (d.length > 0)
            return d[0];
    }

    public async readLastSignedOffUpdateForPeriod(dependencyId: number, period: Date): Promise<IDependencyUpdate> {
        const d = await this.readAll(
            `?$top=1`
            + `&$filter=DependencyID eq ${dependencyId} and UpdatePeriod eq ${period.toISOString()} and SignOffID ne null`
            + `&$orderby=SignOffID desc`
        );
        if (d.length > 0)
            return d[0];
    }
}