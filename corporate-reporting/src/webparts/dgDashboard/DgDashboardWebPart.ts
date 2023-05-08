import React from 'react';
import { IWebPartComponentProps } from '../../types';
import DataAPIWebPart, { IDataAPIWebPartProps } from '../DataAPIWebPart';
import {
	DirectorateService, DirectorateUpdateService, KeyWorkAreaService, KeyWorkAreaUpdateService, ProjectService,
	ProjectUpdateService, SignOffService, WorkStreamService, WorkStreamUpdateService
} from '../../services';

export default class DgDashboardWebPart extends DataAPIWebPart<IDataAPIWebPartProps> {
	protected WebPartDescription = "Web part for Director Generals to view their directorates' reporting data";

	protected renderWebPart(): React.ReactElement<IWebPartComponentProps> {
		const { context, api } = this;
		return React.createElement(
			'DgDashboard',
			{
				dataServices: {
					directorateService: new DirectorateService(context, api),
					directorateUpdateService: new DirectorateUpdateService(context, api),
					keyWorkAreaService: new KeyWorkAreaService(context, api),
					keyWorkAreaUpdateService: new KeyWorkAreaUpdateService(context, api),
					projectService: new ProjectService(context, api),
					projectUpdateService: new ProjectUpdateService(context, api),
					signOffService: new SignOffService(context, api),
					workStreamService: new WorkStreamService(context, api),
					workStreamUpdateService: new WorkStreamUpdateService(context, api)
				},
				isFullPage: true
			}
		);
	}
}
