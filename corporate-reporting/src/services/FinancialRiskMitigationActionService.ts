import { IDataAPI, IEntityChildren, IFinancialRiskMitigationAction, IUserDirectorate } from '../types';
import { WebPartContext } from '@microsoft/sp-webpart-base';
import { RiskMitigationActionService } from './RiskMitigationActionService';
import { ContextService } from './ContextService';
import { EntityStatus } from '../refData/EntityStatus';

export class FinancialRiskMitigationActionService extends RiskMitigationActionService<IFinancialRiskMitigationAction> {
    public readonly parentEntities = ['FinancialRisk($expand=Directorate)', 'OwnerUser'];

    constructor(spfxContext: WebPartContext, api: IDataAPI) {
        super(spfxContext, api, `/FinancialRiskMitigationActions`);
    }

    public readAllForList(includeClosedRiskActions?: boolean): Promise<IFinancialRiskMitigationAction[]> {
        return this.readAll(
            `?$select=ID,RiskMitigationActionCode,Title`
            + `&$orderby=Title`
            + `&$expand=FinancialRisk($select=RiskCode,Title),OwnerUser($select=Title),EntityStatus($select=Title),Contributors($select=ContributorUser;$expand=ContributorUser($select=Title))`
            + (includeClosedRiskActions ? `` : `&$filter=EntityStatusID eq ${EntityStatus.Open}`)
        );
    }

    public readMyActions(userDirectorates?: IUserDirectorate[]): Promise<IFinancialRiskMitigationAction[]> {
        const username = encodeURIComponent(ContextService.Username(this.spfxContext));
        let filters = [
            `OwnerUser/Username eq '${username}'`,
            `Contributors/any(c: c/ContributorUser/Username eq '${username}')`
        ];
        if (userDirectorates) {
            filters = filters.concat(userDirectorates.filter(ud => ud.IsRiskAdmin).map(ud => `FinancialRisk/DirectorateID eq ${ud.DirectorateID}`));
        }
        return this.readAll(
            `?$select=ID,Title,RiskID`
            + `&$expand=FinancialRisk($select=Title,DirectorateID)`
            + `&$filter=EntityStatusID eq ${EntityStatus.Open} and (${filters.join(' or ')})`
            + `&$orderby=RiskID`
        );
    }

    public readMitigationActionsForRisk(riskId: number): Promise<IFinancialRiskMitigationAction[]> {
        return this.readAll(
            `?$filter=RiskID eq ${riskId}`
            + `&$expand=OwnerUser($select=Title),EntityStatus($select=Title),Contributors`
            + `&$orderby=RiskMitigationActionCode,Title`
        );
    }

    public async entityChildren(id: number): Promise<IEntityChildren[]> {
        return this.entityChildrenSingle(id, 'Risk mitigating action updates', 'FinancialRiskMitigationActionUpdates', false);
    }
}