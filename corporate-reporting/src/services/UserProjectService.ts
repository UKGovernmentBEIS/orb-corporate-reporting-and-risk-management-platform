import { WebPartContext } from '@microsoft/sp-webpart-base';
import { EntityService } from './EntityService';
import { ContextService } from './ContextService';
import { IUserProject, IDataAPI } from '../types';

export class UserProjectService extends EntityService<IUserProject> {
    constructor(spfxContext: WebPartContext, api: IDataAPI) {
        super(spfxContext, api, `/UserProjects`);
    }

    public readAllForList(): Promise<IUserProject[]> {
        return this.readAll(`?$orderby=User/Title&$expand=User,Project`);
    }

    public readMyProjects(): Promise<IUserProject[]> {
        return this.readAll(`?$filter=User/Username eq '${encodeURIComponent(ContextService.Username(this.spfxContext))}'`);
    }

    public readProjectAdmins(projectId: number): Promise<IUserProject[]> {
        return this.readAll(`?$filter=ProjectID eq ${projectId} and IsAdmin eq true&$expand=User`);
    }

    public readAllForLookup(): Promise<IUserProject[]> {
        return this.readAll(`?$select=ID,Title,ProjectID,UserID&$orderby=Title`);
    }

    public checkForDuplicates = (userId: number, projectId: number): Promise<IUserProject[]> => {
        return this.readAll(`?$filter=UserID eq ${userId} and ProjectID eq ${projectId}&$select=ID`);
    }
}