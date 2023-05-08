import { ICorporateRiskMitigationAction } from "./CorporateRiskMitigationAction";
import { ICorporateRisk } from "./CorporateRisk";
import { IRiskRiskMitigationAction, RiskRiskMitigationAction } from "./RiskRiskMitigationAction";

export interface ICorporateRiskRiskMitigationAction extends IRiskRiskMitigationAction {
    Risk?: ICorporateRisk;
    RiskMitigationAction?: ICorporateRiskMitigationAction;
}

export class CorporateRiskRiskMitigationAction extends RiskRiskMitigationAction implements ICorporateRiskRiskMitigationAction { }