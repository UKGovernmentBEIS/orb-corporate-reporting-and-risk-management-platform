import { WebPartContext } from '@microsoft/sp-webpart-base';
import { EntityUpdateService } from './EntityUpdateService';
import { ICorporateRiskUpdate, IDataAPI } from '../types';
import { sub } from 'date-fns';
import { SignOffService } from './SignOffService';

export class CorporateRiskUpdateService extends EntityUpdateService<ICorporateRiskUpdate> {
    public parentEntities = [
        'UpdateUser',
        'RiskImpactLevel',
        'RiskProbability',
        'CorporateRisk($expand=Group,Directorate,CorporateRiskMitigationActions,UnmitigatedRiskImpactLevel,UnmitigatedRiskProbability,RiskAppetite,RiskRiskTypes)',
        'RiskRegister'
    ];
    protected childrenEntities = [
        'RiskUpdateRiskMitigationActionUpdates'
    ];

    constructor(spfxContext: WebPartContext, api: IDataAPI) {
        super(spfxContext, api, `/CorporateRiskUpdates`);
    }

    public async readLatestUpdateForPeriod(riskId: number, period: Date): Promise<ICorporateRiskUpdate> {
        const ru = await this.readAll(
            `?$top=1`
            + `&$filter=RiskID eq ${riskId} and UpdatePeriod eq ${period.toISOString()}`
            + `&$orderby=UpdateDate desc`
            + `&$expand=UpdateUser($select=ID,Title),RiskImpactLevel,RiskProbability`
        );
        if (ru.length > 0)
            return ru[0];
    }

    public async readLastSignedOffUpdateForPeriod(riskId: number, period: Date): Promise<ICorporateRiskUpdate> {
        const ru = await this.readAll(
            `?$top=1`
            + `&$expand=SignOff($expand=SignOffUser)`
            + `&$filter=RiskID eq ${riskId} and UpdatePeriod eq ${period.toISOString()} and SignOffID ne null`
            + `&$orderby=SignOffID desc`
        );
        if (ru.length > 0) {
            const riskUpdate = ru[0];
            SignOffService.mapReportJsonToProperties(riskUpdate.SignOff);
            return riskUpdate;
        }
    }

    public async readLatestSignedOffUpdate(riskId: number): Promise<ICorporateRiskUpdate> {
        const ru = await this.readAll(
            `?$top=1`
            + `&$filter=RiskID eq ${riskId}`
            + `&$orderby=UpdatePeriod desc,ID desc`
        );
        if (ru.length > 0)
            return ru[0];
    }

    public readAllLastSixMonths(): Promise<ICorporateRiskUpdate[]> {
        const sixMonthsAgo = sub(new Date(), { months: 6 });
        return this.readAll(
            `?$select=ID,Title,RiskCode,UpdatePeriod`
            + `&$filter=IsCurrent eq true and UpdatePeriod gt ${sixMonthsAgo.toISOString()}`
            + `&$orderby=UpdatePeriod desc,Title`
        );
    }

    public readCompleteRiskUpdate(id: number): Promise<ICorporateRiskUpdate> {
        return this.read(id, true, true);
    }
}