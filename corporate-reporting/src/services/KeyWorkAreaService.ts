import { WebPartContext } from '@microsoft/sp-webpart-base';
import { EntityWithStatusService } from './EntityWithStatusService';
import { ContextService } from './ContextService';
import { IKeyWorkArea, IDataAPI, IEntityChildren } from '../types';
import { EntityStatus } from '../refData/EntityStatus';

export class KeyWorkAreaService extends EntityWithStatusService<IKeyWorkArea> {
    public readonly parentEntities = ['Directorate', 'LeadUser'];
    protected childrenEntities = ['Contributors($expand=ContributorUser)', 'Attributes($expand=AttributeType)'];

    constructor(spfxContext: WebPartContext, api: IDataAPI) {
        super(spfxContext, api, `/KeyWorkAreas`);
    }

    public readAllForList(includeClosedKeyWorkAreas?: boolean): Promise<IKeyWorkArea[]> {
        return this.readAll(
            `?$select=ID,Title`
            + `&$orderby=Title`
            + `&$expand=EntityStatus($select=Title),Directorate($select=Title),LeadUser($select=Title),Contributors($select=ContributorUser;$expand=ContributorUser($select=Title))`
            + (includeClosedKeyWorkAreas ? `` : `&$filter=EntityStatusID eq ${EntityStatus.Open}`)
        );
    }

    public readAllForLookup(includeClosedKeyWorkAreas?: boolean): Promise<IKeyWorkArea[]> {
        return this.readAll(
            `?$select=ID,Title,DirectorateID`
            + `&$orderby=Title`
            + (includeClosedKeyWorkAreas ? `` : `&$filter=EntityStatusID eq ${EntityStatus.Open}`)
        );
    }

    public readMyKeyWorkAreas(): Promise<IKeyWorkArea[]> {
        const username = encodeURIComponent(ContextService.Username(this.spfxContext));
        const filters = [
            `LeadUser/Username eq '${username}'`,
            `Contributors/any(c: c/ContributorUser/Username eq '${username}')`
        ];
        return this.readAll(`?$filter=EntityStatusID eq ${EntityStatus.Open} and (${filters.join(' or ')})&$orderby=Directorate/Title,Title`);
    }

    public readDirectorateKeyWorkAreas(directorateId: number): Promise<IKeyWorkArea[]> {
        return this.readAll(`?$expand=LeadUser,Attributes($expand=AttributeType),Contributors`
            + `&$filter=EntityStatusID eq ${EntityStatus.Open} and DirectorateID eq ${directorateId}`
            + `&$orderby=Title`);
    }

    public readDirectorateMilestones(directorateId: number): Promise<IKeyWorkArea[]> {
        return this.readAll(
            `?$filter=DirectorateID eq ${directorateId}`
            + `&$expand=Milestones($expand=KeyWorkArea,LeadUser,Attributes($expand=AttributeType),Contributors;$filter=EntityStatusID eq ${EntityStatus.Open};$orderby=MilestoneCode,Title)`
        );
    }

    public async entityChildren(id: number): Promise<IEntityChildren[]> {
        const keyWorkAreaUrl = `${this.entityUrl}(${id})`;
        const milestones = this.getEntities(`${keyWorkAreaUrl}/Milestones?$select=ID&$top=10`);
        const updates = this.getEntities(`${keyWorkAreaUrl}/KeyWorkAreaUpdates?$select=ID&$top=10`);
        return [
            { ChildType: 'Milestones', CanBeAdopted: true, ChildIDs: (await milestones).map(m => m.ID) },
            { ChildType: 'Key work area updates', CanBeAdopted: false, ChildIDs: (await updates).map(w => w.ID) }
        ];
    }
}