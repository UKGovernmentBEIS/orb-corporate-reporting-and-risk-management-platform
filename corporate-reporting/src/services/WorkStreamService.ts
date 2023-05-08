import { WebPartContext } from '@microsoft/sp-webpart-base';
import { EntityWithStatusService } from './EntityWithStatusService';
import { ContextService } from './ContextService';
import { IWorkStream, IDataAPI, IEntityChildren } from '../types';
import { EntityStatus } from '../refData/EntityStatus';

export class WorkStreamService extends EntityWithStatusService<IWorkStream> {
    public readonly parentEntities = ['Project', 'LeadUser'];
    protected childrenEntities = ['Contributors($expand=ContributorUser)', 'Attributes($expand=AttributeType)'];

    constructor(spfxContext: WebPartContext, api: IDataAPI) {
        super(spfxContext, api, `/WorkStreams`);
    }

    public readAllForList(includeClosedWorkStreams?: boolean): Promise<IWorkStream[]> {
        return this.readAll(
            `?$select=ID,Title,WorkStreamCode`
            + `&$orderby=Title`
            + `&$expand=EntityStatus($select=Title),Project($select=Title),LeadUser($select=Title),Contributors($select=ContributorUser;$expand=ContributorUser($select=Title))`
            + (includeClosedWorkStreams ? `` : `&$filter=EntityStatusID eq ${EntityStatus.Open}`)
        );
    }

    public readAllForLookup(includeClosedWorkStreams?: boolean): Promise<IWorkStream[]> {
        return this.readAll(
            `?$select=ID,Title,ProjectID`
            + `&$orderby=Title`
            + (includeClosedWorkStreams ? `` : `&$filter=EntityStatusID eq ${EntityStatus.Open}`)
        );
    }

    public readMyWorkStreams(): Promise<IWorkStream[]> {
        const username = encodeURIComponent(ContextService.Username(this.spfxContext));
        const filters = [
            `LeadUser/Username eq '${username}'`,
            `Contributors/any(c: c/ContributorUser/Username eq '${username}')`
        ];
        return this.readAll(`?$filter=EntityStatusID eq ${EntityStatus.Open} and (${filters.join(' or ')})`);
    }

    public readProjectWorkStreams(projectId: number): Promise<IWorkStream[]> {
        return this.readAll(
            `?$expand=LeadUser,Attributes($expand=AttributeType),RagOption,Contributors`
            + `&$filter=EntityStatusID eq ${EntityStatus.Open} and ProjectID eq ${projectId}`
            + `&$orderby=Title`
        );
    }

    public readProjectMilestones(projectId: number): Promise<IWorkStream[]> {
        return this.readAll(
            `?$filter=ProjectID eq ${projectId}`
            + `&$expand=Milestones($expand=WorkStream,LeadUser,Attributes($expand=AttributeType),Contributors;$filter=EntityStatusID eq ${EntityStatus.Open};$orderby=MilestoneCode,Title)`
        );
    }

    public async entityChildren(id: number): Promise<IEntityChildren[]> {
        const workStreamUrl = `${this.entityUrl}(${id})`;
        const milestones = this.getEntities(`${workStreamUrl}/Milestones?$select=ID&$top=10`);
        const updates = this.getEntities(`${workStreamUrl}/WorkStreamUpdates?$select=ID&$top=10`);
        return [
            { ChildType: 'Milestones', CanBeAdopted: true, ChildIDs: (await milestones).map(m => m.ID) },
            { ChildType: 'Work stream updates', CanBeAdopted: false, ChildIDs: (await updates).map(w => w.ID) }
        ];
    }
}