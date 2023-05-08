import React from 'react';
import {
  IPropertyPaneConfiguration,
  PropertyPaneTextField,
  PropertyPaneToggle
} from '@microsoft/sp-property-pane';
import {
  AttributeService,
  AttributeTypeService,
  BenefitService,
  BenefitTypeService,
  BenefitUpdateService,
  CommitmentService,
  CommitmentUpdateService,
  ContributorService,
  CorporateRiskMitigationActionService,
  CorporateRiskMitigationActionUpdateService,
  CorporateRiskRiskMitigationActionService,
  CorporateRiskService,
  CorporateRiskUpdateService,
  DepartmentalObjectiveService,
  DependencyService,
  DependencyUpdateService,
  DirectorateService,
  DirectorateUpdateService,
  EntityStatusService,
  FinancialRiskMitigationActionService,
  FinancialRiskMitigationActionUpdateService,
  FinancialRiskService,
  FinancialRiskUpdateService,
  FinancialRiskUserGroupService,
  GroupService,
  HealthCheckService,
  KeyWorkAreaService,
  KeyWorkAreaUpdateService,
  ListService,
  MeasurementUnitService,
  MetricService,
  MetricUpdateService,
  MilestoneService,
  MilestoneTypeService,
  MilestoneUpdateService,
  PartnerOrganisationRiskMitigationActionService,
  PartnerOrganisationRiskMitigationActionUpdateService,
  PartnerOrganisationRiskRiskTypeService,
  PartnerOrganisationRiskService,
  PartnerOrganisationRiskUpdateService,
  PartnerOrganisationService,
  PartnerOrganisationUpdateService,
  ProjectBusinessCaseTypeService,
  ProjectPhaseService,
  ProjectService,
  ProjectUpdateService,
  ReportBuilderService,
  ReportDueDatesService,
  ReportingFrequencyService,
  RiskAppetiteService,
  RiskDiscussionForumService,
  RiskImpactLevelService,
  RiskPermissionsService,
  RiskProbabilityService,
  RiskRegisterService,
  RiskRiskTypeService,
  RiskTypeService,
  RoleService,
  SignOffService,
  SiteService,
  ThresholdAppetiteService,
  ThresholdService,
  TokenRefreshService,
  UserDirectorateService,
  UserGroupService,
  UserPartnerOrganisationService,
  UserProjectService,
  UserRoleService,
  UserService,
  WorkStreamService,
  WorkStreamUpdateService
} from '../../services';
import DataAPIWebPart, { IDataAPIWebPartProps } from '../DataAPIWebPart';
import { IWebPartComponentProps } from '../../types';
import { ReportingEntityService } from '../../services/ReportingEntityService';
import { ReportingEntityTypeService } from '../../services/ReportingEntityTypeService';
import { ReportingEntityUpdateService } from '../../services/ReportingEntityUpdateService';
import Orb from './components/Orb';

export interface IOrbWebPartProps extends IDataAPIWebPartProps {
  disableDirectorateManagement: boolean;
  disableGroupManagement: boolean;
  disablePartnerOrganisationManagement: boolean;
  disableProjectManagement: boolean;
  disableUserManagement: boolean;
  dataSourceName: string;
  showSpSiteNavLinks: boolean;
  emphasiseProjectsWithAttribute: string;
  emphasisedProjectsHeaderText: string;
  otherProjectsHeaderText: string;
  fundingClassificationsUrl: string;
  economicRingfencesUrl: string;
  policyRingfencesUrl: string;
  budgetingEntitiesUrl: string;
}

export default class OrbWebPart extends DataAPIWebPart<IOrbWebPartProps> {
  protected WebPartDescription = '';

  public renderWebPart(): React.ReactElement<IWebPartComponentProps> {
    const { context, api } = this;
    return React.createElement(
      Orb,
      {
        dataServices: {
          attributeService: new AttributeService(context, api),
          attributeTypeService: new AttributeTypeService(context, api),
          benefitService: new BenefitService(context, api),
          benefitTypeService: new BenefitTypeService(context, api),
          benefitUpdateService: new BenefitUpdateService(context, api),
          commitmentService: new CommitmentService(context, api),
          commitmentUpdateService: new CommitmentUpdateService(context, api),
          contributorService: new ContributorService(context, api),
          corporateRiskMitigationActionService: new CorporateRiskMitigationActionService(context, api),
          corporateRiskMitigationActionUpdateService: new CorporateRiskMitigationActionUpdateService(context, api),
          corporateRiskRiskMitigationActionService: new CorporateRiskRiskMitigationActionService(context, api),
          corporateRiskService: new CorporateRiskService(context, api),
          corporateRiskUpdateService: new CorporateRiskUpdateService(context, api),
          departmentalObjectivesService: new DepartmentalObjectiveService(context, api),
          dependencyService: new DependencyService(context, api),
          dependencyUpdateService: new DependencyUpdateService(context, api),
          directorateService: new DirectorateService(context, api),
          directorateUpdateService: new DirectorateUpdateService(context, api),
          economicRingfenceService: new ListService(context, this.properties.economicRingfencesUrl),
          entityStatusService: new EntityStatusService(context, api),
          financialRiskMitigationActionService: new FinancialRiskMitigationActionService(context, api),
          financialRiskMitigationActionUpdateService: new FinancialRiskMitigationActionUpdateService(context, api),
          financialRiskService: new FinancialRiskService(context, api),
          financialRiskUpdateService: new FinancialRiskUpdateService(context, api),
          financialRiskUserGroupService: new FinancialRiskUserGroupService(context, api),
          fundingClassificationService: new ListService(context, this.properties.fundingClassificationsUrl),
          groupService: new GroupService(context, api),
          healthCheckService: new HealthCheckService(context, api),
          keyWorkAreaService: new KeyWorkAreaService(context, api),
          keyWorkAreaUpdateService: new KeyWorkAreaUpdateService(context, api),
          measurementUnitService: new MeasurementUnitService(context, api),
          metricService: new MetricService(context, api),
          metricUpdateService: new MetricUpdateService(context, api),
          milestoneService: new MilestoneService(context, api),
          milestoneTypeService: new MilestoneTypeService(context, api),
          milestoneUpdateService: new MilestoneUpdateService(context, api),
          partnerOrganisationRiskMitigationActionService: new PartnerOrganisationRiskMitigationActionService(context, api),
          partnerOrganisationRiskMitigationActionUpdateService: new PartnerOrganisationRiskMitigationActionUpdateService(context, api),
          partnerOrganisationRiskRiskTypeService: new PartnerOrganisationRiskRiskTypeService(context, api),
          partnerOrganisationRiskService: new PartnerOrganisationRiskService(context, api),
          partnerOrganisationRiskUpdateService: new PartnerOrganisationRiskUpdateService(context, api),
          partnerOrganisationService: new PartnerOrganisationService(context, api),
          partnerOrganisationUpdateService: new PartnerOrganisationUpdateService(context, api),
          policyRingfenceService: new ListService(context, this.properties.policyRingfencesUrl),
          projectBusinessCaseTypeService: new ProjectBusinessCaseTypeService(context, api),
          projectPhaseService: new ProjectPhaseService(context, api),
          projectService: new ProjectService(context, api),
          projectUpdateService: new ProjectUpdateService(context, api),
          reportBuilderService: new ReportBuilderService(context, api),
          reportDueDatesService: new ReportDueDatesService(context, api),
          reportingEntityService: new ReportingEntityService(context, api),
          reportingEntityTypeService: new ReportingEntityTypeService(context, api),
          reportingEntityUpdateService: new ReportingEntityUpdateService(context, api),
          reportingFrequencyService: new ReportingFrequencyService(context, api),
          riskAppetiteService: new RiskAppetiteService(context, api),
          riskDiscussionForumService: new RiskDiscussionForumService(context, api),
          riskImpactLevelService: new RiskImpactLevelService(context, api),
          riskPermissionsService: new RiskPermissionsService(),
          riskProbabilityService: new RiskProbabilityService(context, api),
          riskRegisterService: new RiskRegisterService(context, api),
          riskRiskTypeService: new RiskRiskTypeService(context, api),
          riskTypeService: new RiskTypeService(context, api),
          roleService: new RoleService(context, api),
          signOffService: new SignOffService(context, api),
          siteService: new SiteService(context),
          thresholdService: new ThresholdService(context, api),
          thresholdAppetiteService: new ThresholdAppetiteService(context, api),
          tokenRefreshService: new TokenRefreshService(context, this.properties.appIdUri),
          budgetingEntitiesService: new ListService(context, this.properties.budgetingEntitiesUrl),
          userDirectorateService: new UserDirectorateService(context, api),
          userGroupService: new UserGroupService(context, api),
          userPartnerOrganisationService: new UserPartnerOrganisationService(context, api),
          userProjectService: new UserProjectService(context, api),
          userRoleService: new UserRoleService(context, api),
          userService: new UserService(context, api),
          workStreamService: new WorkStreamService(context, api),
          workStreamUpdateService: new WorkStreamUpdateService(context, api)
        },
        disableDirectorateManagement: this.properties.disableDirectorateManagement,
        disableGroupManagement: this.properties.disableGroupManagement,
        disablePartnerOrganisationManagement: this.properties.disablePartnerOrganisationManagement,
        disableProjectManagement: this.properties.disableProjectManagement,
        disableUserManagement: this.properties.disableUserManagement,
        dataSourceName: this.properties.dataSourceName,
        isFullPage: true,
        showSpSiteNavLinks: this.properties.showSpSiteNavLinks,
        emphasiseProjectsWithAttribute: this.properties.emphasiseProjectsWithAttribute,
        emphasisedProjectsHeaderText: this.properties.emphasisedProjectsHeaderText,
        otherProjectsHeaderText: this.properties.otherProjectsHeaderText
      }
    );
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
              groupName: 'Global settings',
              groupFields: [
                PropertyPaneTextField('appIdUri', {
                  label: 'App ID URI'
                }),
                PropertyPaneTextField('apiUrl', {
                  label: 'API URL'
                })
              ]
            },
            {
              groupName: 'Integration settings',
              groupFields: [
                PropertyPaneTextField('dataSourceName', {
                  label: 'Data source name'
                }),
                PropertyPaneToggle('disableDirectorateManagement', {
                  label: 'Disable add/edit directorates'
                }),
                PropertyPaneToggle('disableGroupManagement', {
                  label: 'Disable add/edit groups'
                }),
                PropertyPaneToggle('disablePartnerOrganisationManagement', {
                  label: 'Disable add/edit partner organisations'
                }),
                PropertyPaneToggle('disableProjectManagement', {
                  label: 'Disable add/edit projects'
                }),
                PropertyPaneToggle('disableUserManagement', {
                  label: 'Disable user email address edit'
                })
              ]
            },
            {
              groupName: 'Navigation',
              groupFields: [
                PropertyPaneToggle('showSpSiteNavLinks', {
                  label: 'Append links from SharePoint navigation?'
                })
              ]
            },
            {
              groupName: 'Draft reports',
              groupFields: [
                PropertyPaneTextField('emphasiseProjectsWithAttribute', {
                  label: 'Emphasise projects with attribute'
                }),
                PropertyPaneTextField('emphasisedProjectsHeaderText', {
                  label: 'Emphasised projects heading'
                }),
                PropertyPaneTextField('otherProjectsHeaderText', {
                  label: 'Other projects heading'
                })
              ]
            },
            {
              groupName: 'Financial risks',
              groupFields: [
                PropertyPaneTextField('fundingClassificationsUrl', {
                  label: 'Funding classifications URL'
                }),
                PropertyPaneTextField('economicRingfencesUrl', {
                  label: 'Economic ring-fences URL'
                }),
                PropertyPaneTextField('policyRingfencesUrl', {
                  label: 'Policy ring-fences URL'
                }),
                PropertyPaneTextField('budgetingEntitiesUrl', {
                  label: 'Budgeting entities URL'
                })
              ]
            }
          ]
        }
      ]
    };
  }
}
