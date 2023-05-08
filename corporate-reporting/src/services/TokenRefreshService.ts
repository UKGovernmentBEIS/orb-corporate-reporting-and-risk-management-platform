import { WebPartContext } from '@microsoft/sp-webpart-base';

export interface ITokenRefreshService {
    refreshToken: () => Promise<void>;
}

export class TokenRefreshService implements ITokenRefreshService {
    private _context: WebPartContext;
    private _resourceEndpoint: string;

    constructor(context: WebPartContext, resourceEndpoint: string) {
        this._context = context;
        this._resourceEndpoint = resourceEndpoint;
    }

    public async refreshToken(): Promise<void> {
        const tokenProvider = await this._context.aadTokenProviderFactory.getTokenProvider();
        await tokenProvider.getToken(this._resourceEndpoint, false);
    }
}