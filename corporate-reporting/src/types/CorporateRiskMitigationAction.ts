import { ICorporateRiskRiskMitigationAction } from ".";
import { ICorporateRisk } from "./CorporateRisk";
import { IRiskMitigationAction, RiskMitigationAction } from "./RiskMitigationAction";
import { IRiskMitigationActionUpdate } from "./RiskMitigationActionUpdate";

export interface ICorporateRiskMitigationAction extends IRiskMitigationAction {
    Risk?: ICorporateRisk;
    CorporateRiskRiskMitigationActions?: ICorporateRiskRiskMitigationAction[];
    RiskMitigationActionUpdates?: IRiskMitigationActionUpdate[];
}

export class CorporateRiskMitigationAction extends RiskMitigationAction implements ICorporateRiskMitigationAction { 
    public CorporateRiskRiskMitigationActions = [];
}
