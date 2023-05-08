import { IProgressUpdateWithDeliveryDates, ProgressUpdateWithDeliveryDates } from "./ProgressUpdate";
import { IPartnerOrganisationRiskMitigationAction } from "./PartnerOrganisationRiskMitigationAction";

export interface IPartnerOrganisationRiskMitigationActionUpdate extends IProgressUpdateWithDeliveryDates {
    PartnerOrganisationRiskMitigationActionID: number;
    SignOffID: number;
    PartnerOrganisationRiskMitigationAction?: IPartnerOrganisationRiskMitigationAction;
}

export class PartnerOrganisationRiskMitigationActionUpdate extends ProgressUpdateWithDeliveryDates implements IPartnerOrganisationRiskMitigationActionUpdate {
    public PartnerOrganisationRiskMitigationActionID = null;
    public SignOffID = null;

    constructor(riskMitigationActionId: number, period?: Date) {
        super(period);
        this.PartnerOrganisationRiskMitigationActionID = riskMitigationActionId;
    }
}