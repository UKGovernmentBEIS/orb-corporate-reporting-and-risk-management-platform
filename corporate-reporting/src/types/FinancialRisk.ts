import { RiskRegister } from "../refData/RiskRegister";
import { IFinancialRiskMitigationAction } from "./FinancialRiskMitigationAction";
import { IFinancialRiskUpdate } from "./FinancialRiskUpdate";
import { IRisk, Risk } from "./Risk";

export interface IFinancialRisk extends IRisk {
    OwnedByDgOffice: boolean;
    OwnedByMultipleGroups: boolean;
    StaffNonStaffSpend: string;
    FundingClassification: string[];
    EconomicRingfence: string[];
    PolicyRingfence: string[];
    UniformChartOfAccountsID: string;

    FinancialRiskUpdates?: IFinancialRiskUpdate[];
    FinancialRiskMitigationActions?: IFinancialRiskMitigationAction[];
}

export class FinancialRisk extends Risk implements IFinancialRisk {
    public OwnedByDgOffice = false;
    public OwnedByMultipleGroups = false;
    public StaffNonStaffSpend = null;
    public FundingClassification = [];
    public RiskRegisterID = RiskRegister.Financial;
    public EconomicRingfence = [];
    public PolicyRingfence = [];
    public UniformChartOfAccountsID = null;
}
