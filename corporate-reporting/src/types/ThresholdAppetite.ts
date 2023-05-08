import { IThreshold } from "./Threshold";
import { IEntity, Entity } from "./Entity";

export interface IThresholdAppetite extends IEntity {
    ID: number;
    ThresholdID: number;
    RiskImpactLevelID: number;
    RiskProbabilityID: number;
    Acceptable: boolean;

    Threshold?: IThreshold;
    RiskProbability?: IEntity;
    RiskImpactLevel?: IEntity;

}

export class ThresholdAppetite extends Entity implements IThresholdAppetite {
    public ThresholdID = null;
    public RiskProbabilityID = null;
    public RiskImpactLevelID = null;
    public Acceptable = false;
}
