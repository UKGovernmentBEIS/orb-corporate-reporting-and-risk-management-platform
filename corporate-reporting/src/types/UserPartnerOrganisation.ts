import { IEntity, Entity } from "./Entity";
import { IUser } from "./User";
import { IPartnerOrganisation } from "./PartnerOrganisation";

export interface IUserPartnerOrganisation extends IEntity {
    UserID: number;
    PartnerOrganisationID: number;
    IsAdmin: boolean;
    HideHeadlines: boolean;
    HideMilestones: boolean;
    HideCustomSections: boolean;
    User?: IUser;
    PartnerOrganisation?: IPartnerOrganisation;
}

export class UserPartnerOrganisation extends Entity implements IUserPartnerOrganisation {
    public UserID = null;
    public PartnerOrganisationID = null;
    public IsAdmin = false;
    public HideHeadlines = false;
    public HideMilestones = false;
    public HideCustomSections = false;
}