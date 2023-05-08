import { IReportingEntity, ReportingEntity } from "./ReportingEntity";
import { IDirectorate } from "./Directorate";
import { IUser } from "./User";
import { IWorkStream } from "./WorkStream";
import { IBenefit } from "./Benefit";
import { IDependency } from "./Dependency";
import { IProjectUpdate } from "./ProjectUpdate";

export interface IProject extends IReportingEntity {
    DirectorateID: number;
    ParentProjectID: number;
    SeniorResponsibleOwnerUserID: number;
    ProjectManagerUserID: number;
    Objectives: string;
    StartDate: Date;
    EndDate: Date;
    ReportApproverUserID: number;
    ShowOnDirectorateReport: boolean;
    ReportingLeadUserID: number;
    CorporateProjectID: string;
    IntegrationID: string;
    IntegrationLastModified: Date;
    Directorate?: IDirectorate;
    SeniorResponsibleOwnerUser?: IUser;
    ProjectManagerUser?: IUser;
    ReportApproverUser?: IUser;
    ReportingLeadUser?: IUser;
    WorkStreams?: IWorkStream[];
    Benefits?: IBenefit[];
    Dependencies?: IDependency[];
    ProjectUpdates?: IProjectUpdate[];
}

export class Project extends ReportingEntity implements IProject {
    public DirectorateID = null;
    public ParentProjectID = null;
    public SeniorResponsibleOwnerUserID = null;
    public ProjectManagerUserID = null;
    public Objectives = '';
    public StartDate = null;
    public EndDate = null;
    public ReportApproverUserID = null;
    public ShowOnDirectorateReport = false;
    public ReportingLeadUserID = null;
    public CorporateProjectID = '';
    public IntegrationID = '';
    public IntegrationLastModified = null;
}