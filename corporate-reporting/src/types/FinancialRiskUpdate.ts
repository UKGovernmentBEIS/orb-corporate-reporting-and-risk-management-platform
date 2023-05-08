import { IFinancialRisk } from "./FinancialRisk";
import { IRiskUpdate, RiskUpdate } from "./RiskUpdate";

export interface IFinancialRiskUpdate extends IRiskUpdate {
    Measurements: {
        SpendProfileNotApplicable: boolean;
        SpendProfile: { FinancialYear0: number | string, FinancialYear1: number | string, FinancialYear2: number | string, FinancialYear3: number | string, FinancialYear4: number | string };
    };
    FinancialRisk?: IFinancialRisk;
}

export class FinancialRiskUpdate extends RiskUpdate implements IFinancialRiskUpdate {
    public Measurements = {
        SpendProfileNotApplicable: false,
        SpendProfile: { FinancialYear0: '', FinancialYear1: '', FinancialYear2: '', FinancialYear3: '', FinancialYear4: '' }
    };
}