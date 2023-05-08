import { IEntity } from "./Entity";
import { IUser } from "./User";
import { IProject } from "./Project";
import { IReportingEntityWithDeliveryDates, ReportingEntityWithDeliveryDates } from "./ReportingEntity";
import { IBenefitUpdate } from "./BenefitUpdate";

export interface IBenefit extends IReportingEntityWithDeliveryDates {
    ProjectID: number;
    BenefitTypeID: number;
    MeasurementUnitID: number;
    TargetPerformanceUpperLimit: number | string;
    TargetPerformanceLowerLimit: number | string;
    LeadUserID: number;
    RagOptionID: number;
    BenefitType?: IEntity;
    LeadUser?: IUser;
    Project?: IProject;
    MeasurementUnit?: IEntity;
    Description: string;
    BenefitUpdates?: IBenefitUpdate[];
}

export class Benefit extends ReportingEntityWithDeliveryDates implements IBenefit {
    public ProjectID = null;
    public BenefitTypeID = null;
    public MeasurementUnitID = null;
    public TargetPerformanceLowerLimit = '';
    public TargetPerformanceUpperLimit = '';
    public LeadUserID = null;
    public RagOptionID = null;
    public ReportingFrequency = null;
    public Description = '';
}