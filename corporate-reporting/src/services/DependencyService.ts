import { EntityWithStatusService } from './EntityWithStatusService';
import { ContextService } from './ContextService';
import { IDependency, IDataAPI, IEntityChildren } from '../types';
import { WebPartContext } from '@microsoft/sp-webpart-base';
import { EntityStatus } from '../refData/EntityStatus';

export class DependencyService extends EntityWithStatusService<IDependency> {
    public readonly parentEntities = ['Project', 'LeadUser'];
    protected childrenEntities = ['Contributors($expand=ContributorUser)', 'Attributes($expand=AttributeType)'];

    constructor(spfxContext: WebPartContext, api: IDataAPI) {
        super(spfxContext, api, `/Dependencies`);
    }

    public readMyDependencies(): Promise<IDependency[]> {
        const username = encodeURIComponent(ContextService.Username(this.spfxContext));
        const filters = [
            `LeadUser/Username eq '${username}'`,
            `Contributors/any(c: c/ContributorUser/Username eq '${username}')`
        ];
        return this.readAll(`?$filter=EntityStatusID eq ${EntityStatus.Open} and (${filters.join(' or ')})&$orderby=Project/Title,Title`);
    }

    public readAllForList(includeClosedDependency?: boolean): Promise<IDependency[]> {
        return this.readAll(
            `?$select=ID,Title`
            + `&$orderby=Title`
            + `&$expand=EntityStatus($select=Title),Project($select=Title),LeadUser($select=Title),Contributors($select=ContributorUser;$expand=ContributorUser($select=Title))`
            + (includeClosedDependency ? `` : `&$filter=EntityStatusID eq ${EntityStatus.Open}`)
        );
    }

    public readProjectDependencies(projectId: number): Promise<IDependency[]> {
        return this.readAll(`?$expand=LeadUser,Contributors&$filter=EntityStatusID eq ${EntityStatus.Open} and ProjectID eq ${projectId}&$orderby=Title`);
    }

    public async entityChildren(id: number): Promise<IEntityChildren[]> {
        return this.entityChildrenSingle(id, 'Dependency updates', 'DependencyUpdates', false);
    }
}