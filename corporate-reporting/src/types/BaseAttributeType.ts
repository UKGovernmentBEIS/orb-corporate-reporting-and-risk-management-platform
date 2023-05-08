import { IEntity, Entity } from "./Entity";

export interface IBaseAttributeType extends IEntity { 
    Display?: boolean;
}

export class BaseAttributeType extends Entity implements IBaseAttributeType {
}