import { IRiskMitigationActionUpdate, RiskMitigationActionUpdate } from "./RiskMitigationActionUpdate";
import { ICorporateRiskMitigationAction } from "./CorporateRiskMitigationAction";

export interface ICorporateRiskMitigationActionUpdate extends IRiskMitigationActionUpdate {
    RiskMitigationActionID: number;
    SignOffID: number;
    RiskMitigationAction?: ICorporateRiskMitigationAction;
}

export class CorporateRiskMitigationActionUpdate extends RiskMitigationActionUpdate implements ICorporateRiskMitigationActionUpdate { }