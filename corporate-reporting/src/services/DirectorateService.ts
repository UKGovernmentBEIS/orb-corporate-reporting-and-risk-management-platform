import { WebPartContext } from '@microsoft/sp-webpart-base';
import { EntityWithStatusService } from './EntityWithStatusService';
import { ContextService } from './ContextService';
import { IDirectorate, IDataAPI, IEntityChildren } from '../types';
import { EntityStatus } from '../refData/EntityStatus';

export class DirectorateService extends EntityWithStatusService<IDirectorate> {
    public readonly parentEntities = ['DirectorUser'];
    protected childrenEntities = ['Contributors($expand=ContributorUser)', 'Attributes($expand=AttributeType)'];

    constructor(spfxContext: WebPartContext, api: IDataAPI) {
        super(spfxContext, api, `/Directorates`);
    }

    public readMyDirectorates(): Promise<IDirectorate[]> {
        const username = encodeURIComponent(ContextService.Username(this.spfxContext));
        const filters = [
            `DirectorUser/Username eq '${username}'`,
            `ReportApproverUser/Username eq '${username}'`,
            `ReportingLeadUser/Username eq '${username}'`,
            `Group/DirectorGeneralUser/Username eq '${username}'`,
            `Contributors/any(c: c/ContributorUser/Username eq '${username}')`
        ];
        return this.readAll(`?$filter=${filters.join(' or ')}&$orderby=Title`);
    }

    public readDgDirectorates(): Promise<IDirectorate[]> {
        return this.readAll(`?$filter=Group/DirectorGeneralUser/Username eq '${encodeURIComponent(ContextService.Username(this.spfxContext))}'&$expand=Group`);
    }

    public readAllForLookup(includeClosedDirectorates?: boolean): Promise<IDirectorate[]> {
        return this.readAll(
            `?$select=ID,Title,GroupID`
            + `&$orderby=Title`
            + (includeClosedDirectorates ? `` : `&$filter=EntityStatusID eq ${EntityStatus.Open}`)
        );
    }

    public readAllForList(includeClosedDirectorates?: boolean): Promise<IDirectorate[]> {
        return this.readAll(
            `?$select=ID,Title,Objectives`
            + `&$orderby=Title`
            + `&$expand=Group($select=Title),DirectorUser($select=Title),EntityStatus($select=Title),ReportApproverUser($select=Title)`
            + (includeClosedDirectorates ? `` : `&$filter=EntityStatusID eq ${EntityStatus.Open}`)
        );
    }

    public readDirectorateApprovers = (directorateId: number): Promise<IDirectorate> => {
        return this.read(directorateId, false, false, ['DirectorUser', 'ReportApproverUser', 'ReportingLeadUser']);
    }

    public readDraftReportDirectorates = (): Promise<IDirectorate[]> => {
        return this.readAll(`?$orderby=Title&$filter=EntityStatusID eq ${EntityStatus.Open}`);
    }

    public async entityChildren(id: number): Promise<IEntityChildren[]> {
        const directorateUrl = `${this.entityUrl}(${id})`;
        const commitments = this.getEntities(`${directorateUrl}/Commitments?$select=ID&$top=10`);
        const directorateUpdates = this.getEntities(`${directorateUrl}/DirectorateUpdates?$select=ID&$top=10`);
        const keyWorkAreas = this.getEntities(`${directorateUrl}/KeyWorkAreas?$select=ID&$top=10`);
        const metrics = this.getEntities(`${directorateUrl}/Metrics?$select=ID&$top=10`);
        const partnerOrgs = this.getEntities(`${directorateUrl}/PartnerOrganisations?$select=ID&$top=10`);
        const projects = this.getEntities(`${directorateUrl}/Projects?$select=ID&$top=10`);
        const risks = this.getEntities(`${directorateUrl}/CorporateRisks?$select=ID&$top=10`);
        const signOffs = this.getEntities(`${directorateUrl}/SignOffs?$select=ID&$top=10`);
        const userDirectorates = this.getEntities(`${directorateUrl}/UserDirectorates?$select=ID&$top=10`);

        return [
            { ChildType: 'Commitments', CanBeAdopted: true, ChildIDs: (await commitments).map(c => c.ID) },
            { ChildType: 'Directorate updates', CanBeAdopted: false, ChildIDs: (await directorateUpdates).map(d => d.ID) },
            { ChildType: 'Key work areas', CanBeAdopted: true, ChildIDs: (await keyWorkAreas).map(k => k.ID) },
            { ChildType: 'Metrics', CanBeAdopted: true, ChildIDs: (await metrics).map(m => m.ID) },
            { ChildType: 'Partner organisations', CanBeAdopted: true, ChildIDs: (await partnerOrgs).map(p => p.ID) },
            { ChildType: 'Projects', CanBeAdopted: true, ChildIDs: (await projects).map(p => p.ID) },
            { ChildType: 'Reports', CanBeAdopted: false, ChildIDs: (await signOffs).map(s => s.ID) },
            { ChildType: 'User directorates', CanBeAdopted: true, ChildIDs: (await userDirectorates).map(u => u.ID) },
            { ChildType: 'Risks', CanBeAdopted: true, ChildIDs: (await risks).map(r => r.ID) }
        ];
    }
}