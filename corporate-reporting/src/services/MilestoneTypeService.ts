import { WebPartContext } from '@microsoft/sp-webpart-base';
import { EntityService } from './EntityService';
import { IEntity, IDataAPI, IEntityChildren } from '../types';

export class MilestoneTypeService extends EntityService<IEntity> {
    constructor(spfxContext: WebPartContext, api: IDataAPI) {
        super(spfxContext, api, `/MilestoneTypes`);
    }

    public async entityChildren(id: number): Promise<IEntityChildren[]> {
        return this.entityChildrenSingle(id, 'Milestones', 'Milestones', true);
    }
}