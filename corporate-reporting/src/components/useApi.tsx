import { useCallback, useEffect, useState } from 'react';
import { IDataServices } from '../types/IDataServices';
import { IErrorHandling } from './withErrorHandling';

export interface IUseApiProps {
    apiConnected: boolean;
}

export const useApi = (dataServices: IDataServices, { onError, onFirstAPIRequestError }: IErrorHandling): boolean => {
    const [apiConnected, setApiConnected] = useState(false);
    const logError = useCallback(onError, [onError]);
    const logErrorOnConnect = useCallback(onFirstAPIRequestError, [onFirstAPIRequestError]);

    useEffect(() => {
        const firstRequestToAPI = async (): Promise<boolean> => {
            try {
                const res: string = await dataServices.healthCheckService.firstRequestToAPI();

                if (res === 'ok') {
                    return true;
                }
                else {
                    logErrorOnConnect?.(res, dataServices.tokenRefreshService);
                    return false;
                }
            } catch (err) {
                logError?.(`Error connecting to API`, err.message);
                return false;
            }
        };

        const initialiseApiConnection = async () => {
            if (!apiConnected) {
                setApiConnected(await firstRequestToAPI());
            }
        };

        initialiseApiConnection();
    }, [apiConnected, dataServices.healthCheckService, dataServices.tokenRefreshService, logErrorOnConnect, logError]);

    return apiConnected;
};
