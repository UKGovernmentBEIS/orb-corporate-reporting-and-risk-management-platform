import React from 'react';
import ReactDom from 'react-dom';
import { Version } from '@microsoft/sp-core-library';
import {
  IPropertyPaneConfiguration,
  PropertyPaneTextField
} from '@microsoft/sp-property-pane';
import { BaseClientSideWebPart } from '@microsoft/sp-webpart-base';

import { ApiExplorer } from './components/ApiExplorer';
import { IApiExplorerProps } from './components/ApiExplorer';

export interface IApiExplorerWebPartProps {
  appIdUri: string;
}

export default class ApiExplorerWebPart extends BaseClientSideWebPart<IApiExplorerWebPartProps> {

  public render(): void {
    if (this.isWebPartConfigured(this.properties)) {
      const element: React.ReactElement<IApiExplorerProps> = React.createElement(
        ApiExplorer,
        {
          httpClientFactory: this.context.aadHttpClientFactory,
          appIdUri: this.properties.appIdUri
        }
      );

      ReactDom.render(element, this.domElement);
    } else {
      this.domElement.innerHTML = `<div>Please configure the web part properties.</div>`;
    }
  }

  protected isWebPartConfigured(props: IApiExplorerWebPartProps): boolean {
    return !!(props.appIdUri);
  }

  protected onDispose(): void {
    ReactDom.unmountComponentAtNode(this.domElement);
  }

  protected get dataVersion(): Version {
    return Version.parse('1.0');
  }

  protected getPropertyPaneConfiguration(): IPropertyPaneConfiguration {
    return {
      pages: [
        {
          groups: [
            {
              groupName: 'API',
              groupFields: [
                PropertyPaneTextField('appIdUri', {
                  label: 'App ID URI'
                })
              ]
            }
          ]
        }
      ]
    };
  }
}
