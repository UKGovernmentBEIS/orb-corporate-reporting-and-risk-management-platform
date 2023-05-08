import { DataService } from './DataService';
import { WebPartContext } from '@microsoft/sp-webpart-base';
import { IDataAPI, IEntity, IEntityChildren } from '../types';

export interface IEntityService<T> {
    parentEntities: string[];

    read: (id: number, includeParents?: boolean, includeChildren?: boolean, customExpandEntities?: string[]) => Promise<T>;
    readAll: (querystring?: string) => Promise<T[]>;
    readAllForList: () => Promise<T[]>;
    readAllForLookup: () => Promise<T[]>;
    create: (entity: T) => Promise<T>;
    update: (entityId: number, entity: Partial<T>) => Promise<void>;
    delete: (entityId: number) => Promise<void>;
    entityChildren: (id: number, childEntityName?: string, childEntityUrl?: string, canBeAdopted?: boolean) => Promise<IEntityChildren[]>;
}

export class EntityService<T extends IEntity> extends DataService<T> implements IEntityService<T> {
    protected entityUrl: string;
    public readonly parentEntities = [];
    protected childrenEntities: string[] = [];

    constructor(spfxContext: WebPartContext, api: IDataAPI, entityUrl: string) {
        super(spfxContext, api);
        this.entityUrl = `${api.URL}${entityUrl}`;
    }

    public async read(id: number, includeParents?: boolean, includeChildren?: boolean, customExpandEntities?: string[], customUrl?: string): Promise<T> {
        const entitiesToExpand: string[] = [];
        if (includeParents)
            entitiesToExpand.push(...this.parentEntities);
        if (includeChildren)
            entitiesToExpand.push(...this.childrenEntities);
        if (customExpandEntities)
            entitiesToExpand.push(...customExpandEntities);
        const expand: string = entitiesToExpand.length > 0 ? `?$expand=${entitiesToExpand.join(',')}` : '';
        return await this.getEntity(`${this.entityUrl}${customUrl ? customUrl : `(${id})`}${expand}`);
    }

    public async readAll(querystring?: string): Promise<T[]> {
        return await this.getEntities(this.entityUrl + (querystring || '?$orderby=Title'));
    }

    public async readAllQuery(query: string): Promise<T[]> {
        return await this.postQuery(`${this.entityUrl}/$query`, query);
    }

    public async readForLookup(id: number): Promise<T> {
        return this.read(id, false, false, [], `(${id})?$select=ID,Title`);
    }

    public readAllForLookup(): Promise<T[]> {
        return this.readAll(`?$select=ID,Title&$orderby=Title`);
    }

    public readAllForList(): Promise<T[]> {
        return this.readAll(`?$orderby=Title`);
    }

    public async create(entity: T): Promise<T> {
        return await this.postEntity(entity, this.entityUrl);
    }

    public update(entityId: number, entity: Partial<T>): Promise<void> {
        return this.patchEntity(entity, `${this.entityUrl}(${entityId})`);
    }

    public delete(entityId: number): Promise<void> {
        return this.deleteEntity(`${this.entityUrl}(${entityId})`);
    }

    protected async entityChildrenSingle(id: number, childEntityName: string, childEntityUrl: string, canBeAdopted: boolean): Promise<IEntityChildren[]> {
        return [
            { ChildType: childEntityName, CanBeAdopted: canBeAdopted, ChildIDs: (await this.getEntities(`${this.entityUrl}(${id})/${childEntityUrl}?$select=ID&$top=10`)).map(d => d.ID) }
        ];
    }

    public async entityChildren(id: number, childEntityName: string, childEntityUrl: string, canBeAdopted: boolean): Promise<IEntityChildren[]> {
        return this.entityChildrenSingle(id, childEntityName, childEntityUrl, canBeAdopted);
    }

    protected deduplicate(resultSets: T[][]): T[] {
        const distinctTs: T[] = [];
        resultSets.forEach(resultSet =>
            resultSet.forEach(result =>
                !distinctTs.some(e => e.ID === result.ID) && distinctTs.push(result)
            )
        );
        return distinctTs;
    }
}