import { WebPartContext } from '@microsoft/sp-webpart-base';
import { EntityService } from './EntityService';
import { IDataAPI, IEntityChildren } from '../types';
import { IRiskType } from '../types/RiskType';

export class RiskTypeService extends EntityService<IRiskType> {
    constructor(spfxContext: WebPartContext, api: IDataAPI) {
        super(spfxContext, api, `/RiskTypes`);
    }

    public readAllForLookup(): Promise<IRiskType[]> {
        return this.readAll(`?$expand=Threshold($expand=ThresholdAppetites)&$orderby=Title`);
    }

    public readAllForList(): Promise<IRiskType[]> {
        return this.readAll(`?$expand=Threshold`);
    }

    public async entityChildren(id: number): Promise<IEntityChildren[]> {
        return [
            { ChildType: 'Risks', CanBeAdopted: true, ChildIDs: (await this.getEntities(`${this.entityUrl}(${id})/RiskRiskTypes?$select=RiskID&$top=10`)).map(r => r['RiskID']) }
        ];
    }
}