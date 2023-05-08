import { IRiskType } from "./RiskType";
import { IThresholdAppetite } from "./ThresholdAppetite";
import { IEntity, Entity } from "./Entity";

export interface IThreshold extends IEntity {
    Priority: number;

    RiskTypes?: IRiskType[];
    ThresholdAppetites?: IThresholdAppetite[];
}

export class Threshold extends Entity implements IThreshold {
    public Priority = null;
}