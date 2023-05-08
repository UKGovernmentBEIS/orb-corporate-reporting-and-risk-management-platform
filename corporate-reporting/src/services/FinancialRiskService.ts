import { IDataAPI, IEntityChildren, IFinancialRisk } from '../types';
import { WebPartContext } from '@microsoft/sp-webpart-base';
import { EntityStatus } from '../refData/EntityStatus';
import { EntityWithStatusService } from './EntityWithStatusService';
import { ContextService } from './ContextService';

export class FinancialRiskService extends EntityWithStatusService<IFinancialRisk> {
    public readonly parentEntities = ['RiskOwnerUser', 'RiskRegister', 'Directorate($expand=Group)'];
    protected childrenEntities = ['Contributors($expand=ContributorUser)', 'Attributes($expand=AttributeType)'];

    constructor(spfxContext: WebPartContext, api: IDataAPI) {
        super(spfxContext, api, `/FinancialRisks`);
    }

    public readAllForLookup(includeClosedEntities?: boolean): Promise<IFinancialRisk[]> {
        return this.readAll(
            `?$select=ID,Title,RiskCode,DirectorateID`
            + `&$orderby=Title`
            + (includeClosedEntities ? `` : `&$filter=EntityStatusID eq ${EntityStatus.Open}`)
        );
    }

    public readAllForList(includeClosedRisks?: boolean): Promise<IFinancialRisk[]> {
        return this.readAll(
            `?$select=ID,RiskCode,Title,OwnedByDgOffice,OwnedByMultipleGroups`
            + `&$orderby=Title`
            + `&$expand=Directorate($select=Title),Group($select=Title),RiskOwnerUser($select=Title),ReportApproverUser($select=Title)`
            + `,FinancialRiskMitigationActions($select=ID),EntityStatus($select=Title),Contributors($select=ContributorUser;$expand=ContributorUser($select=Title))`
            + (includeClosedRisks ? `` : `&$filter=EntityStatusID eq ${EntityStatus.Open}`)
        );
    }

    public readDraftReportRisks = (): Promise<IFinancialRisk[]> => {
        return this.readAll(`?$expand=Group($select=ID),Attributes($expand=AttributeType)&$orderby=ID&$filter=EntityStatusID eq ${EntityStatus.Open}`);
    }

    public readMyRisks(): Promise<IFinancialRisk[]> {
        const username = encodeURIComponent(ContextService.Username(this.spfxContext));
        const filters = [
            `RiskOwnerUser/Username eq '${username}'`,
            `ReportApproverUser/Username eq '${username}'`,
            `Contributors/any(c: c/ContributorUser/Username eq '${username}')`
        ];

        return this.readAll(
            `?$select=ID,Title,RiskCode,GroupID,DirectorateID,OwnedByMultipleGroups,OwnedByDgOffice`
            + `&$expand=Group($select=ID,Title),Directorate($select=ID,Title),Attributes($expand=AttributeType)`
            + `&$orderby=DirectorateID`
            + `&$filter=(${filters.join(' or ')}) and EntityStatusID eq ${EntityStatus.Open}`
        );
    }

    public async entityChildren(id: number): Promise<IEntityChildren[]> {
        const riskUrl = `${this.entityUrl}(${id})`;
        const actions = this.getEntities(`${riskUrl}/FinancialRiskMitigationActions?$select=ID&$top=10`);
        const updates = this.getEntities(`${riskUrl}/FinancialRiskUpdates?$select=ID&$top=10`);
        const signOffs = this.getEntities(`${riskUrl}/SignOffs?$select=ID&$top=10`);
        return [
            { ChildType: 'Risk mitigating actions', CanBeAdopted: true, ChildIDs: (await actions).map(r => r.ID) },
            { ChildType: 'Risk updates', CanBeAdopted: false, ChildIDs: (await updates).map(r => r.ID) },
            { ChildType: 'Reports', CanBeAdopted: false, ChildIDs: (await signOffs).map(s => s.ID) }
        ];
    }

    public readRiskPeople = (riskId: number): Promise<IFinancialRisk> => {
        return this.read(riskId, false, false, ['RiskOwnerUser', 'ReportApproverUser', 'Contributors']);
    }
}