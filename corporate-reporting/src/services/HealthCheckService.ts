import { WebPartContext } from '@microsoft/sp-webpart-base';
import { BaseService } from './BaseService';
import { AadHttpClient, HttpClientResponse } from '@microsoft/sp-http';
import { IDataAPI } from '../types';

export class HealthCheckService extends BaseService<HttpClientResponse>{
    protected Api: IDataAPI;
    protected spfxContext: WebPartContext;

    constructor(spfxContext: WebPartContext, api: IDataAPI) {
        super();
        this.Api = api;
        this.spfxContext = spfxContext;
    }

    public async firstRequestToAPI(): Promise<string> {
        const request = this.Api.ApiClient.get(`${this.Api.URL}/HealthCheck?firstRequest=&checkDb=&checkCurrentUser`, AadHttpClient.configurations.v1);
        const response = await this.makeRequest(request);
        return response.value;
    }
}
