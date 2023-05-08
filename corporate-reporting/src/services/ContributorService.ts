import { WebPartContext } from '@microsoft/sp-webpart-base';
import { EntityService } from './EntityService';
import { IEntity, IDataAPI, IReportingEntity } from '../types';
import { ContextService } from './ContextService';

export class ContributorService extends EntityService<IEntity> {
    constructor(spfxContext: WebPartContext, api: IDataAPI) {
        super(spfxContext, api, `/Contributors`);
    }

    public static UserIsReadOnlyContributor = (username: string, entity: IReportingEntity): boolean => {
        return entity.Contributors?.length > 0 && entity.Contributors
            .filter(c => c.ContributorUser?.Username
                && ContextService.alterUsername(c.ContributorUser.Username).toUpperCase() === username.toUpperCase())
            .some(c => c.IsReadOnly);
    }
}
