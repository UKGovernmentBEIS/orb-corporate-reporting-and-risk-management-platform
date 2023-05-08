import { WebPartContext } from '@microsoft/sp-webpart-base';
import { EntityService } from './EntityService';
import { ContextService } from './ContextService';
import { IUserGroup, IDataAPI } from '../types';

export class FinancialRiskUserGroupService extends EntityService<IUserGroup> {
    constructor(spfxContext: WebPartContext, api: IDataAPI) {
        super(spfxContext, api, `/FinancialRiskUserGroups`);
    }

    public readAllForList(): Promise<IUserGroup[]> {
        return this.readAll(`?$orderby=User/Title&$expand=User,Group`);
    }

    public readAllForLookup(): Promise<IUserGroup[]> {
        return this.readAll(`?$select=ID,Title,GroupID,UserID&$orderby=Title`);
    }

    public readMyGroups(): Promise<IUserGroup[]> {
        return this.readAll(`?$filter=User/Username eq '${encodeURIComponent(ContextService.Username(this.spfxContext))}'`);
    }

    public checkForDuplicates = (userId: number, groupId: number): Promise<IUserGroup[]> => {
        return this.readAll(`?$filter=UserID eq ${userId} and GroupID eq ${groupId}&$select=ID`);
    }
}