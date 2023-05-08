import { IUserDirectorate } from "./UserDirectorate";
import { IUserProject } from "./UserProject";
import { IUserGroup } from "./UserGroup";
import { IUserRole } from "./UserRole";
import { IUserPartnerOrganisation } from "./UserPartnerOrganisation";

export interface IUserEntities {
    EntitiesTimestamp: number; // Timestamp for when permissions were loaded from server
    UserRoles: IUserRole[];
    UserGroups: IUserGroup[];
    UserDirectorates: IUserDirectorate[];
    UserProjects: IUserProject[];
    UserPartnerOrganisations: IUserPartnerOrganisation[];
    FinancialRiskUserGroups: IUserGroup[];
}

export class UserEntities implements IUserEntities {
    public EntitiesTimestamp = 0;
    public UserRoles = [];
    public UserGroups = [];
    public UserDirectorates = [];
    public UserProjects = [];
    public UserPartnerOrganisations = [];
    public FinancialRiskUserGroups = [];
}