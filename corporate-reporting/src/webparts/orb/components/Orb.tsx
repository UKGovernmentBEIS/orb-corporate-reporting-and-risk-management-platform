import React, { ReactNode, useState } from 'react';
import styles from './Orb.module.scss';
import { HashRouter, Switch, Route, Redirect, RouteProps, useLocation } from 'react-router-dom';
import { useUserContext } from '../../../components/useUserContext';
import OrbHome from '../../../components/OrbHome';
import SystemAdministration from '../../../components/SystemAdministration';
import { OrbMenu } from '../../../components/OrbMenu';
import { IconButton, MessageBar, MessageBarType, Panel, PanelType } from 'office-ui-fabric-react';
import { IUserPermissionService } from '../../../services/UserPermissionService';
import { useApi } from '../../../components/useApi';
import { IWithErrorHandlingProps, withErrorHandling } from '../../../components/withErrorHandling';
import { IDataServices, IIntegrationProps } from '../../../types';
import { useDataContext } from '../../../components/useDataContext';
import { CrLoadingOverlay } from '../../../components/cr/CrLoadingOverlay';
import { ErrorBoundary } from '../../../components/ErrorBoundary';
import PerformanceReportingAdmin from '../../../components/PerformanceReportingAdmin';
import PartnerOrganisationReportingAdmin from '../../../components/PartnerOrganisationReportingAdmin';
import RiskReportingAdmin from '../../../components/RiskReportingAdmin';
import { RiskRegisterList } from '../../../components/riskRegister/RiskRegisterList';
import { FinancialRiskRegister } from '../../../components/financialRisk/FinancialRiskRegister';
import ReportArchive from '../../../components/ReportArchive';
import { useIntegration } from '../../../components/useIntegration';
import { DataContext } from '../../../components/DataContext';
import { IntegrationContext } from '../../../components/IntegrationContext';
import { OrbUserContext } from '../../../components/OrbUserContext';

interface IOrbProps extends IWithErrorHandlingProps, IIntegrationProps {
	dataServices: IDataServices;
	isFullPage: boolean;
	showSpSiteNavLinks: boolean;
	emphasiseProjectsWithAttribute: string;
	emphasisedProjectsHeaderText: string;
	otherProjectsHeaderText: string;
	children?: ReactNode;
}

interface IUserPermsRouteProps extends RouteProps {
	userPermissions: IUserPermissionService;
}

const DirectorateAdminRoute = ({ userPermissions: up, children, ...props }: IUserPermsRouteProps) =>
	<Route {...props} render={() => up.UserCanViewDirectorateEntities() ? children : <Redirect to='/not-authorised' />} />;

const ProjectAdminRoute = ({ userPermissions: up, children, ...props }: IUserPermsRouteProps) =>
	<Route {...props} render={() => up.UserCanViewProjectEntities() ? children : <Redirect to='/not-authorised' />} />;

const MilestoneAdminRoute = ({ userPermissions: up, children, ...props }: IUserPermsRouteProps) =>
	<Route {...props} render={() => up.UserCanViewDirectorateEntities() || up.UserCanViewProjectEntities() || up.UserCanViewPartnerOrganisationEntities() ? children : <Redirect to='/not-authorised' />} />;

const PartnerOrganisationAdminRoute = ({ userPermissions: up, children, ...props }: IUserPermsRouteProps) =>
	<Route {...props} render={() => up.UserCanViewPartnerOrganisationEntities() ? children : <Redirect to='/not-authorised' />} />;

const RiskAdminRoute = ({ userPermissions: up, children, ...props }: IUserPermsRouteProps) =>
	<Route {...props} render={() => up.UserCanViewRiskEntities() ? children : <Redirect to='/not-authorised' />} />;

const FinancialRiskUserRoute = ({ userPermissions: up, children, ...props }: IUserPermsRouteProps) =>
	<Route {...props} render={() => up.UserCanViewFinancialRiskEntities() ? children : <Redirect to='/not-authorised' />} />;

const FinancialRiskAdminRoute = ({ userPermissions: up, children, ...props }: IUserPermsRouteProps) =>
	<Route {...props} render={() => up.UserIsFinancialRiskAdmin() ? children : <Redirect to='/not-authorised' />} />;

const CustomSectionsAdminRoute = ({ userPermissions: up, children, ...props }: IUserPermsRouteProps) =>
	<Route {...props} render={() => up.UserIsCustomSectionsAdmin() ? children : <Redirect to='/not-authorised' />} />;

const AdminRoute = ({ userPermissions: up, children, ...props }: IUserPermsRouteProps) =>
	<Route {...props} render={() => up.UserIsSystemAdmin() ? children : <Redirect to='/not-authorised' />} />;

const NotAuthorised = () =>
	<MessageBar messageBarType={MessageBarType.error}>Not authorised</MessageBar>;

const NotFound = () =>
	<MessageBar messageBarType={MessageBarType.error}>Not found &apos;{useLocation().pathname}&apos;</MessageBar>;

const Orb = (props: IOrbProps) => {
	const { dataServices, errorHandling } = props;
	const [panelMenuIsOpen, setPanelMenuIsOpen] = useState(false);
	const apiConnected = useApi(dataServices, errorHandling);
	const uc = useUserContext(apiConnected, dataServices, errorHandling);
	const ld = useDataContext(apiConnected, dataServices, errorHandling);
	const integration = useIntegration({
		disableDirectorateManagement: props.disableDirectorateManagement,
		disableGroupManagement: props.disableGroupManagement,
		disablePartnerOrganisationManagement: props.disablePartnerOrganisationManagement,
		disableProjectManagement: props.disableProjectManagement,
		disableUserManagement: props.disableUserManagement,
		dataSourceName: props.dataSourceName
	});
	const routeProps = { ...props, apiConnected: apiConnected, ...uc, ...ld };
	return (
		<ErrorBoundary>
			<IntegrationContext.Provider value={integration}>
				<DataContext.Provider value={ld}>
					<OrbUserContext.Provider value={uc}>
						{!uc.userContext.UserId &&
							<CrLoadingOverlay isLoading={true} />
							||
							<HashRouter>
								<div className={styles.orb}>
									<div className={styles.orbCollapseMenuButton}>
										<IconButton
											iconProps={{ iconName: 'CollapseMenu' }}
											onClick={() => setPanelMenuIsOpen(!panelMenuIsOpen)}
											title="Toggle navigation pane"
											ariaLabel="Toggle navigation pane"
										/>
									</div>
									<div className={styles.orbMenu}>
										<OrbMenu  {...routeProps} />
									</div>
									<Panel type={PanelType.smallFixedNear} isOpen={panelMenuIsOpen} onDismiss={() => setPanelMenuIsOpen(false)}>
										<OrbMenu  {...routeProps} onLinkClicked={() => setPanelMenuIsOpen(false)} />
									</Panel>
									<div className={styles.orbContent}>
										<Switch>
											<Route exact path="/">
												<Redirect to="/my-updates" />
											</Route>
											<Route exact path="/my-updates">
												<OrbHome  {...routeProps} />
											</Route>
											<Route exact path="/draft-reports">
												<OrbHome  {...routeProps} />
											</Route>
											<Route exact path="/sign-off">
												<OrbHome  {...routeProps} />
											</Route>
											<Route exact path="/report-archive">
												<ReportArchive  {...routeProps} />
											</Route>
											<Route exact path="/risk-register">
												<RiskRegisterList  {...routeProps} />
											</Route>
											<FinancialRiskUserRoute exact path="/financial-risk-register"  {...routeProps}>
												<FinancialRiskRegister  {...routeProps} />
											</FinancialRiskUserRoute>
											<AdminRoute path="/performance-reporting/groups"  {...routeProps}>
												<PerformanceReportingAdmin  {...routeProps} entity="Groups" />
											</AdminRoute>
											<DirectorateAdminRoute path="/performance-reporting/directorates"  {...routeProps}>
												<PerformanceReportingAdmin  {...routeProps} entity="Directorates" />
											</DirectorateAdminRoute>
											<ProjectAdminRoute path="/performance-reporting/projects"  {...routeProps}>
												<PerformanceReportingAdmin  {...routeProps} entity="Projects" />
											</ProjectAdminRoute>
											<DirectorateAdminRoute path="/performance-reporting/key-work-areas"  {...routeProps}>
												<PerformanceReportingAdmin  {...routeProps} entity="KeyWorkAreas" />
											</DirectorateAdminRoute>
											<ProjectAdminRoute path="/performance-reporting/work-streams"  {...routeProps}>
												<PerformanceReportingAdmin  {...routeProps} entity="WorkStreams" />
											</ProjectAdminRoute>
											<DirectorateAdminRoute path="/performance-reporting/metrics"  {...routeProps}>
												<PerformanceReportingAdmin  {...routeProps} entity="Metrics" />
											</DirectorateAdminRoute>
											<MilestoneAdminRoute path="/performance-reporting/milestones"  {...routeProps}>
												<PerformanceReportingAdmin  {...routeProps} entity="Milestones" />
											</MilestoneAdminRoute>
											<ProjectAdminRoute path="/performance-reporting/benefits"  {...routeProps}>
												<PerformanceReportingAdmin  {...routeProps} entity="Benefits" />
											</ProjectAdminRoute>
											<DirectorateAdminRoute path="/performance-reporting/commitments"  {...routeProps}>
												<PerformanceReportingAdmin  {...routeProps} entity="Commitments" />
											</DirectorateAdminRoute>
											<ProjectAdminRoute path="/performance-reporting/dependencies"  {...routeProps}>
												<PerformanceReportingAdmin  {...routeProps} entity="Dependencies" />
											</ProjectAdminRoute>
											<Route path="/performance-reporting/:id">
												<PerformanceReportingAdmin  {...routeProps} entity="Custom" />
											</Route>
											<RiskAdminRoute path="/risk-reporting/risks"  {...routeProps}>
												<RiskReportingAdmin  {...routeProps} entity="Risks" />
											</RiskAdminRoute>
											<RiskAdminRoute path="/risk-reporting/risk-mitigating-actions"  {...routeProps}>
												<RiskReportingAdmin  {...routeProps} entity="RiskMitigationActions" />
											</RiskAdminRoute>
											<FinancialRiskUserRoute path="/risk-reporting/financial-risks"  {...routeProps}>
												<RiskReportingAdmin  {...routeProps} entity="FinancialRisks" />
											</FinancialRiskUserRoute>
											<FinancialRiskUserRoute path="/risk-reporting/financial-risk-mitigating-actions"  {...routeProps}>
												<RiskReportingAdmin  {...routeProps} entity="FinancialRiskMitigationActions" />
											</FinancialRiskUserRoute>
											<PartnerOrganisationAdminRoute path="/partner-organisation-reporting/partner-organisations"  {...routeProps}>
												<PartnerOrganisationReportingAdmin  {...routeProps} entity="PartnerOrganisations" />
											</PartnerOrganisationAdminRoute>
											<MilestoneAdminRoute path="/partner-organisation-reporting/milestones"  {...routeProps}>
												<PartnerOrganisationReportingAdmin  {...routeProps} entity="Milestones" />
											</MilestoneAdminRoute>
											<PartnerOrganisationAdminRoute path="/partner-organisation-reporting/risks"  {...routeProps}>
												<PartnerOrganisationReportingAdmin  {...routeProps} entity="PartnerOrganisationRisks" />
											</PartnerOrganisationAdminRoute>
											<PartnerOrganisationAdminRoute path="/partner-organisation-reporting/risk-mitigating-actions"  {...routeProps}>
												<PartnerOrganisationReportingAdmin  {...routeProps} entity="PartnerOrganisationRiskMitigationActions" />
											</PartnerOrganisationAdminRoute>
											<PartnerOrganisationAdminRoute path="/partner-organisation-reporting/:id"  {...routeProps}>
												<PartnerOrganisationReportingAdmin  {...routeProps} entity="Custom" />
											</PartnerOrganisationAdminRoute>
											<AdminRoute path="/admin/users"  {...routeProps}>
												<SystemAdministration  {...routeProps} entity="Users" />
											</AdminRoute>
											<AdminRoute path="/admin/user-groups"  {...routeProps}>
												<SystemAdministration  {...routeProps} entity="UserGroups" />
											</AdminRoute>
											<AdminRoute path="/admin/user-directorates"  {...routeProps}>
												<SystemAdministration  {...routeProps} entity="UserDirectorates" />
											</AdminRoute>
											<AdminRoute path="/admin/user-partner-organisations"  {...routeProps}>
												<SystemAdministration  {...routeProps} entity="UserPartnerOrganisations" />
											</AdminRoute>
											<AdminRoute path="/admin/user-projects"  {...routeProps}>
												<SystemAdministration  {...routeProps} entity="UserProjects" />
											</AdminRoute>
											<AdminRoute path="/admin/milestone-types"  {...routeProps}>
												<SystemAdministration  {...routeProps} entity="MilestoneTypes" />
											</AdminRoute>
											<AdminRoute path="/admin/benefit-types"  {...routeProps}>
												<SystemAdministration  {...routeProps} entity="BenefitTypes" />
											</AdminRoute>
											<AdminRoute path="/admin/attributes"  {...routeProps}>
												<SystemAdministration  {...routeProps} entity="Attributes" />
											</AdminRoute>
											<AdminRoute path="/admin/reporting-frequencies"  {...routeProps}>
												<SystemAdministration  {...routeProps} entity="ReportingFrequencies" />
											</AdminRoute>
											<AdminRoute path="/admin/risk-types"  {...routeProps}>
												<SystemAdministration  {...routeProps} entity="RiskTypes" />
											</AdminRoute>
											<AdminRoute path="/admin/risk-discussion-forums"  {...routeProps}>
												<SystemAdministration  {...routeProps} entity="RiskDiscussionForums" />
											</AdminRoute>
											<AdminRoute path="/admin/thresholds"  {...routeProps}>
												<SystemAdministration  {...routeProps} entity="Thresholds" />
											</AdminRoute>
											<AdminRoute path="/admin/threshold-appetites"  {...routeProps}>
												<SystemAdministration  {...routeProps} entity="ThresholdAppetites" />
											</AdminRoute>
											<AdminRoute path="/admin/units"  {...routeProps}>
												<SystemAdministration  {...routeProps} entity="Units" />
											</AdminRoute>
											<AdminRoute path="/admin/administrators"  {...routeProps}>
												<SystemAdministration  {...routeProps} entity="Administrators" />
											</AdminRoute>
											<CustomSectionsAdminRoute path="/admin/custom-report-sections"  {...routeProps}>
												<SystemAdministration  {...routeProps} entity="CustomReportSections" />
											</CustomSectionsAdminRoute>
											<FinancialRiskAdminRoute path="/admin/financial-risk-user-groups"  {...routeProps}>
												<SystemAdministration  {...routeProps} entity="FinancialRiskUserGroups" />
											</FinancialRiskAdminRoute>
											<Route path="/not-authorised">
												<NotAuthorised />
											</Route>
											<Route path="*">
												<NotFound />
											</Route>
										</Switch>
									</div>
								</div>
							</HashRouter>
						}
					</OrbUserContext.Provider>
				</DataContext.Provider>
			</IntegrationContext.Provider>
		</ErrorBoundary >
	);
};

export default withErrorHandling(Orb);
