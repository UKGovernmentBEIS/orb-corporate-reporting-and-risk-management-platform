import { IThreshold } from "./Threshold";
import { IEntity, Entity } from "./Entity";

export interface IRiskType extends IEntity {
    ThresholdID: number;
    Threshold?: IThreshold;
}

export class RiskType extends Entity implements IRiskType {
    public ThresholdID = null;
}