import { WebPartContext } from '@microsoft/sp-webpart-base';
import { EntityService } from './EntityService';
import { IDataAPI } from '../types';
import { IEntityWithTimerange } from '../types/EntityWithTimerange';

export class RiskImpactLevelService extends EntityService<IEntityWithTimerange> {
    constructor(spfxContext: WebPartContext, api: IDataAPI) {
        super(spfxContext, api, `/RiskImpactLevels`);
    }

    public readAllForLookup(): Promise<IEntityWithTimerange[]> {
        return this.readAll(`?$select=ID,Title,Description,StartUpdatePeriod,EndUpdatePeriod&$orderby=ID desc`);
    }
}