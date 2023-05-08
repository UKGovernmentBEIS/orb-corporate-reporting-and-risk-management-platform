import { IEntity, Entity } from "./Entity";
import { IUser } from "./User";
import { IGroup } from "./Group";

export interface IUserGroup extends IEntity {
    UserID: number;
    GroupID: number;
    IsRiskAdmin: boolean;
    User?: IUser;
    Group?: IGroup;
}

export class UserGroup extends Entity implements IUserGroup {
    public UserID = null;
    public GroupID = null;
    public IsRiskAdmin = false;
}