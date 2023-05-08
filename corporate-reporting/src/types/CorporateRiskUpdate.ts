import { ICorporateRisk } from "./CorporateRisk";
import { IRiskUpdate, RiskUpdate } from "./RiskUpdate";

export interface ICorporateRiskUpdate extends IRiskUpdate {
    Risk?: ICorporateRisk;
}

export class CorporateRiskUpdate extends RiskUpdate implements ICorporateRiskUpdate { }