import { EntityStatus } from "../refData/EntityStatus";
import { IEntity, Entity } from "./Entity";

export interface IEntityWithStatus extends IEntity {
    EntityStatusID: number;
    EntityStatusDate: Date;
    EntityStatus?: IEntity;
}

export class EntityWithStatus extends Entity implements IEntityWithStatus {
    public EntityStatusID = EntityStatus.Open;
    public EntityStatusDate = null;
}
