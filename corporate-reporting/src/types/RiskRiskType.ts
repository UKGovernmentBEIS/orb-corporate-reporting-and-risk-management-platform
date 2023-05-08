import { IEntity, Entity } from "./Entity";
import { IRiskType } from "./RiskType";

export interface IRiskRiskType extends IEntity {
    RiskID: number;
    RiskTypeID: number;
    RiskType?: IRiskType;
}

export class RiskRiskType extends Entity implements IRiskRiskType {
    public RiskID = null;
    public RiskTypeID = null;

}