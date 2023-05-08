import { HttpClientResponse } from '@microsoft/sp-http';
import { DateService } from './DateService';

export abstract class BaseService<T extends HttpClientResponse> {
    protected async makeRequest(httpRequest: Promise<T>): Promise<any> { // eslint-disable-line @typescript-eslint/no-explicit-any
        return new Promise<any>(async (resolve, reject) => { // eslint-disable-line @typescript-eslint/no-explicit-any,no-async-promise-executor
            try {
                const response = await httpRequest;
                if (response.ok && response.status === 204) { // E.g. Successful patch
                    return resolve();
                } else if (response.ok) {
                    const data = await response.json();
                    return resolve(DateService.convertODataDates(data));
                } else {
                    if (response.status === 401) {
                        return reject({ response: response, message: "Unauthorised" });
                    } else {
                        return reject({ response: response });
                    }
                }
            } catch (error) {
                return reject(error);
            }
        });
    }
}
