import { IRiskMitigationAction } from "./RiskMitigationAction";
import { IProgressUpdateWithDeliveryDates, ProgressUpdateWithDeliveryDates } from "./ProgressUpdate";

export interface IRiskMitigationActionUpdate extends IProgressUpdateWithDeliveryDates {
    RiskMitigationActionID: number;
    SignOffID: number;
    RiskMitigationAction?: IRiskMitigationAction;
}

export class RiskMitigationActionUpdate extends ProgressUpdateWithDeliveryDates implements IRiskMitigationActionUpdate {
    public RiskMitigationActionID = null;
    public SignOffID = null;

    constructor(riskMitigationActionId: number, period?: Date) {
        super(period);
        this.RiskMitigationActionID = riskMitigationActionId;
    }
}