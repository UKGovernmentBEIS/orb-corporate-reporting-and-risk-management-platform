import { WebPartContext } from '@microsoft/sp-webpart-base';
import { EntityService } from './EntityService';
import { IDataAPI } from '../types';
import { IRiskRiskType } from '../types/RiskRiskType';

export class RiskRiskTypeService extends EntityService<IRiskRiskType> {
    constructor(spfxContext: WebPartContext, api: IDataAPI) {
        super(spfxContext, api, `/RiskRiskTypes`);
    }
}