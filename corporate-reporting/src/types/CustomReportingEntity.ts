import { ICustomReportingEntityType } from "./CustomReportingEntityType";
import { ICustomReportingEntityUpdate } from "./CustomReportingEntityUpdate";
import { IDirectorate } from "./Directorate";
import { IEntity } from "./Entity";
import { IPartnerOrganisation } from "./PartnerOrganisation";
import { IProject } from "./Project";
import { IReportingEntityWithDeliveryDates, ReportingEntityWithDeliveryDates } from "./ReportingEntity";
import { IUser } from "./User";

export interface ICustomReportingEntity extends IReportingEntityWithDeliveryDates {
    ReportingEntityTypeID: number;
    LeadUserID: number;
    DirectorateID: number;
    ProjectID: number;
    PartnerOrganisationID: number;
    TargetPerformanceUpperLimit: number | string;
    TargetPerformanceLowerLimit: number | string;
    MeasurementUnitID: number;

    MeasurementUnit?: IEntity;
    ReportingEntityType?: ICustomReportingEntityType;
    Directorate?: IDirectorate;
    Project?: IProject;
    PartnerOrganisation?: IPartnerOrganisation;
    LeadUser?: IUser;
    ReportingEntityUpdates?: ICustomReportingEntityUpdate[];
}

export class CustomReportingEntity extends ReportingEntityWithDeliveryDates implements ICustomReportingEntity {
    public ReportingEntityTypeID = null;
    public LeadUserID = null;
    public DirectorateID = null;
    public ProjectID = null;
    public PartnerOrganisationID = null;
    public TargetPerformanceUpperLimit = '';
    public TargetPerformanceLowerLimit = '';
    public MeasurementUnitID = null;

    constructor(reportingEntityTypeId: number) {
        super();
        this.ReportingEntityTypeID = reportingEntityTypeId;
    }
}
