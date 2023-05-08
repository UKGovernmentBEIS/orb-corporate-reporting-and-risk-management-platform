import { IEntity } from '../types';
import { EntityService, IEntityService } from './EntityService';

export interface IEntityUpdateService<T> extends IEntityService<T> {
    readLatestUpdateForPeriod: (entityId: number, period: Date) => Promise<T>;
    readLastSignedOffUpdateForPeriod: (entityId: number, period: Date) => Promise<T>;
}

export abstract class EntityUpdateService<T extends IEntity> extends EntityService<T> implements IEntityUpdateService<T> {
    public abstract readLatestUpdateForPeriod(entityId: number, period: Date): Promise<T>;
    // // Example method to be implemented in inheriting class
    // const eu = await this.readAll(`?$top=1&$filter=ParentEntityID eq ${entityId} and UpdatePeriod eq ${period.toISOString()}&$orderby=UpdateDate desc`);
    // if (eu.length > 0)
    //     return eu[0];

    public abstract readLastSignedOffUpdateForPeriod(entityId: number, period: Date): Promise<T>;
    // // Example method to be implemented in inheriting class
    // const eu = await this.readAll(`?$top=1&$filter=EntityID eq ${entityId} and UpdatePeriod eq ${period.toISOString()} and SignOffID ne null&$orderby=SignOffID desc`);
    // if (eu.length > 0)
    //     return eu[0];
}