import { ReportingFrequency } from "../refData/ReportingFrequency";
import { IReportingCycle, IReportingEntity } from "../types";

export class ReportingCycleService {
    public static reportingCycleIsValid = (entity: IReportingEntity): boolean => {
        return ReportingCycleService.cycleIsValid({ frequency: entity.ReportingFrequency, dueDay: entity.ReportingDueDay, startDate: entity.ReportingStartDate });
    }

    public static cycleIsValid = ({ frequency, dueDay, startDate }: IReportingCycle): boolean => {
        if (frequency === ReportingFrequency.Daily) {
            return true;
        } else if (frequency === ReportingFrequency.Weekly) {
            return dueDay !== null;
        } else if (frequency === ReportingFrequency.Fortnightly) {
            return dueDay !== null && startDate !== null;
        } else if (frequency === ReportingFrequency.Monthly) {
            return dueDay !== null;
        } else if (frequency === ReportingFrequency.MonthlyWeekday) {
            return dueDay !== null;
        } else if (frequency === ReportingFrequency.Quarterly || frequency === ReportingFrequency.Biannually || frequency === ReportingFrequency.Annually) {
            return dueDay !== null && startDate !== null;
        } else {
            return false;
        }
    }
}
