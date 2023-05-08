import { WebPartContext } from '@microsoft/sp-webpart-base';
import { EntityService } from './EntityService';
import { IAttribute, IDataAPI } from '../types';

export class AttributeService extends EntityService<IAttribute> {
    constructor(spfxContext: WebPartContext, api: IDataAPI) {
        super(spfxContext, api, `/Attributes`);
    }

    public update(entityId: number, entity: Partial<IAttribute>): Promise<void> {
        const entityToPost = entity;
        delete entityToPost.AttributeType;
        return this.patchEntity(entityToPost, `${this.entityUrl}(${entityId})`);
    }

    public static attributesToBadgeStrings = (attributes: IAttribute[]): string[] => {
        return attributes?.filter(a => a.AttributeType?.Display).map(a => a.AttributeType?.Title);
    }
}