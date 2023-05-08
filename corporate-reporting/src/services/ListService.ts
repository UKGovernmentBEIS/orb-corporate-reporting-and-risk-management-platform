import { SPDataService } from './SPDataService';
import { SPHttpClient } from '@microsoft/sp-http';
import { WebPartContext } from '@microsoft/sp-webpart-base';
import { IEntity } from '../types';

export interface IListService {
    getItems: () => Promise<IEntity[]>;
}

export class ListService extends SPDataService implements IListService {
    private _listUrl: string;

    constructor(spfxContext: WebPartContext, listUrl: string) {
        super(spfxContext);
        this._listUrl = listUrl;
    }

    public getItems = async (): Promise<IEntity[]> => {
        if (this._listUrl == null || this._listUrl === '') {
            return Promise.reject('List URL not configured');
        }
        const request = this.spfxContext.spHttpClient.get(this._listUrl, SPHttpClient.configurations.v1);
        const data = await this.makeRequest(request);
        return data.value;
    }
}
