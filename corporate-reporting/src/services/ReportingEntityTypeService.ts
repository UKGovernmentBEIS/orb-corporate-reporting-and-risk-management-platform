import { WebPartContext } from '@microsoft/sp-webpart-base';
import { IDataAPI, IEntityChildren } from '../types';
import { EntityService } from '.';
import { ICustomReportingEntityType } from '../types/CustomReportingEntityType';

export class ReportingEntityTypeService extends EntityService<ICustomReportingEntityType> {
    protected childrenEntities = ['Contributors($expand=ContributorUser)', 'Attributes($expand=AttributeType)'];

    constructor(spfxContext: WebPartContext, api: IDataAPI) {
        super(spfxContext, api, `/ReportingEntityTypes`);
    }

    public readAllForLookup(): Promise<ICustomReportingEntityType[]> {
        return this.readAll(
            `?$select=ID,Title,ReportTypeID`
            + `&$orderby=Title`
        );
    }

    public readAllForList(): Promise<ICustomReportingEntityType[]> {
        return this.readAll(
            `?$filter=ID gt 0`
            + `&$orderby=Title`
            + `&$expand=ReportType`
        );
    }

    public readAllForNavigation(): Promise<ICustomReportingEntityType[]> {
        return this.readAll(`?$filter=ID gt 0&$select=ID,Title,ReportTypeID`);
    }

    public async entityChildren(id: number): Promise<IEntityChildren[]> {
        const reportingEntityTypeUrl = `${this.entityUrl}(${id})`;
        const entities = this.getEntities(`${reportingEntityTypeUrl}/ReportingEntities?$select=ID&$top=10`);
        return [
            { ChildType: 'Reporting entities', CanBeAdopted: false, ChildIDs: (await entities).map(w => w.ID) }
        ];
    }
}