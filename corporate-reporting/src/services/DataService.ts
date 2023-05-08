import { BaseService } from './BaseService';
import { WebPartContext } from '@microsoft/sp-webpart-base';
import { AadHttpClient, HttpClientResponse } from '@microsoft/sp-http';
import { IDataAPI } from '../types';

export abstract class DataService<T> extends BaseService<HttpClientResponse> {
    protected Api: IDataAPI;
    protected spfxContext: WebPartContext;

    constructor(spfxContext: WebPartContext, api: IDataAPI) {
        super();
        this.Api = api;
        this.spfxContext = spfxContext;
    }

    protected async getEntity(url: string): Promise<T> {
        const request = this.Api.ApiClient.get(url, AadHttpClient.configurations.v1);
        return await this.makeRequest(request);
    }

    protected async getEntities(url: string): Promise<T[]> {
        const request = this.Api.ApiClient.get(url, AadHttpClient.configurations.v1);
        const data = await this.makeRequest(request);
        return data.value;
    }

    protected async postQuery(url: string, query: string): Promise<T[]> {
        const requestHeaders = new Headers();
        requestHeaders.append("Content-Type", "text/plain");
        const request = this.Api.ApiClient.post(url, AadHttpClient.configurations.v1, { headers: requestHeaders, body: query });
        const data = await this.makeRequest(request);
        return data.value;
    }

    protected async postEntity(entity: T, url: string): Promise<T> {
        const requestHeaders = new Headers();
        requestHeaders.append("Content-Type", "application/json");
        const request = this.Api.ApiClient.post(url, AadHttpClient.configurations.v1, { headers: requestHeaders, body: JSON.stringify(entity) });
        return await this.makeRequest(request);
    }

    protected patchEntity(entity: Partial<T>, url: string): Promise<void> {
        const requestHeaders: Headers = new Headers();
        requestHeaders.append("Content-Type", "application/json");
        return this.makeRequest(this.Api.ApiClient.fetch(url, AadHttpClient.configurations.v1,
            { method: 'PATCH', headers: requestHeaders, body: JSON.stringify(entity) }
        ));
    }

    protected deleteEntity(url: string): Promise<void> {
        return this.makeRequest(this.Api.ApiClient.fetch(url, AadHttpClient.configurations.v1, { method: 'DELETE' }));
    }
}
