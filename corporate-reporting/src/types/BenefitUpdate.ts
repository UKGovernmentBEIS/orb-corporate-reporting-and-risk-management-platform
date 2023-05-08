import { IBenefit } from "./Benefit";
import { IReportingProgressUpdateWithDeliveryDates, ReportingProgressUpdateWithDeliveryDates } from "./ReportingProgressUpdate";

export interface IBenefitUpdate extends IReportingProgressUpdateWithDeliveryDates {
    BenefitID: number;
    CurrentPerformance: number | string;
    Benefit?: IBenefit;
}

export class BenefitUpdate extends ReportingProgressUpdateWithDeliveryDates implements IBenefitUpdate {
    public BenefitID = null;
    public CurrentPerformance = '';

    constructor(benefitId: number, period?: Date) {
        super(period);
        this.BenefitID = benefitId;
    }
}