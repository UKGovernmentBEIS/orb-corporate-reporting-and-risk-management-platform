import { IEntity } from "./Entity";

export interface IReportingFrequency extends IEntity {
    RemindAuthorsDaysBeforeDue: number;
    RemindApproverDaysBeforeDue: number;
    EarlyUpdateWarningDays: number;
}