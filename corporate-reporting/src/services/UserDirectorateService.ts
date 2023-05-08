import { WebPartContext } from '@microsoft/sp-webpart-base';
import { EntityService } from './EntityService';
import { ContextService } from './ContextService';
import { IUserDirectorate, IDataAPI } from '../types';

export class UserDirectorateService extends EntityService<IUserDirectorate> {
    constructor(spfxContext: WebPartContext, api: IDataAPI) {
        super(spfxContext, api, `/UserDirectorates`);
    }

    public readAllForList(): Promise<IUserDirectorate[]> {
        return this.readAll(`?$orderby=User/Title&$expand=User,Directorate`);
    }

    public readMyDirectorates(): Promise<IUserDirectorate[]> {
        return this.readAll(`?$filter=User/Username eq '${encodeURIComponent(ContextService.Username(this.spfxContext))}'`);
    }

    public readDirectorateAdmins(directorateId: number): Promise<IUserDirectorate[]> {
        return this.readAll(`?$filter=DirectorateID eq ${directorateId} and IsAdmin eq true&$expand=User`);
    }

    public readAllForLookup(): Promise<IUserDirectorate[]> {
        return this.readAll(`?$select=ID,Title,DirectorateID,UserID&$orderby=Title`);
    }

    public checkForDuplicates = (userId: number, directorateId: number): Promise<IUserDirectorate[]> => {
        return this.readAll(`?$filter=UserID eq ${userId} and DirectorateID eq ${directorateId}&$select=ID`);
    }
}