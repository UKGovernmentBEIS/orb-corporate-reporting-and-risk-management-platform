import { WebPartContext } from '@microsoft/sp-webpart-base';
import { EntityWithStatusService } from './EntityWithStatusService';
import { IGroup, IDataAPI, IEntityChildren } from '../types';
import { EntityStatus } from '../refData/EntityStatus';

export class GroupService extends EntityWithStatusService<IGroup> {
    constructor(spfxContext: WebPartContext, api: IDataAPI) {
        super(spfxContext, api, `/Groups`);
    }

    public readAllForList(includeClosedGroups?: boolean): Promise<IGroup[]> {
        return this.readAll(
            `?$select=ID,Title`
            + `&$orderby=Title`
            + `&$expand=DirectorGeneralUser($select=Title),EntityStatus($select=Title)`
            + (includeClosedGroups ? `` : `&$filter=EntityStatusID eq ${EntityStatus.Open}`)
        );
    }

    public async entityChildren(id: number): Promise<IEntityChildren[]> {
        return this.entityChildrenSingle(id, 'Directorates', 'Directorates', true);
    }
}