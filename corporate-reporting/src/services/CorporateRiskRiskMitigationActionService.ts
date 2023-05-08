import { EntityService } from './EntityService';
import { ICorporateRiskRiskMitigationAction, IDataAPI } from '../types';
import { WebPartContext } from '@microsoft/sp-webpart-base';

export class CorporateRiskRiskMitigationActionService extends EntityService<ICorporateRiskRiskMitigationAction> {
    constructor(spfxContext: WebPartContext, api: IDataAPI) {
        super(spfxContext, api, '/CorporateRiskRiskMitigationActions');
    }
}