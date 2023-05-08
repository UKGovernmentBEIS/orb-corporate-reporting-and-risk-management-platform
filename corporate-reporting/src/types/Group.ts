import { IEntityWithStatus, EntityWithStatus } from "./EntityWithStatus";
import { IUser } from "./User";
import { IDirectorate } from "./Directorate";

export interface IGroup extends IEntityWithStatus {
    DirectorGeneralUserID: number;
    RiskChampionDeputyDirectorUserID: number;
    BusinessPartnerUserID: number;
    DirectorGeneralUser?: IUser;
    RiskChampionUser?: IUser;
    BusinessPartnerUser?: IUser;
    Directorates?: IDirectorate[];
}

export class Group extends EntityWithStatus implements IGroup {
    public DirectorGeneralUserID = null;
    public RiskChampionDeputyDirectorUserID = null;
    public BusinessPartnerUserID = null;
}