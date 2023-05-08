import { WebPartContext } from '@microsoft/sp-webpart-base';
import { EntityService } from './EntityService';
import { IDataAPI } from '../types';
import { IEntityWithTimerange } from '../types/EntityWithTimerange';

export class RiskProbabilityService extends EntityService<IEntityWithTimerange> {
    constructor(spfxContext: WebPartContext, api: IDataAPI) {
        super(spfxContext, api, `/RiskProbabilities`);
    }

    public readAllForLookup(): Promise<IEntityWithTimerange[]> {
        return this.readAll(`?$select=ID,Title,StartUpdatePeriod,EndUpdatePeriod&$orderby=ID desc`);
    }
}