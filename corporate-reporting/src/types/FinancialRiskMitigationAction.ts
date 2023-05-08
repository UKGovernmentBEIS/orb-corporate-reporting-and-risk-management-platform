import { IFinancialRisk } from "./FinancialRisk";
import { IFinancialRiskMitigationActionUpdate } from "./FinancialRiskMitigationActionUpdate";
import { IRiskMitigationAction, RiskMitigationAction } from "./RiskMitigationAction";

export interface IFinancialRiskMitigationAction extends IRiskMitigationAction {
    FinancialRisk?: IFinancialRisk;
    FinancialRiskMitigationActionUpdates?: IFinancialRiskMitigationActionUpdate[];
}

export class FinancialRiskMitigationAction extends RiskMitigationAction implements IFinancialRiskMitigationAction { }
