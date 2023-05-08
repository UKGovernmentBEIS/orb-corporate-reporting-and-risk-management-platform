import { BaseService } from './BaseService';
import { WebPartContext } from '@microsoft/sp-webpart-base';
import { SPHttpClientResponse } from '@microsoft/sp-http';

export abstract class SPDataService extends BaseService<SPHttpClientResponse> {
    protected spfxContext: WebPartContext;

    constructor(spfxContext: WebPartContext) {
        super();
        this.spfxContext = spfxContext;
    }
}
