import { ICorporateRiskMitigationAction } from "./CorporateRiskMitigationAction";
import { ICorporateRiskUpdate } from "./CorporateRiskUpdate";
import { IRisk, Risk } from "./Risk";

export interface ICorporateRisk extends IRisk {
    DepartmentalObjectiveID: number;
    RiskUpdates?: ICorporateRiskUpdate[];
    RiskMitigationActions?: ICorporateRiskMitigationAction[];
}

export class CorporateRisk extends Risk implements ICorporateRisk {
    public DepartmentalObjectiveID = null;
}
