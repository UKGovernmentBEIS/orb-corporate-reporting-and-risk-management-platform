import { WebPartContext } from '@microsoft/sp-webpart-base';
import { EntityUpdateService } from './EntityUpdateService';
import { IDataAPI, IPartnerOrganisationRiskUpdate } from '../types';
import { sub } from 'date-fns';

export class PartnerOrganisationRiskUpdateService extends EntityUpdateService<IPartnerOrganisationRiskUpdate> {
    public parentEntities = [
        'UpdateUser',
        'RiskImpactLevel',
        'RiskProbability',
        'BeisRiskImpactLevel',
        'BeisRiskProbability',
        'PartnerOrganisationRisk($expand=RiskMitigationActions,UnmitigatedRiskImpactLevel,UnmitigatedRiskProbability,RiskAppetite)'
    ];
    protected childrenEntities = [];

    constructor(spfxContext: WebPartContext, api: IDataAPI) {
        super(spfxContext, api, `/PartnerOrganisationRiskUpdates`);
    }

    public async readLatestUpdateForPeriod(riskId: number, period: Date): Promise<IPartnerOrganisationRiskUpdate> {
        const ru = await this.readAll(
            `?$top=1`
            + `&$filter=PartnerOrganisationRiskID eq ${riskId} and UpdatePeriod eq ${period.toISOString()}`
            + `&$orderby=UpdateDate desc` + `&$expand=UpdateUser($select=ID,Title),RiskImpactLevel,RiskProbability,BeisRiskImpactLevel,BeisRiskProbability`
        );
        if (ru.length > 0)
            return ru[0];
    }

    public async readLastSignedOffUpdateForPeriod(riskId: number, period: Date): Promise<IPartnerOrganisationRiskUpdate> {
        const ru = await this.readAll(
            `?$top=1`
            + `&$expand=UpdateUser,RiskImpactLevel,RiskProbability,BeisRiskImpactLevel,BeisRiskProbability`
            + `&$filter=PartnerOrganisationRiskID eq ${riskId} and UpdatePeriod eq ${period.toISOString()}`
            + `&$orderby=ID desc`
        );
        if (ru.length > 0)
            return ru[0];
    }

    public async readLatestSignedOffUpdate(riskId: number): Promise<IPartnerOrganisationRiskUpdate> {
        const ru = await this.readAll(
            `?$top=1`
            + `&$filter=PartnerOrganisationRiskID eq ${riskId}`
            + `&$orderby=UpdatePeriod desc,ID desc`
        );
        if (ru.length > 0)
            return ru[0];
    }

    public readAllLastSixMonths(): Promise<IPartnerOrganisationRiskUpdate[]> {
        const sixMonthsAgo = sub(new Date(), { months: 6 });
        return this.readAll(
            `?$select=ID,Title,RiskCode,UpdatePeriod`
            + `&$filter=IsCurrent eq true and UpdatePeriod gt ${sixMonthsAgo.toISOString()}`
            + `&$orderby=UpdatePeriod desc,Title`
        );
    }

    public readCompleteRiskUpdate(id: number): Promise<IPartnerOrganisationRiskUpdate> {
        return this.read(id, true, true);
    }
}