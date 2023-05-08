import { WebPartContext } from '@microsoft/sp-webpart-base';
import { EntityService } from './EntityService';
import { IUserRole, IDataAPI } from '../types';

export class UserRoleService extends EntityService<IUserRole> {
    constructor(spfxContext: WebPartContext, api: IDataAPI) {
        super(spfxContext, api, `/UserRoles`);
    }

    public readAllForList(): Promise<IUserRole[]> {
        return this.readAll(`?$orderby=User/Title&$expand=User,Role`);
    }

    public checkForDuplicates = (userId: number, roleId: number): Promise<IUserRole[]> => {
        return this.readAll(`?$filter=UserID eq ${userId} and RoleID eq ${roleId}&$select=ID`);
    }
}