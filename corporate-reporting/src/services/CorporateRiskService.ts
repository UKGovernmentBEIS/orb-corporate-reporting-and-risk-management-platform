import { IDataAPI, IUserDirectorate, IEntityChildren, ICorporateRisk } from '../types';
import { WebPartContext } from '@microsoft/sp-webpart-base';
import { EntityStatus } from '../refData/EntityStatus';
import { RiskRegister } from '../refData/RiskRegister';
import { EntityWithStatusService } from './EntityWithStatusService';
import { ContextService } from './ContextService';
import { addDays, subMonths } from 'date-fns';
import { DateService } from './DateService';

export class CorporateRiskService extends EntityWithStatusService<ICorporateRisk> {
    public readonly parentEntities = ['RiskOwnerUser', 'RiskRegister', 'Directorate($expand=Group)'];
    protected childrenEntities = ['RiskRiskTypes', 'Contributors($expand=ContributorUser)', 'Attributes($expand=AttributeType)'];
    private readonly _open = EntityStatus.Open;
    private readonly _closed = EntityStatus.Closed;

    constructor(spfxContext: WebPartContext, api: IDataAPI) {
        super(spfxContext, api, `/CorporateRisks`);
    }

    public readAllForLookup(includeClosedEntities?: boolean, additionalFields?: string): Promise<ICorporateRisk[]> {
        return this.readAll(
            `?$select=ID,Title,RiskCode,RiskRegisterID,DirectorateID,IsProjectRisk,ProjectID${additionalFields ? `,${additionalFields}` : ''}`
            + `&$orderby=Title`
            + (includeClosedEntities ? `` : `&$filter=EntityStatusID eq ${EntityStatus.Open}`)
        );
    }

    public readAllForList(includeClosedRisks?: boolean): Promise<ICorporateRisk[]> {
        return this.readAll(
            `?$select=ID,RiskCode,Title`
            + `&$orderby=Title`
            + `&$expand=RiskRegister($select=Title),Directorate($expand=Group($select=Title);$select=Title),RiskOwnerUser($select=Title)`
            + `,ReportApproverUser($select=Title),RiskMitigationActions($select=ID),EntityStatus($select=Title),Contributors($select=ContributorUser;$expand=ContributorUser($select=Title))`
            + (includeClosedRisks ? `` : `&$filter=EntityStatusID eq ${EntityStatus.Open}`)
        );
    }

    public readExpandAll(riskId: number): Promise<ICorporateRisk> {
        return this.read(riskId, false, true);
    }

    public readMyRisks(userDirectorates?: IUserDirectorate[]): Promise<ICorporateRisk[]> {
        const username = encodeURIComponent(ContextService.Username(this.spfxContext));
        let filters = [
            `RiskOwnerUser/Username eq '${username}'`,
            `ReportApproverUser/Username eq '${username}'`,
            `Contributors/any(c: c/ContributorUser/Username eq '${username}')`
        ];

        if (userDirectorates) {
            filters = filters.concat(userDirectorates.filter(ud => ud.IsRiskAdmin).map(ud => `DirectorateID eq ${ud.DirectorateID}`));
        }

        return this.readAll(
            `?$select=ID,Title,RiskCode,DirectorateID`
            + `&$expand=Directorate($select=ID),Attributes($expand=AttributeType)`
            + `&$orderby=RiskRegisterID,ID`
            + `&$filter=(${filters.join(' or ')}) and EntityStatusID eq ${EntityStatus.Open}`
        );
    }

    public readRegisterRisksForMonth(riskRegisterId: number, registerEntityId: number, period: Date): Promise<ICorporateRisk[]> {
        const monthStart = addDays(DateService.lastDateOfMonth(subMonths(period, 1)), 1).toISOString();
        const monthEnd = addDays(DateService.lastDateOfMonth(period), 1).toISOString();
        if (riskRegisterId === RiskRegister.Departmental)
            return this.readAll(
                `?$expand=Directorate($select=Title;$expand=Group($select=Title)),Project($select=Title),UnmitigatedRiskImpactLevel,UnmitigatedRiskProbability,TargetRiskImpactLevel,`
                + `TargetRiskProbability,RiskRiskTypes,RiskOwnerUser,ReportApproverUser,Attributes($expand=AttributeType)`
                + `&$filter=CreatedDate lt ${monthEnd} and (EntityStatusID eq ${this._open} or (EntityStatusID eq ${this._closed} and EntityStatusDate gt ${monthStart})) and `
                + `RiskRegisterID eq ${RiskRegister.Departmental}`
                + `&$orderby=RiskRegisterID,IsProjectRisk,ID`);
        if (riskRegisterId === RiskRegister.Group)
            return this.readAll(
                `?$expand=Directorate($select=Title),Project($select=Title),UnmitigatedRiskImpactLevel,UnmitigatedRiskProbability,TargetRiskImpactLevel,`
                + `TargetRiskProbability,RiskRiskTypes,RiskOwnerUser,ReportApproverUser,Attributes($expand=AttributeType)`
                + `&$filter=CreatedDate lt ${monthEnd} and (EntityStatusID eq ${this._open} or (EntityStatusID eq ${this._closed} and EntityStatusDate gt ${monthStart})) and `
                + `RiskRegisterID ne ${RiskRegister.Directorate} and Directorate/GroupID eq ${registerEntityId}`
                + `&$orderby=RiskRegisterID,IsProjectRisk,ID`);
        if (riskRegisterId === RiskRegister.Directorate)
            return this.readAll(
                `?$expand=Project($select=Title),UnmitigatedRiskImpactLevel,UnmitigatedRiskProbability,TargetRiskImpactLevel,`
                + `TargetRiskProbability,RiskRiskTypes,RiskOwnerUser,ReportApproverUser,Attributes($expand=AttributeType)`
                + `&$filter=CreatedDate lt ${monthEnd} and (EntityStatusID eq ${this._open} or (EntityStatusID eq ${this._closed} and EntityStatusDate gt ${monthStart})) and `
                + `DirectorateID eq ${registerEntityId}`
                + `&$orderby=RiskRegisterID,IsProjectRisk,ID`);
        if (riskRegisterId === RiskRegister.Project) {
            return this.readAll(
                `?$expand=Project($select=Title),UnmitigatedRiskImpactLevel,UnmitigatedRiskProbability,TargetRiskImpactLevel,`
                + `TargetRiskProbability,RiskRiskTypes,RiskOwnerUser,ReportApproverUser,Attributes($expand=AttributeType)`
                + `&$filter=CreatedDate lt ${monthEnd} and (EntityStatusID eq ${this._open} or (EntityStatusID eq ${this._closed} and EntityStatusDate gt ${monthStart})) and `
                + `ProjectID eq ${registerEntityId} and IsProjectRisk eq true`
                + `&$orderby=RiskRegisterID,IsProjectRisk,ID`);
        }
        return Promise.resolve([]);
    }

    public readDraftReportRisks = (): Promise<ICorporateRisk[]> => {
        return this.readAll(`?$expand=Directorate($select=ID),Attributes($expand=AttributeType)&$orderby=RiskRegisterID,ID&$filter=EntityStatusID eq ${this._open}`);
    }

    public async entityChildren(id: number): Promise<IEntityChildren[]> {
        const riskUrl = `${this.entityUrl}(${id})`;
        const risks = this.getEntities(`${riskUrl}/ChildRisks?$select=ID&$top=10`);
        const actions = this.getEntities(`${riskUrl}/RiskMitigationActions?$select=ID&$top=10`);
        const updates = this.getEntities(`${riskUrl}/RiskUpdates?$select=ID&$top=10`);
        const signOffs = this.getEntities(`${riskUrl}/SignOffs?$select=ID&$top=10`);
        return [
            { ChildType: 'Child risks', CanBeAdopted: true, ChildIDs: (await risks).map(r => r.ID) },
            { ChildType: 'Risk mitigating actions', CanBeAdopted: true, ChildIDs: (await actions).map(r => r.ID) },
            { ChildType: 'Risk updates', CanBeAdopted: false, ChildIDs: (await updates).map(r => r.ID) },
            { ChildType: 'Reports', CanBeAdopted: false, ChildIDs: (await signOffs).map(s => s.ID) }
        ];
    }

    public static sortRisksByCode = (risks: ICorporateRisk[]): ICorporateRisk[] => {
        return risks.sort((a, b) => {
            const reg = (a.IsProjectRisk ? 4 : a.RiskRegisterID) - (b.IsProjectRisk ? 4 : b.RiskRegisterID);
            return reg === 0 ? a.ID - b.ID : reg;
        });
    }

    public readRiskPeople = (riskId: number): Promise<ICorporateRisk> => {
        return this.read(riskId, false, false, ['RiskOwnerUser', 'ReportApproverUser', 'Contributors']);
    }
}