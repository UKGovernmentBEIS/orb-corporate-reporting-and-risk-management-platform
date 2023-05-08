import { IEntity, Entity } from "./Entity";

export interface IEntityWithTimerange extends IEntity {
    StartUpdatePeriod?: Date;
    EndUpdatePeriod?: Date;
}

export class EntityWithTimerange extends Entity implements IEntityWithTimerange {
}