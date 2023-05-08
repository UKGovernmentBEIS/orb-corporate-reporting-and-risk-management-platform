import { WebPartContext } from '@microsoft/sp-webpart-base';
import { EntityService } from './EntityService';
import { IDataAPI, IEntity, IEntityChildren } from '../types';

export class MeasurementUnitService extends EntityService<IEntity> {
    constructor(spfxContext: WebPartContext, api: IDataAPI) {
        super(spfxContext, api, `/MeasurementUnits`);
    }

    public async entityChildren(id: number): Promise<IEntityChildren[]> {
        const unitUrl = `${this.entityUrl}(${id})`;
        const benefits = this.getEntities(`${unitUrl}/Benefits?$select=ID&$top=10`);
        const metrics = this.getEntities(`${unitUrl}/Metrics?$select=ID&$top=10`);
        return [
            { ChildType: 'Benefits', CanBeAdopted: true, ChildIDs: (await benefits).map(b => b.ID) },
            { ChildType: 'Metrics', CanBeAdopted: true, ChildIDs: (await metrics).map(m => m.ID) }
        ];
    }
}