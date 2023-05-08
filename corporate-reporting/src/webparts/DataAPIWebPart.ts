import React from 'react';
import ReactDom from 'react-dom';
import { Version } from '@microsoft/sp-core-library';
import { BaseClientSideWebPart } from '@microsoft/sp-webpart-base';

import { IWebPartComponentProps, DataAPI, IDataAPI } from '../types';
import { IPropertyPaneConfiguration, PropertyPaneTextField, PropertyPaneToggle } from '@microsoft/sp-property-pane';

export interface IDataAPIWebPartProps {
    appIdUri: string;
    apiUrl: string;
    isFullPage?: boolean;
}

export default abstract class DataAPIWebPart<P extends IDataAPIWebPartProps> extends BaseClientSideWebPart<P> {
    protected api: IDataAPI = new DataAPI();
    protected abstract WebPartDescription: string;

    public render(): void {
        if (this.isWebPartConfigured(this.properties)) {
            this.api.URL = this.properties.apiUrl;
            this.api.createClient(this.context, this.properties.appIdUri).then(() => {
                ReactDom.render(this.renderWebPart(), this.domElement);
            });
        } else {
            this.domElement.innerHTML = `<div>Please configure the web part properties.</div>`;
        }
    }

    protected isWebPartConfigured(props: P): boolean {
        return props.appIdUri != null && props.appIdUri !== '' && props.apiUrl != null && props.apiUrl !== '';
    }

    protected abstract renderWebPart(): React.ReactElement<IWebPartComponentProps>;

    protected onDispose(): void {
        ReactDom.unmountComponentAtNode(this.domElement);
    }

    protected get dataVersion(): Version {
        return Version.parse('1.0');
    }

    protected get disableReactivePropertyChanges(): boolean {
        return true;
    }

    protected getPropertyPaneConfiguration(): IPropertyPaneConfiguration {
        return {
            pages: [
                {
                    header: {
                        description: this.WebPartDescription
                    },
                    groups: [
                        {
                            groupName: 'Settings',
                            groupFields: [
                                PropertyPaneTextField('appIdUri', {
                                    label: 'App ID URI'
                                }),
                                PropertyPaneTextField('apiUrl', {
                                    label: 'API URL'
                                }),
                                PropertyPaneToggle('isFullPage', {
                                    label: 'Is full page?'
                                })
                            ]
                        }
                    ]
                }
            ]
        };
    }
}
