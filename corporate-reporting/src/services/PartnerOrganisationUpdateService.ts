import { WebPartContext } from '@microsoft/sp-webpart-base';
import { EntityUpdateService } from './EntityUpdateService';
import { IPartnerOrganisationUpdate, IDataAPI } from '../types';

export class PartnerOrganisationUpdateService extends EntityUpdateService<IPartnerOrganisationUpdate> {
    constructor(spfxContext: WebPartContext, api: IDataAPI) {
        super(spfxContext, api, `/PartnerOrganisationUpdates`);
    }

    public async readLatestUpdateForPeriod(partnerOrganisationId: number, period: Date): Promise<IPartnerOrganisationUpdate> {
        const pu = await this.readAll(
            `?$top=1`
            + `&$expand=UpdateUser,PartnerOrganisation`
            + `&$filter=PartnerOrganisationID eq ${partnerOrganisationId} and UpdatePeriod eq ${period.toISOString()}`
            + `&$orderby=UpdateDate desc`
        );
        if (pu.length > 0)
            return pu[0];
    }

    public async readLastSignedOffUpdateForPeriod(partnerOrganisationId: number, period: Date): Promise<IPartnerOrganisationUpdate> {
        const pu = await this.readAll(
            `?$top=1`
            + `&$expand=OverallRagOption,FinanceRagOption,KPIRagOption,MilestonesRagOption,PeopleRagOption`
            + `&$filter=PartnerOrganisationID eq ${partnerOrganisationId} and UpdatePeriod eq ${period.toISOString()} and SignOffID ne null`
            + `&$orderby=SignOffID desc`
        );
        if (pu.length > 0)
            return pu[0];
    }
}