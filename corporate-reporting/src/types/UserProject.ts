import { Entity, IEntity } from "./Entity";
import { IUser } from "./User";
import { IProject } from "./Project";

export interface IUserProject extends IEntity {
    UserID: number;
    ProjectID: number;
    IsAdmin: boolean;
    IsRiskAdmin: boolean;
    User?: IUser;
    Project?: IProject;
}

export class UserProject extends Entity implements IUserProject {
    public UserID = null;
    public ProjectID = null;
    public IsAdmin = false;
    public IsRiskAdmin = false;
}