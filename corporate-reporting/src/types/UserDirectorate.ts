import { IEntity, Entity } from "./Entity";
import { IUser } from "./User";
import { IDirectorate } from "./Directorate";

export interface IUserDirectorate extends IEntity {
    UserID: number;
    DirectorateID: number;
    IsAdmin: boolean;
    IsRiskAdmin: boolean;
    User?: IUser;
    Directorate?: IDirectorate;
}

export class UserDirectorate extends Entity implements IUserDirectorate {
    public UserID = null;
    public DirectorateID = null;
    public IsAdmin = false;
    public IsRiskAdmin = false;
}