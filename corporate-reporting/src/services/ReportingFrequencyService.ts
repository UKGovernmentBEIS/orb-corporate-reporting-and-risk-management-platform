import { WebPartContext } from '@microsoft/sp-webpart-base';
import { EntityService } from './EntityService';
import { IDataAPI, IReportingFrequency } from '../types';

export class ReportingFrequencyService extends EntityService<IReportingFrequency> {
    constructor(spfxContext: WebPartContext, api: IDataAPI) {
        super(spfxContext, api, `/ReportingFrequencies`);
    }

    public readAllForLookup(): Promise<IReportingFrequency[]> {
        return this.readAll(`?$select=ID,Title,EarlyUpdateWarningDays&$orderby=Title`);
    }
}
