import { IUser } from "./User";
import { IReportingEntityWithDeliveryDates, ReportingEntityWithDeliveryDates } from "./ReportingEntity";
import { DayOfWeek } from 'office-ui-fabric-react';
import { ReportingFrequency } from "../refData/ReportingFrequency";

export interface IRiskMitigationAction extends IReportingEntityWithDeliveryDates {
    Description: string;
    RiskID: number;
    RiskMitigationActionCode: number;
    OwnerUserID: number;
    ActionIsOngoing: boolean;
    OngoingActionReviewFrequency: ReportingFrequency;
    OngoingActionReviewDueDay: DayOfWeek;
    OngoingActionReviewStartDate: Date;
    NextReviewDate?: Date;
    OwnerUser?: IUser;
}

export class RiskMitigationAction extends ReportingEntityWithDeliveryDates implements IRiskMitigationAction {
    public Description = '';
    public RiskID = null;
    public RiskMitigationActionCode = null;
    public OwnerUserID = null;
    public ActionIsOngoing = false;
    public OngoingActionReviewFrequency = null;
    public OngoingActionReviewDueDay = null;
    public OngoingActionReviewStartDate = null;
    public Contributors = [];
}
