import { SPDataService } from './SPDataService';
import { SPHttpClient } from '@microsoft/sp-http';

export interface ISiteService {
    getSiteNav: () => Promise<{ Title: string, Url: string }[]>;
}

export class SiteService extends SPDataService implements ISiteService {
    public getSiteNav = async (): Promise<{ Title: string, Url: string }[]> => {
        const request = this.spfxContext.spHttpClient.get(`${this.spfxContext.pageContext.web.absoluteUrl}/_api/web/Navigation/QuickLaunch?$select=Title,Url`, SPHttpClient.configurations.v1);
        const data = await this.makeRequest(request);
        return data.value;
    }
}
