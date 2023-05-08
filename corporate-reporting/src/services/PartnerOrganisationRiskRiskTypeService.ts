import { WebPartContext } from '@microsoft/sp-webpart-base';
import { EntityService } from './EntityService';
import { IDataAPI } from '../types';
import { IPartnerOrganisationRiskRiskType } from '../types/PartnerOrganisationRiskRiskType';

export class PartnerOrganisationRiskRiskTypeService extends EntityService<IPartnerOrganisationRiskRiskType> {
    constructor(spfxContext: WebPartContext, api: IDataAPI) {
        super(spfxContext, api, `/PartnerOrganisationRiskRiskTypes`);
    }
}