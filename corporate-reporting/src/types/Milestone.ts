import { IEntity } from "./Entity";
import { IUser } from "./User";
import { IAttribute } from "./Attribute";
import { IKeyWorkArea } from "./KeyWorkArea";
import { IWorkStream } from "./WorkStream";
import { IReportingEntityWithDeliveryDates, ReportingEntityWithDeliveryDates } from "./ReportingEntity";
import { IPartnerOrganisation } from "./PartnerOrganisation";
import { IMilestoneUpdate } from "./MilestoneUpdate";

export interface IMilestone extends IReportingEntityWithDeliveryDates {
    MilestoneCode: string;
    StartDate: Date;
    MilestoneTypeID: number;
    Attributes: IAttribute[];
    LeadUserID: number;
    RagOptionID: number;
    WorkStreamID: number;
    KeyWorkAreaID: number;
    PartnerOrganisationID: number;
    LeadUser?: IUser;
    MilestoneType?: IEntity;
    KeyWorkArea?: IKeyWorkArea;
    WorkStream?: IWorkStream;
    PartnerOrganisation?: IPartnerOrganisation;
    Description: string;
    MilestoneUpdates?: IMilestoneUpdate[];
}

export class Milestone extends ReportingEntityWithDeliveryDates implements IMilestone {
    public MilestoneCode = '';
    public StartDate = null;
    public MilestoneTypeID = null;
    public Attributes = [];
    public LeadUserID = null;
    public RagOptionID = null;
    public WorkStreamID = null;
    public KeyWorkAreaID = null;
    public PartnerOrganisationID = null;
    public Description = '';
}