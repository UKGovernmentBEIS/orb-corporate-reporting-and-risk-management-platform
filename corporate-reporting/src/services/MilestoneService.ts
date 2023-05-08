import { WebPartContext } from '@microsoft/sp-webpart-base';
import { EntityWithStatusService } from './EntityWithStatusService';
import { ContextService } from './ContextService';
import { IMilestone, IDataAPI, IEntityChildren } from '../types';
import { EntityStatus } from '../refData/EntityStatus';
import { MilestoneType } from '../refData/MilestoneType';

export class MilestoneService extends EntityWithStatusService<IMilestone> {
    public readonly parentEntities = ['LeadUser', 'WorkStream($expand=Project)', 'KeyWorkArea($expand=Directorate)', 'PartnerOrganisation'];
    protected childrenEntities = ['Contributors($expand=ContributorUser)', 'Attributes($expand=AttributeType)'];

    constructor(spfxContext: WebPartContext, api: IDataAPI) {
        super(spfxContext, api, `/Milestones`);
    }

    public readWithContributors(entityId: number): Promise<IMilestone> {
        return this.read(entityId, false, true);
    }

    public readAllForLookup(includeClosedEntities?: boolean, additionalFields?: string): Promise<IMilestone[]> {
        return this.readAll(
            `?$select=ID,Title,KeyWorkAreaID,WorkStreamID,PartnerOrganisationID${additionalFields ? `,${additionalFields}` : ''}`
            + `&$orderby=Title`
            + (includeClosedEntities ? `` : `&$filter=EntityStatusID eq ${EntityStatus.Open}`)
        );
    }

    public readAllExpandAll(): Promise<IMilestone[]> {
        return this.readAll(
            `?$select=ID,Title,MilestoneCode`
            + `&$orderby=Title`
            + `&$expand=EntityStatus,LeadUser,KeyWorkArea($select=Title;$expand=Directorate($select=Title)),`
            + `WorkStream($select=Title;$expand=Project($select=Title)),PartnerOrganisation($select=Title),MilestoneType($select=Title)`
        );
    }

    public readAllDirectorateAndProjectMilestonesForList(includeClosedMilestones?: boolean): Promise<IMilestone[]> {
        return this.readAll(
            `?$select=ID,Title,MilestoneCode`
            + `&$orderby=Title`
            + `&$expand=EntityStatus,LeadUser,KeyWorkArea($select=Title;$expand=Directorate($select=Title))`
            + `,WorkStream($select=Title;$expand=Project($select=Title)),MilestoneType($select=Title)`
            + `&$filter=(MilestoneTypeID eq ${MilestoneType.Directorate} or MilestoneTypeID eq ${MilestoneType.Project})${includeClosedMilestones ? `` : ` and EntityStatusID eq ${EntityStatus.Open}`}`
        );
    }

    public readAllPartnerOrganisationMilestonesForList(includeClosedMilestones?: boolean): Promise<IMilestone[]> {
        return this.readAll(
            `?$select=ID,Title,MilestoneCode`
            + `&$orderby=Title`
            + `&$expand=EntityStatus,LeadUser,PartnerOrganisation($select=Title),MilestoneType($select=Title)`
            + `&$filter=MilestoneTypeID eq ${MilestoneType.PartnerOrganisation}${includeClosedMilestones ? `` : ` and EntityStatusID eq ${EntityStatus.Open}`}`
        );
    }


    public async readMyMilestones(): Promise<IMilestone[]> {
        const username = encodeURIComponent(ContextService.Username(this.spfxContext));
        const filters = [
            `LeadUser/Username eq '${username}'`,
            `Contributors/any(c: c/ContributorUser/Username eq '${username}')`
        ];
        return this.readAll(
            `?$select=ID,Title,KeyWorkAreaID,WorkStreamID,PartnerOrganisationID`
            + `&$expand=KeyWorkArea($select=Title,DirectorateID),WorkStream($select=Title,ProjectID)`
            + `&$filter=EntityStatusID eq ${EntityStatus.Open} and (${filters.join(' or ')})`
            + `&$orderby=MilestoneCode,Title`
        );
    }

    public readPartnerOrganisationMilestones(partnerOrganisationId: number): Promise<IMilestone[]> {
        return this.readAll(
            `?$filter=PartnerOrganisationID eq ${partnerOrganisationId} and EntityStatusID eq ${EntityStatus.Open}`
            + `&$expand=LeadUser,Attributes($expand=AttributeType),Contributors`
            + `&$orderby=MilestoneCode,Title`
        );
    }

    public async entityChildren(id: number): Promise<IEntityChildren[]> {
        return this.entityChildrenSingle(id, 'Milestone updates', 'MilestoneUpdates', false);
    }
}