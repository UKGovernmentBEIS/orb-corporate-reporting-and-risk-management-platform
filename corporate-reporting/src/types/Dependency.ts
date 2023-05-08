import { IReportingEntityWithDeliveryDates, ReportingEntityWithDeliveryDates } from "./ReportingEntity";
import { IProject } from "./Project";
import { IUser } from "./User";
import { IDependencyUpdate } from "./DependencyUpdate";

export interface IDependency extends IReportingEntityWithDeliveryDates {
    ProjectID: number;
    ThirdParty: string;
    RagOptionID: number;
    LeadUserID: number;
    StartDate: Date;
    EndDate: Date;

    Project?: IProject;
    LeadUser?: IUser;
    DependencyUpdates?: IDependencyUpdate[];
}

export class Dependency extends ReportingEntityWithDeliveryDates implements IDependency {
    public ProjectID = null;
    public ThirdParty = '';
    public RagOptionID = null;
    public LeadUserID = null;
    public StartDate = null;
    public EndDate = null;
    public Contributors = [];
}
