import { EntityWithStatusService } from './EntityWithStatusService';
import { ContextService } from './ContextService';
import { ICommitment, IDataAPI, IEntityChildren } from '../types';
import { WebPartContext } from '@microsoft/sp-webpart-base';
import { EntityStatus } from '../refData/EntityStatus';

export class CommitmentService extends EntityWithStatusService<ICommitment> {
    public readonly parentEntities = ['Directorate', 'LeadUser'];
    protected childrenEntities = ['Contributors($expand=ContributorUser)', 'Attributes($expand=AttributeType)'];

    constructor(spfxContext: WebPartContext, api: IDataAPI) {
        super(spfxContext, api, `/Commitments`);
    }

    public readMyCommitments(): Promise<ICommitment[]> {
        const username = encodeURIComponent(ContextService.Username(this.spfxContext));
        const filters = [
            `LeadUser/Username eq '${username}'`,
            `Contributors/any(c: c/ContributorUser/Username eq '${username}')`
        ];
        return this.readAll(
            `?$select=ID,Title,DirectorateID`
            + `&$filter=EntityStatusID eq ${EntityStatus.Open} and (${filters.join(' or ')})`
            + `&$orderby=Directorate/Title,Title`
        );
    }

    public readAllForList(includeClosedCommitments?: boolean): Promise<ICommitment[]> {
        return this.readAll(
            `?$select=ID,Title`
            + `&$orderby=Title`
            + `&$expand=EntityStatus($select=Title),Directorate($select=Title),LeadUser($select=Title),Contributors($select=ContributorUser;$expand=ContributorUser($select=Title))`
            + (includeClosedCommitments ? `` : `&$filter=EntityStatusID eq ${EntityStatus.Open}`)
        );
    }

    public readDirectorateCommitments(directorateId: number): Promise<ICommitment[]> {
        return this.readAll(`?$expand=LeadUser,Attributes($expand=AttributeType),Contributors`
            + `&$filter=EntityStatusID eq ${EntityStatus.Open} and DirectorateID eq ${directorateId}&$orderby=Title`);
    }

    public async entityChildren(id: number): Promise<IEntityChildren[]> {
        return this.entityChildrenSingle(id, 'Commitment updates', 'CommitmentUpdates', false);
    }
}