import { WebPartContext } from '@microsoft/sp-webpart-base';
import { EntityService } from './EntityService';
import { IDataAPI, IUserPartnerOrganisation } from '../types';

export class UserPartnerOrganisationService extends EntityService<IUserPartnerOrganisation> {
    constructor(spfxContext: WebPartContext, api: IDataAPI) {
        super(spfxContext, api, `/UserPartnerOrganisations`);
    }

    public readAllForList(): Promise<IUserPartnerOrganisation[]> {
        return this.readAll(`?$orderby=User/Title&$expand=User,PartnerOrganisation`);
    }

    public readPartnerOrganisationAdmins = (partnerOrganisationId: number): Promise<IUserPartnerOrganisation[]> => {
        return this.readAll(`?$filter=PartnerOrganisationID eq ${partnerOrganisationId} and IsAdmin eq true&$expand=User`);
    }

    public readAllForLookup(): Promise<IUserPartnerOrganisation[]> {
        return this.readAll(`?$select=ID,Title,PartnerOrganisationID,UserID&$orderby=Title`);
    }

    public checkForDuplicates = (userId: number, partnerOrganisationId: number): Promise<IUserPartnerOrganisation[]> => {
        return this.readAll(`?$filter=UserID eq ${userId} and PartnerOrganisationID eq ${partnerOrganisationId}&$select=ID`);
    }
}