import { WebPartContext } from '@microsoft/sp-webpart-base';
import { EntityService } from './EntityService';
import { IDataAPI, IEntity } from '../types';

export class ProjectBusinessCaseTypeService extends EntityService<IEntity> {
    constructor(spfxContext: WebPartContext, api: IDataAPI) {
        super(spfxContext, api, `/ProjectBusinessCaseTypes`);
    }
}