import { WebPartContext } from '@microsoft/sp-webpart-base';
import { EntityWithStatusService } from './EntityWithStatusService';
import { ContextService } from './ContextService';
import { IProject, IDataAPI, IEntityChildren } from '../types';
import { EntityStatus } from '../refData/EntityStatus';
import { Period } from '../refData/Period';

export class ProjectService extends EntityWithStatusService<IProject> {
    public readonly parentEntities = ['SeniorResponsibleOwnerUser'];
    public readonly childrenEntities = ['Contributors($expand=ContributorUser)', 'Attributes($expand=AttributeType)'];

    constructor(spfxContext: WebPartContext, api: IDataAPI) {
        super(spfxContext, api, `/Projects`);
    }

    public readMyProjects(): Promise<IProject[]> {
        const username = encodeURIComponent(ContextService.Username(this.spfxContext));
        const filters = [
            `SeniorResponsibleOwnerUser/Username eq '${username}'`,
            `ReportApproverUser/Username eq '${username}'`,
            `ReportingLeadUser/Username eq '${username}'`,
            `ProjectManagerUser/Username eq '${username}'`,
            `Contributors/any(c: c/ContributorUser/Username eq '${username}')`
        ];
        return this.readAll(
            `?$expand=Attributes($expand=AttributeType)`
            + `&$filter=EntityStatusID eq ${EntityStatus.Open} and (${filters.join(' or ')})`
            + `&$orderby=Title`
        );
    }

    public readDgProjects(): Promise<IProject[]> {
        return this.readAll(`?$filter=Directorate/Group/DirectorGeneralUser/Username eq '${encodeURIComponent(ContextService.Username(this.spfxContext))}'`);
    }

    public readAllForLookup(includeClosedProjects?: boolean): Promise<IProject[]> {
        return this.readAll(
            `?$select=ID,Title,DirectorateID`
            + `&$orderby=Title`
            + (includeClosedProjects ? `` : `&$filter=EntityStatusID eq ${EntityStatus.Open}`)
        );
    }

    public readAllForList(includeClosedProjects?: boolean): Promise<IProject[]> {
        return this.readAll(
            `?$select=ID,Title,Objectives,StartDate,EndDate,CorporateProjectID`
            + `&$orderby=Title`
            + `&$expand=EntityStatus($select=Title),SeniorResponsibleOwnerUser($select=Title),ProjectManagerUser($select=Title)`
            + `,ReportApproverUser($select=Title),Attributes($expand=AttributeType($select=Title))`
            + (includeClosedProjects ? `` : `&$filter=EntityStatusID eq ${EntityStatus.Open}`)
        );
    }

    public readDirectorateProjects(directorateId: number, period: Period): Promise<IProject[]> {
        if (directorateId) {
            return this.readAll(
                `/GetProjectsDueInPeriod(DirectorateId=${directorateId},Period=${period})`
                + `?$expand=Attributes($expand=AttributeType),SeniorResponsibleOwnerUser($select=Title)`
            );
        }
        return Promise.resolve([]);
    }

    public getChildProjects(parentProjectId: number): Promise<IProject[]> {
        return this.readAll(
            `?$expand=Attributes($expand=AttributeType),SeniorResponsibleOwnerUser($select=Title)`
            + `&$filter=ParentProjectID eq ${parentProjectId}`
            + `&$orderby=Title`
        );
    }

    public readProjectApprovers = (projectId: number): Promise<IProject> => {
        return this.read(projectId, false, false, ['SeniorResponsibleOwnerUser', 'ReportApproverUser', 'ReportingLeadUser']);
    }

    public readDraftReportProjects = (): Promise<IProject[]> => {
        return this.readAll(
            `?$expand=Attributes($expand=AttributeType),SeniorResponsibleOwnerUser($select=Title)`
            + `&$orderby=Title`
            + `&$filter=EntityStatusID eq ${EntityStatus.Open}`
        );
    }

    public readProjectByCorporateId = (corporateProjectID: string): Promise<IProject[]> => {
        return this.readAll(`?$select=ID&$filter=CorporateProjectID eq '${corporateProjectID}'`);
    }

    public async readDirectorateOpenProjectsCount(directorateId: number): Promise<number> {
        if (directorateId) {
            return (await this.readAll(`?$select=ID&$filter=EntityStatusID eq ${EntityStatus.Open} and DirectorateID eq ${directorateId} and ShowOnDirectorateReport eq true`))?.length;
        }
        return Promise.resolve(0);
    }

    public async entityChildren(id: number): Promise<IEntityChildren[]> {
        const projectUrl = `${this.entityUrl}(${id})`;
        const benefits = this.getEntities(`${projectUrl}/Benefits?$select=ID&$top=10`);
        const dependencies = this.getEntities(`${projectUrl}/Dependencies?$select=ID&$top=10`);
        const projects = this.getEntities(`${projectUrl}/ChildProjects?$select=ID&$top=10`);
        const updates = this.getEntities(`${projectUrl}/ProjectUpdates?$select=ID&$top=10`);
        const signOffs = this.getEntities(`${projectUrl}/SignOffs?$select=ID&$top=10`);
        const risks = this.getEntities(`${projectUrl}/CorporateRisks?$select=ID&$top=10`);
        const workStreams = this.getEntities(`${projectUrl}/WorkStreams?$select=ID&$top=10`);

        return [
            { ChildType: 'Benefits', CanBeAdopted: true, ChildIDs: (await benefits).map(b => b.ID) },
            { ChildType: 'Dependencies', CanBeAdopted: true, ChildIDs: (await dependencies).map(d => d.ID) },
            { ChildType: 'Projects', CanBeAdopted: true, ChildIDs: (await projects).map(p => p.ID) },
            { ChildType: 'Project updates', CanBeAdopted: false, ChildIDs: (await updates).map(p => p.ID) },
            { ChildType: 'Reports', CanBeAdopted: false, ChildIDs: (await signOffs).map(s => s.ID) },
            { ChildType: 'Risks', CanBeAdopted: true, ChildIDs: (await risks).map(r => r.ID) },
            { ChildType: 'Work streams', CanBeAdopted: true, ChildIDs: (await workStreams).map(w => w.ID) }
        ];
    }
}