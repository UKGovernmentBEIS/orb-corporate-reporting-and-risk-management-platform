import { IMilestone } from "./Milestone";
import { IReportingProgressUpdateWithDeliveryDates, ReportingProgressUpdateWithDeliveryDates } from "./ReportingProgressUpdate";

export interface IMilestoneUpdate extends IReportingProgressUpdateWithDeliveryDates {
    MilestoneID: number;
    Milestone?: IMilestone;
}

export class MilestoneUpdate extends ReportingProgressUpdateWithDeliveryDates implements IMilestoneUpdate {
    public MilestoneID = null;

    constructor(milestoneId: number, period?: Date) {
        super(period);
        this.MilestoneID = milestoneId;
    }
}