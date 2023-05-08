import React from 'react';
import { PrimaryButton, TextField } from 'office-ui-fabric-react';
import { AadHttpClientFactory, AadHttpClient } from '@microsoft/sp-http';
import { ErrorBoundary } from '../../../components/ErrorBoundary';

export interface IApiExplorerProps {
  httpClientFactory: AadHttpClientFactory;
  appIdUri: string;
}

export interface IApiExplorerState {
  HttpClient: AadHttpClient;
  Query: string;
  Response: string;
}

export class ApiExplorer extends React.Component<IApiExplorerProps, IApiExplorerState> {
  constructor(props: IApiExplorerProps) {
    super(props);
    this.state = { HttpClient: null, Query: 'https://dev-corp-reporting-api.azurewebsites.net/odata/Groups', Response: null };
  }

  public render(): React.ReactElement<IApiExplorerProps> {
    return (
      <ErrorBoundary>
        <TextField label="Query" value={this.state.Query} onChange={(_, v) => this.setState({ Query: v })} />
        <PrimaryButton text="Go" onClick={() => this.getData(this.state.HttpClient, this.state.Query)} />
        <TextField label="Response" multiline rows={30} value={this.state.Response} />
      </ErrorBoundary>
    );
  }

  public componentDidMount(): void {
    this.getClient(this.props.httpClientFactory, this.props.appIdUri);
  }

  public componentDidUpdate(prevProps: IApiExplorerProps): void {
    if (prevProps.appIdUri !== this.props.appIdUri) {
      this.getClient(this.props.httpClientFactory, this.props.appIdUri);
    }
  }

  private getClient = async (clientFactory: AadHttpClientFactory, resourceUri: string) => {
    const client = await clientFactory.getClient(resourceUri);
    this.setState({ HttpClient: client });
  }

  private getData = async (httpClient: AadHttpClient, query: string) => {
    const response = await httpClient.get(query, AadHttpClient.configurations.v1);
    const data = await response.json();
    this.setState({ Response: JSON.stringify(data, null, '\t') });
  }
}
