import { AadHttpClient } from "@microsoft/sp-http";
import { WebPartContext } from '@microsoft/sp-webpart-base';

export interface IDataAPI {
    URL: string;
    AppIdUri: string;
    ApiClient: AadHttpClient;
    createClient: (context: WebPartContext, resourceEndpoint: string) => Promise<AadHttpClient>;
}

export class DataAPI implements IDataAPI {
    public URL = null;
    public AppIdUri = null;
    public ApiClient = null;

    public async createClient(context: WebPartContext, resourceEndpoint: string): Promise<AadHttpClient> {
        this.AppIdUri = resourceEndpoint;
        const client = await context.aadHttpClientFactory.getClient(resourceEndpoint);
        this.ApiClient = client;
        return client;
    }
}