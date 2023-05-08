import { IBaseAttributeType, BaseAttributeType } from "./BaseAttributeType";

export interface IAttributeType extends IBaseAttributeType {
    Display: boolean;
}

export class AttributeType extends BaseAttributeType implements IAttributeType {
    public Display = false;
}
