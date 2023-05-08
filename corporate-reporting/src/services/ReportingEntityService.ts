import { WebPartContext } from '@microsoft/sp-webpart-base';
import { EntityWithStatusService } from './EntityWithStatusService';
import { IDataAPI, IEntityChildren } from '../types';
import { ICustomReportingEntity } from '../types/CustomReportingEntity';
import { ContextService } from './ContextService';
import { EntityStatus } from '../refData/EntityStatus';

export class ReportingEntityService extends EntityWithStatusService<ICustomReportingEntity> {
    public readonly parentEntities = ['Directorate', 'Project', 'LeadUser'];
    protected childrenEntities = ['Contributors($expand=ContributorUser)', 'Attributes($expand=AttributeType)'];

    constructor(spfxContext: WebPartContext, api: IDataAPI) {
        super(spfxContext, api, `/ReportingEntities`);
    }

    public async readMyEntities(): Promise<ICustomReportingEntity[]> {
        const username = encodeURIComponent(ContextService.Username(this.spfxContext));
        const filters = [
            `LeadUser/Username eq '${username}'`,
            `Contributors/any(c: c/ContributorUser/Username eq '${username}')`
        ];
        return this.readAll(
            `?$filter=EntityStatusID eq ${EntityStatus.Open} and (${filters.join(' or ')})`
            + `&$expand=ReportingEntityType`
            + `&$orderby=Directorate/Title,Title`
        );
    }

    public readAllForReportingEntityList(entityType: number, includeClosedEntities?: boolean): Promise<ICustomReportingEntity[]> {
        return this.readAll(
            `?$expand=Directorate,Project,PartnerOrganisation,LeadUser,Contributors($expand=ContributorUser),EntityStatus`
            + `&$filter=ReportingEntityTypeID eq ${entityType}${includeClosedEntities ? `` : ` and EntityStatusID eq ${EntityStatus.Open}`}`
        );
    }

    public readAllForReportingEntityLookup(entityType: number, includeClosedEntities?: boolean): Promise<ICustomReportingEntity[]> {
        return this.readAll(
            `?$select=ID,Title`
            + `&$orderby=Title`
            + `&$filter=ReportingEntityTypeID eq ${entityType}${includeClosedEntities ? `` : ` and EntityStatusID eq ${EntityStatus.Open}`}`
        );
    }

    public async entityChildren(id: number): Promise<IEntityChildren[]> {
        const entityUrl = `${this.entityUrl}(${id})`;
        const updates = this.getEntities(`${entityUrl}/ReportingEntityUpdates?$select=ID&$top=10`);
        return [
            { ChildType: 'Reporting updates', CanBeAdopted: false, ChildIDs: (await updates).map(w => w.ID) }
        ];
    }
}