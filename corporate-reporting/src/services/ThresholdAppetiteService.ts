import { WebPartContext } from '@microsoft/sp-webpart-base';
import { EntityService } from './EntityService';
import { IDataAPI } from '../types';
import { IThresholdAppetite } from '../types/ThresholdAppetite';

export class ThresholdAppetiteService extends EntityService<IThresholdAppetite> {
    constructor(spfxContext: WebPartContext, api: IDataAPI) {
        super(spfxContext, api, `/ThresholdAppetites`);
    }

    public readAllForList(): Promise<IThresholdAppetite[]> {
        return this.readAll(`?$expand=Threshold($select=Title),RiskImpactLevel($select=Title),RiskProbability($select=Title)`
            + `&$orderby=ThresholdID,RiskImpactLevelID,RiskProbabilityID`);
    }
}