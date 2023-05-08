import { WebPartContext } from '@microsoft/sp-webpart-base';
import { EntityService } from './EntityService';
import { IDataAPI, IEntityChildren } from '../types';
import { IThreshold } from '../types/Threshold';

export class ThresholdService extends EntityService<IThreshold> {
    constructor(spfxContext: WebPartContext, api: IDataAPI) {
        super(spfxContext, api, `/Thresholds`);
    }

    public readAllForLookup(): Promise<IThreshold[]> {
        return this.readAll(`?$expand=ThresholdAppetites&$orderby=Title`);
    }

    public async entityChildren(id: number): Promise<IEntityChildren[]> {
        const thresholdUrl = `${this.entityUrl}(${id})`;
        const riskTypes = this.getEntities(`${thresholdUrl}/RiskTypes?$select=ID&$top=10`);
        const appetites = this.getEntities(`${thresholdUrl}/ThresholdAppetites?$select=ID&$top=10`);
        return [
            { ChildType: 'Risk types', CanBeAdopted: true, ChildIDs: (await riskTypes).map(r => r.ID) },
            { ChildType: 'Threshold appetites', CanBeAdopted: true, ChildIDs: (await appetites).map(t => t.ID) }
        ];
    }
}