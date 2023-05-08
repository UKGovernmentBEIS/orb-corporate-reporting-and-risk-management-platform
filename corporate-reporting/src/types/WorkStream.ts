import { IReportingEntity, ReportingEntity } from './ReportingEntity';
import { IProject } from './Project';
import { IUser } from './User';
import { IMilestone } from './Milestone';
import { IWorkStreamUpdate } from './WorkStreamUpdate';

export interface IWorkStream extends IReportingEntity {
    WorkStreamCode: string;
    ProjectID: number;
    LeadUserID: number;
    RagOptionID: number;
    Project?: IProject;
    LeadUser?: IUser;
    Milestones?: IMilestone[];
    WorkStreamUpdates?: IWorkStreamUpdate[];
}

export class WorkStream extends ReportingEntity implements IWorkStream {
    public WorkStreamCode = '';
    public ProjectID = null;
    public LeadUserID = null;
    public RagOptionID = null;
}