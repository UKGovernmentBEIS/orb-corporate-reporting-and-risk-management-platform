import { WebPartContext } from '@microsoft/sp-webpart-base';
import { IRiskMitigationActionUpdate, IDataAPI } from '../types';
import { EntityUpdateService } from './EntityUpdateService';

export class CorporateRiskMitigationActionUpdateService extends EntityUpdateService<IRiskMitigationActionUpdate> {
    constructor(spfxContext: WebPartContext, api: IDataAPI) {
        super(spfxContext, api, `/CorporateRiskMitigationActionUpdates`);
    }

    public async readLatestUpdateForPeriod(riskMitigationActionId: number, period: Date): Promise<IRiskMitigationActionUpdate> {
        const au = await this.readAll(
            `?$top=1`
            + `&$filter=RiskMitigationActionID eq ${riskMitigationActionId} and UpdatePeriod eq ${period.toISOString()}`
            + `&$expand=UpdateUser($select=ID,Title)`
            + `&$orderby=UpdateDate desc`
        );
        if (au.length > 0)
            return au[0];
    }

    public async readLastSignedOffUpdateForPeriod(riskMitigationActionId: number, period: Date): Promise<IRiskMitigationActionUpdate> {
        const au = await this.readAll(
            `?$top=1`
            + `&$filter=RiskMitigationActionID eq ${riskMitigationActionId} and UpdatePeriod eq ${period.toISOString()}`
            + `&$orderby=UpdateDate desc`
        );
        if (au.length > 0)
            return au[0];
    }
}