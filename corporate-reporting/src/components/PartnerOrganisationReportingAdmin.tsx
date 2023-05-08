import React, { useContext } from 'react';
import {
	IMilestone, IPartnerOrganisation, IPartnerOrganisationRisk, IPartnerOrganisationRiskMitigationAction, ListDefaults
} from '../types';
import { EntityList } from './EntityList';
import { TooltipHost } from 'office-ui-fabric-react/lib/Tooltip';
import { MilestoneForm } from './milestone/MilestoneForm';
import { PartnerOrganisationForm } from './partnerOrganisation/PartnerOrganisationForm';
import { PartnerOrganisationRiskForm } from './partnerOrganisationRisk/PartnerOrganisationRiskForm';
import { PartnerOrganisationRiskMitigationActionForm } from './partnerOrganisationRiskMitigationAction/PartnerOrganisationRiskMitigationActionForm';
import { ErrorBoundary } from './ErrorBoundary';
import { IWithErrorHandlingProps, withErrorHandling } from './withErrorHandling';
import { IUseApiProps } from './useApi';
import { MilestoneType } from '../refData/MilestoneType';
import { ReportingEntityList } from './reportingEntities/ReportingEntityList';
import { useRouteMatch } from 'react-router-dom';
import { DataContext } from './DataContext';
import { IntegrationContext } from './IntegrationContext';

export interface IPartnerOrganisationReportingAdminProps extends IUseApiProps, IWithErrorHandlingProps {
	entity: string;
}

const PartnerOrganisationReportingAdmin = (props: IPartnerOrganisationReportingAdminProps) => {
	const { entity } = props;
	const { params } = useRouteMatch();
	const customReportingEntityTypeId = params?.['id'];
	const { disablePartnerOrganisationManagement } = useContext(IntegrationContext);
	const { dataServices, loadLookupData: { partnerOrganisationRisks } } = useContext(DataContext);

	const lcc = ListDefaults.columnWidths;
	return (
		<ErrorBoundary>
			{entity === 'PartnerOrganisations' &&
				<EntityList<IPartnerOrganisation>
					{...props}
					enableShowHideClosedEntities={true}
					entityName={{ Plural: 'Partner Organisations', Singular: 'Partner Organisation' }}
					disableAdd={disablePartnerOrganisationManagement}
					disableDelete={() => disablePartnerOrganisationManagement}
					columns={[
						{ key: '1', name: 'Name', fieldName: 'Name', minWidth: 200, isResizable: true },
						{ key: '2', name: 'Group', fieldName: 'Group', minWidth: 100, isResizable: true },
						{ key: '3', name: 'Directorate', fieldName: 'Directorate', minWidth: 150, isResizable: true },
						{ key: '4', name: 'SCS policy lead sponsor (approver)', fieldName: 'LeadPolicySponsor', minWidth: lcc.user, isResizable: true },
						{ key: '5', name: 'Alternative report approver', fieldName: 'ReportAuthor', minWidth: lcc.user, isResizable: true },
						{ key: '6', name: 'Contributors', fieldName: 'Contributors', minWidth: lcc.user, isResizable: true },
						{ key: '7', name: 'Read-only contributors', fieldName: 'ReadOnlyContributors', minWidth: lcc.user, isResizable: true },
						{ key: '8', name: 'Status', fieldName: 'Status', minWidth: 100, isResizable: true }
					]}
					loadListItems={showClosed => dataServices.partnerOrganisationService.readAllForList(showClosed)}
					mapEntitiesToListItems={partnerOrganisations => partnerOrganisations.map(po => (
						{
							key: po.ID,
							Name: po.Title,
							Group: po.Directorate?.Group?.Title,
							Directorate: po.Directorate?.Title,
							LeadPolicySponsor: po.LeadPolicySponsorUser?.Title,
							ReportAuthor: po.ReportAuthorUser?.Title,
							Contributors: po.Contributors?.filter(c => c.IsReadOnly != true).map(c => c.ContributorUser?.Title).join(', '),
							ReadOnlyContributors: po.Contributors?.filter(c => c.IsReadOnly == true).map(c => c.ContributorUser?.Title).join(', '),
							Status: po.EntityStatus?.Title
						}
					))}
					entityForm={(showForm, entityId, onSaved, onCancelled) =>
						<PartnerOrganisationForm
							{...props}
							showForm={showForm}
							entityId={entityId}
							onSaved={onSaved}
							onCancelled={onCancelled} />
					}
					onCheckDelete={id => dataServices.partnerOrganisationService.entityChildren(id)}
					onDelete={id => dataServices.partnerOrganisationService.delete(id)}
				/>
			}
			{entity === 'Milestones' &&
				<EntityList<IMilestone>
					{...props}
					enableShowHideClosedEntities={true}
					entityName={{ Plural: 'Partner organisation milestones', Singular: 'Partner organisation milestone' }}
					columns={[
						{ key: '1', name: 'Milestone ID', fieldName: 'MilestoneCode', minWidth: 50, maxWidth: 100, isResizable: true },
						{ key: '2', name: 'Name', fieldName: 'Name', minWidth: 200, isResizable: true },
						{
							key: '3', name: 'Partner organisation', fieldName: 'PartnerOrg', minWidth: 200, isResizable: true,
							onRender: function renderParent(m) { return <TooltipHost content={m.MilestoneType}>{m.PartnerOrg}</TooltipHost>; }
						},
						{ key: '5', name: 'Lead', fieldName: 'Lead', minWidth: lcc.user, isResizable: true },
						{ key: '6', name: 'Status', fieldName: 'Status', minWidth: 50, isResizable: true }
					]}
					loadListItems={showClosedEntities => dataServices.milestoneService.readAllPartnerOrganisationMilestonesForList(showClosedEntities)}
					mapEntitiesToListItems={milestones => milestones.map(m => (
						{
							key: m.ID,
							PartnerOrg: m.PartnerOrganisation?.Title,
							MilestoneType: m.MilestoneType?.Title,
							MilestoneCode: m.MilestoneCode,
							Name: m.Title,
							Lead: m.LeadUser?.Title,
							Status: m.EntityStatus?.Title
						}
					))}
					entityForm={(showForm, entityId, onSaved, onCancelled) =>
						<MilestoneForm
							{...props}
							showForm={showForm}
							entityId={entityId}
							onSaved={onSaved}
							onCancelled={onCancelled}
							defaultValues={[{ field: 'MilestoneTypeID', value: MilestoneType.PartnerOrganisation }]}
						/>
					}
					onCheckDelete={id => dataServices.milestoneService.entityChildren(id)}
					onDelete={id => dataServices.milestoneService.delete(id)}
				/>
			}
			{entity === 'PartnerOrganisationRisks' &&
				<EntityList<IPartnerOrganisationRisk>
					{...props}
					enableShowHideClosedEntities={true}
					entityName={{ Plural: 'Partner organisation risks', Singular: 'Partner organisation risk' }}
					addChild={{ Name: 'Partner organisation risk mitigation action' }}
					columns={[
						{ key: '1', name: 'Risk ID', fieldName: 'RiskCode', minWidth: 70, maxWidth: 70, isResizable: true },
						{ key: '2', name: 'Risk name', fieldName: 'Name', minWidth: 250, isResizable: true },
						{ key: '6', name: 'Partner organisation', fieldName: 'PartnerOrganisation', minWidth: 100, isResizable: true },
						{ key: '7', name: 'Owner', fieldName: 'Owner', minWidth: lcc.user, isResizable: true },
						{ key: '8', name: 'No. of actions', fieldName: 'NumberOfActions', minWidth: 50, isResizable: true },
						{ key: '9', name: 'Status', fieldName: 'Status', minWidth: 50, isResizable: true }
					]}
					loadListItems={showClosedEntities => dataServices.partnerOrganisationRiskService.readAllForList(showClosedEntities)}
					mapEntitiesToListItems={partnerOrganisationRisks => partnerOrganisationRisks.map(r => (
						{
							key: r.ID,
							RiskCode: r.RiskCode,
							Name: r.Title,
							PartnerOrganisation: r.PartnerOrganisation?.Title,
							Owner: r.RiskOwnerUser?.Title,
							NumberOfActions: r.PartnerOrganisationRiskMitigationActions?.length,
							Status: r.EntityStatus?.Title
						}
					))}
					entityForm={(showForm, entityId, onSaved, onCancelled) =>
						<PartnerOrganisationRiskForm
							{...props}
							showForm={showForm}
							entityId={entityId}
							onSaved={onSaved}
							onCancelled={onCancelled} />
					}
					childEntityForm={(showForm, parentEntityId, onSaved, onCancelled) =>
						<PartnerOrganisationRiskMitigationActionForm
							{...props}
							showForm={showForm}
							onSaved={onSaved}
							onCancelled={onCancelled}
							defaultValues={[{ field: 'PartnerOrganisationRiskID', value: parentEntityId }]} />
					}
					onCheckDelete={id => dataServices.partnerOrganisationRiskService.entityChildren(id)}
					onDelete={id => dataServices.partnerOrganisationRiskService.delete(id)}
					onChange={() => partnerOrganisationRisks(true)}
				/>
			}
			{entity === 'PartnerOrganisationRiskMitigationActions' &&
				<EntityList<IPartnerOrganisationRiskMitigationAction>
					{...props}
					enableShowHideClosedEntities={true}
					entityName={{ Plural: 'Partner organisation risk mitigating actions', Singular: 'Partner organisation risk mitigating action' }}
					columns={[
						{ key: '0', name: 'Risk ID', fieldName: 'RiskCode', minWidth: 50, maxWidth: 70, isResizable: true },
						{ key: '1', name: 'ID', fieldName: 'Code', minWidth: 20, maxWidth: 20, isResizable: true },
						{ key: '2', name: 'Risk mitigating action name', fieldName: 'Name', minWidth: 300, isResizable: true },
						{ key: '3', name: 'Risk', fieldName: 'Risk', minWidth: 200, isResizable: true },
						{ key: '4', name: 'Partner organisation', fieldName: 'partnerOrganisation', minWidth: 200, isResizable: true },
						{ key: '5', name: 'Owner', fieldName: 'Owner', minWidth: lcc.user, isResizable: true },
						{ key: '6', name: 'Status', fieldName: 'Status', minWidth: 50, isResizable: true }
					]}
					loadListItems={ShowClosedEntities => dataServices.partnerOrganisationRiskMitigationActionService.readAllForList(ShowClosedEntities)}
					mapEntitiesToListItems={pormas => pormas.map(a => (
						{
							key: a.ID,
							RiskCode: a.PartnerOrganisationRisk?.RiskCode,
							Code: a.RiskMitigationActionCode,
							Risk: a.PartnerOrganisationRisk?.Title,
							partnerOrganisation: a.PartnerOrganisationRisk?.PartnerOrganisation?.Title,
							Name: a.Title,
							Owner: a.OwnerUser?.Title,
							Status: a.EntityStatus?.Title
						}
					))}
					entityForm={(showForm, entityId, onSaved, onCancelled) =>
						<PartnerOrganisationRiskMitigationActionForm
							{...props}
							showForm={showForm}
							entityId={entityId}
							onSaved={onSaved}
							onCancelled={onCancelled} />
					}
					onCheckDelete={id => dataServices.partnerOrganisationRiskMitigationActionService.entityChildren(id)}
					onDelete={id => dataServices.partnerOrganisationRiskMitigationActionService.delete(id)}
				/>
			}
			{entity === 'Custom' &&
				<ReportingEntityList
					{...props}
					reportingEntityTypeId={customReportingEntityTypeId}
				/>
			}
		</ErrorBoundary>
	);
};

export default withErrorHandling(PartnerOrganisationReportingAdmin);
