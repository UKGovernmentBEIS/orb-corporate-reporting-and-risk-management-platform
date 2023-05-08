import { WebPartContext } from '@microsoft/sp-webpart-base';
import { EntityService } from './EntityService';
import { IDataAPI, IEntity } from '../types';

export class RiskRegisterService extends EntityService<IEntity> {
    constructor(spfxContext: WebPartContext, api: IDataAPI) {
        super(spfxContext, api, `/RiskRegisters`);
    }

    public readAllForLookup(): Promise<IEntity[]> {
        return this.readAll(`?$select=ID,Title&$orderby=ID`);
    }
}