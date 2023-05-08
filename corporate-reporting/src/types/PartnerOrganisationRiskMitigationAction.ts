import { IUser } from "./User";
import { IPartnerOrganisationRisk } from "./PartnerOrganisationRisk";
import { IReportingEntityWithDeliveryDates, ReportingEntityWithDeliveryDates } from "./ReportingEntity";
import { IPartnerOrganisationRiskMitigationActionUpdate } from "./PartnerOrganisationRiskMitigationActionUpdate";

export interface IPartnerOrganisationRiskMitigationAction extends IReportingEntityWithDeliveryDates {
    Description: string;
    PartnerOrganisationRiskID: number;
    RiskMitigationActionCode: number;
    OwnerUserID: number;
    ActionIsOngoing: boolean;
    PartnerOrganisationRisk?: IPartnerOrganisationRisk;
    OwnerUser?: IUser;
    PartnerOrganisationRiskMitigationActionUpdates?: IPartnerOrganisationRiskMitigationActionUpdate[];
}

export class PartnerOrganisationRiskMitigationAction extends ReportingEntityWithDeliveryDates implements IPartnerOrganisationRiskMitigationAction {
    public Description = '';
    public PartnerOrganisationRiskID = null;
    public RiskMitigationActionCode = null;
    public OwnerUserID = null;
    public ActionIsOngoing = false;
    public Contributors = [];
}