import { EntityService, IEntityService } from './EntityService';
import { EntityStatus } from '../refData/EntityStatus';
import { IEntityWithStatus } from '../types';

export interface IEntityWithStatusService<T extends IEntityWithStatus> extends IEntityService<T> {
    readAllForLookup: (includeClosedEntities?: boolean) => Promise<T[]>;
    readAllForList: (includeClosedEntities?: boolean) => Promise<T[]>;
}

export class EntityWithStatusService<T extends IEntityWithStatus> extends EntityService<T> {

    public readAllForLookup(includeClosedEntities?: boolean, additionalFields?: string): Promise<T[]> {
        return this.readAll(
            `?$select=ID,Title${additionalFields ? `,${additionalFields}` : ''}`
            + `&$orderby=Title`
            + (includeClosedEntities ? `` : `&$filter=EntityStatusID eq ${EntityStatus.Open}`)
        );
    }

    public readAllForList(includeClosedEntities?: boolean): Promise<T[]> {
        return this.readAll(includeClosedEntities ? null : `?$filter=EntityStatusID eq ${EntityStatus.Open}`);
    }
}