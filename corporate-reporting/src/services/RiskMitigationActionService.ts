import { EntityWithStatusService } from './EntityWithStatusService';
import { IRiskMitigationAction, IDataAPI } from '../types';
import { WebPartContext } from '@microsoft/sp-webpart-base';

export class RiskMitigationActionService<T extends IRiskMitigationAction> extends EntityWithStatusService<T> {
    protected childrenEntities = ['Contributors($expand=ContributorUser)'];

    constructor(spfxContext: WebPartContext, api: IDataAPI, url: string) {
        super(spfxContext, api, url);
    }

    public readMitigationActionsForRisk(riskId: number): Promise<T[]> {
        return this.readAll(
            `?$filter=RiskID eq ${riskId}`
            + `&$expand=OwnerUser($select=Title),EntityStatus($select=Title),Contributors`
            + `&$orderby=RiskMitigationActionCode,Title`
        );
    }
}