import { ICorporateRiskMitigationAction, IDataAPI, IEntityChildren, IUserDirectorate } from '../types';
import { WebPartContext } from '@microsoft/sp-webpart-base';
import { RiskMitigationActionService } from './RiskMitigationActionService';
import { ContextService } from './ContextService';
import { EntityStatus } from '../refData/EntityStatus';

export class CorporateRiskMitigationActionService extends RiskMitigationActionService<ICorporateRiskMitigationAction> {
    public readonly parentEntities = ['Risk($expand=Directorate,Attributes)', 'OwnerUser', 'CorporateRiskRiskMitigationActions($expand=Risk)'];

    constructor(spfxContext: WebPartContext, api: IDataAPI) {
        super(spfxContext, api, `/CorporateRiskMitigationActions`);
    }

    public readAllForList(includeClosedRiskActions?: boolean): Promise<ICorporateRiskMitigationAction[]> {
        return this.readAll(
            `?$select=ID,RiskMitigationActionCode,Title`
            + `&$orderby=Title`
            + `&$expand=Risk($select=RiskCode,Title),OwnerUser($select=Title),EntityStatus($select=Title),Contributors($select=ContributorUser;$expand=ContributorUser($select=Title))`
            + (includeClosedRiskActions ? `` : `&$filter=EntityStatusID eq ${EntityStatus.Open}`)
        );
    }

    public readMyActions(userDirectorates?: IUserDirectorate[]): Promise<ICorporateRiskMitigationAction[]> {
        const username = encodeURIComponent(ContextService.Username(this.spfxContext));
        let filters = [
            `OwnerUser/Username eq '${username}'`,
            `Contributors/any(c: c/ContributorUser/Username eq '${username}')`
        ];
        if (userDirectorates) {
            filters = filters.concat(userDirectorates?.filter(ud => ud.IsRiskAdmin).map(ud => `Risk/DirectorateID eq ${ud.DirectorateID}`));
        }
        return this.readAll(
            `?$select=ID,Title,RiskID`
            + `&$expand=Risk($select=Title,DirectorateID),CorporateRiskRiskMitigationActions($expand=Risk($select=Title,DirectorateID))`
            + `&$filter=EntityStatusID eq ${EntityStatus.Open} and (${filters.join(' or ')})`
            + `&$orderby=RiskID`
        );
    }

    public readMitigationActionsForRisk(riskId: number): Promise<ICorporateRiskMitigationAction[]> {
        return this.readAll(
            `?$filter=RiskID eq ${riskId} or CorporateRiskRiskMitigationActions/any(a: a/RiskID eq 171)`
            + `&$expand=OwnerUser($select=Title),EntityStatus($select=Title),Contributors`
            + `&$orderby=RiskMitigationActionCode,Title`
        );
    }

    public async entityChildren(id: number): Promise<IEntityChildren[]> {
        return this.entityChildrenSingle(id, 'Risk mitigating action updates', 'RiskMitigationActionUpdates', false);
    }
}