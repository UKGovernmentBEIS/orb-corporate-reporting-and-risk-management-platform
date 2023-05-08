import { WebPartContext } from '@microsoft/sp-webpart-base';
import { IDataAPI, IPartnerOrganisationRiskMitigationActionUpdate } from '../types';
import { EntityUpdateService } from './EntityUpdateService';

export class PartnerOrganisationRiskMitigationActionUpdateService extends EntityUpdateService<IPartnerOrganisationRiskMitigationActionUpdate> {
    constructor(spfxContext: WebPartContext, api: IDataAPI) {
        super(spfxContext, api, `/PartnerOrganisationRiskMitigationActionUpdates`);
    }

    public async readLatestUpdateForPeriod(riskMitigationActionId: number, period: Date): Promise<IPartnerOrganisationRiskMitigationActionUpdate> {
        const ru = await this.readAll(
            `?$top=1`
            + `&$filter=PartnerOrganisationRiskMitigationActionID eq ${riskMitigationActionId} and UpdatePeriod eq ${period.toISOString()}`
            + `&$expand=UpdateUser($select=ID,Title)`
            + `&$orderby=UpdateDate desc`
        );
        if (ru.length > 0)
            return ru[0];
    }

    public async readLastSignedOffUpdateForPeriod(riskMitigationActionId: number, period: Date): Promise<IPartnerOrganisationRiskMitigationActionUpdate> {
        const ru = await this.readAll(
            `?$top=1`
            + `&$filter=PartnerOrganisationRiskMitigationActionID eq ${riskMitigationActionId} and UpdatePeriod eq ${period.toISOString()} and SignOffID ne null`
            + `&$orderby=UpdateDate desc`
        );
        if (ru.length > 0)
            return ru[0];
    }
}