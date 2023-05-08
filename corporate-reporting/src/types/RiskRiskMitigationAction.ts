import { IRiskMitigationAction } from ".";
import { IEntity, Entity } from "./Entity";
import { IRisk } from "./Risk";

export interface IRiskRiskMitigationAction extends IEntity {
    RiskID: number;
    RiskMitigationActionID: number;
    Risk?: IRisk;
    RiskMitigationAction?: IRiskMitigationAction;
}

export class RiskRiskMitigationAction extends Entity implements IRiskRiskMitigationAction {
    public RiskID = null;
    public RiskMitigationActionID = null;
}