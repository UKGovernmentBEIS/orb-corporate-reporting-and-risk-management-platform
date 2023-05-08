import React from 'react';
import styles from '../styles/cr.module.scss';
import { MessageBar, MessageBarType } from 'office-ui-fabric-react/lib/MessageBar';
import { DefaultButton } from 'office-ui-fabric-react/lib/Button';
import { ITokenRefreshService } from '../services';
import { Text } from 'office-ui-fabric-react';

export interface IErrorHandling {
    onError: (errorMessage: string, errorDetail?: string) => void;
    onFirstAPIRequestError?: (errorType: string, tokenRefreshService: ITokenRefreshService) => void;
    clearErrors: () => void;
}

export interface IWithErrorHandlingProps {
    errorHandling: IErrorHandling;
}

export interface IErrorHandlingState {
    Error: string;
    FirstAPICallError: string;
    TokenRefreshService: ITokenRefreshService;
    Refreshed: boolean;
}

export const withErrorHandling = <T extends {}>(WrappedComponent: React.ComponentType<T>) => { // eslint-disable-line @typescript-eslint/ban-types, @typescript-eslint/explicit-module-boundary-types
    return class extends React.Component<T & IWithErrorHandlingProps, IErrorHandlingState> { // eslint-disable-line react/display-name
        constructor(props: any) { // eslint-disable-line @typescript-eslint/no-explicit-any
            super(props);
            this.state = { Error: null, FirstAPICallError: null, TokenRefreshService: null, Refreshed: false };
        }

        public onError = (errorUserMessage: string, errorDetail?: string): void => {
            this.setState({ Error: errorUserMessage });
            if (errorDetail) console.log(`${errorUserMessage}: ${errorDetail}`);
        }

        public clearErrors = () => {
            this.setState({ Error: null });
        }

        public onFirstAPIRequestError = (errorType: string, tokenRefreshService: ITokenRefreshService) => {
            this.setState({ FirstAPICallError: errorType, TokenRefreshService: tokenRefreshService });
        }

        public render() {
            const { FirstAPICallError } = this.state;
            if (FirstAPICallError !== null) {
                let errMsg: string;

                if (FirstAPICallError === 'api_connect_error') {
                    errMsg = "Connection failed with the api, please contact the administrator.";
                }
                else if (FirstAPICallError === 'db_connect_error') {
                    errMsg = "Connection failed with the database, pleae contact the administrator.";
                }
                else if (FirstAPICallError === 'db_user_disabled') {
                    errMsg = "Your ORB user account is disabled, please contact the administrator.";
                }
                else {
                    // user not found - API returns username
                    errMsg = `There is no record for your username '${FirstAPICallError}' in the database, please contact the administrator.`;
                }

                return (
                    <div className={styles.cr}>
                        <MessageBar messageBarType={MessageBarType.error}>
                            <div>{errMsg}</div>
                            <div>
                                {FirstAPICallError === 'api_connect_error' &&
                                    <DefaultButton text="Start new session" onClick={() => this.state.TokenRefreshService.refreshToken().then(() => this.setState({ Refreshed: true }))} />
                                }
                            </div>
                            <div>
                                {this.state.Refreshed &&
                                    <Text>Please refresh the page to load the new session</Text>
                                }
                            </div>
                        </MessageBar>
                    </div>
                );
            }
            else {
                return (
                    <>
                        {this.state.Error &&
                            <MessageBar messageBarType={MessageBarType.error}>{this.state.Error}</MessageBar>
                        }
                        <WrappedComponent
                            errorHandling={{
                                onError: this.onError,
                                clearErrors: this.clearErrors,
                                onFirstAPIRequestError: this.onFirstAPIRequestError
                            }}
                            {...this.props} />
                    </>
                );
            }
        }
    };
};
