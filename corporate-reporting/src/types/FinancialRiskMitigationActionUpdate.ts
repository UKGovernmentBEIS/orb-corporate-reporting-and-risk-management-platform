import { IRiskMitigationActionUpdate, RiskMitigationActionUpdate } from "./RiskMitigationActionUpdate";
import { IFinancialRiskMitigationAction } from "./FinancialRiskMitigationAction";

export interface IFinancialRiskMitigationActionUpdate extends IRiskMitigationActionUpdate {
    FinancialRiskMitigationAction?: IFinancialRiskMitigationAction;
}

export class FinancialRiskMitigationActionUpdate extends RiskMitigationActionUpdate implements IFinancialRiskMitigationActionUpdate { }