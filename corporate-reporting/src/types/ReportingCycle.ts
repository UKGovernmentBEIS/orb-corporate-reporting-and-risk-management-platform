import { DayOfWeek } from 'office-ui-fabric-react';
import { ReportingFrequency } from '../refData/ReportingFrequency';

export interface IReportingCycle {
    frequency: ReportingFrequency;
    dueDay: DayOfWeek;
    startDate?: Date;
}

export interface IReportingCycleFields {
    frequency: string;
    dueDay: string;
    startDate: string;
}

export interface IEntityReportingCycle {
    ReportingFrequency: ReportingFrequency;
    ReportingDueDay: DayOfWeek;
    ReportingStartDate?: Date;
}