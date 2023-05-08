import { IEntity, Entity } from "./Entity";
import { IUser } from "./User";

export interface IUserRole extends IEntity {
    UserID: number;
    RoleID: number;
    User?: IUser;
    Role?: IEntity;
}

export class UserRole extends Entity implements IUserRole {
    public UserID = null;
    public RoleID = null;
}