import { IFinancialRiskMitigationAction } from "./FinancialRiskMitigationAction";
import { IFinancialRisk } from "./FinancialRisk";
import { IRiskRiskMitigationAction, RiskRiskMitigationAction } from "./RiskRiskMitigationAction";

export interface IFinancialRiskRiskMitigationAction extends IRiskRiskMitigationAction {
    Risk?: IFinancialRisk;
    RiskMitigationAction?: IFinancialRiskMitigationAction;
}

export class FinancialRiskRiskMitigationAction extends RiskRiskMitigationAction implements IFinancialRiskRiskMitigationAction { }