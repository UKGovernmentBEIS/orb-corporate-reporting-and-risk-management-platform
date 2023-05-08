import React, { useContext } from 'react';
import { useRouteMatch } from 'react-router-dom';
import {
	IGroup,
	IDirectorate,
	IMilestone,
	IProject,
	IKeyWorkArea,
	IWorkStream,
	IMetric,
	IBenefit,
	ICommitment,
	IDependency,
	ListDefaults
} from '../types';
import { EntityList } from './EntityList';
import { GroupForm } from './group/GroupForm';
import { DirectorateForm } from './directorate/DirectorateForm';
import { TooltipHost } from 'office-ui-fabric-react/lib/Tooltip';
import { MilestoneForm } from './milestone/MilestoneForm';
import { ProjectForm } from './project/ProjectForm';
import { KeyWorkAreaForm } from './keyWorkArea/KeyWorkAreaForm';
import { WorkStreamForm } from './workStream/WorkStreamForm';
import { MetricForm } from './metric/MetricForm';
import { BenefitForm } from './benefit/BenefitForm';
import { CommitmentForm } from './commitment/CommitmentForm';
import { DependencyForm } from './dependency/DependencyForm';
import { ErrorBoundary } from './ErrorBoundary';
import { IWithErrorHandlingProps, withErrorHandling } from './withErrorHandling';
import { IUseApiProps } from './useApi';
import { ReportingEntityList } from './reportingEntities/ReportingEntityList';
import { renderDate } from './cr/ListRenderers';
import { DataContext } from './DataContext';
import { IntegrationContext } from './IntegrationContext';

export interface IPerformanceReportingAdminProps extends IUseApiProps, IWithErrorHandlingProps {
	entity: string;
}

const PerformanceReportingAdmin = (props: IPerformanceReportingAdminProps) => {
	const { entity } = props;
	const { disableDirectorateManagement, disableGroupManagement, disableProjectManagement } = useContext(IntegrationContext);
	const { dataServices } = useContext(DataContext);
	const { params } = useRouteMatch();
	const customReportingEntityTypeId = params?.['id'];

	const lcc = ListDefaults.columnWidths;
	return (
		<ErrorBoundary>
			{entity === 'Groups' &&
				<EntityList<IGroup>
					{...props}
					disableAdd={disableGroupManagement}
					disableDelete={() => disableGroupManagement}
					enableShowHideClosedEntities={true}
					entityName={{ Plural: 'Groups', Singular: 'Group' }}
					columns={[
						{ key: '1', name: 'Name', fieldName: 'Name', minWidth: 200, maxWidth: 400, isResizable: true },
						{ key: '2', name: 'Director General', fieldName: 'DirectorGeneral', minWidth: lcc.user, isResizable: true },
						{ key: '3', name: 'Status', fieldName: 'Status', minWidth: 100, isResizable: true }
					]}
					loadListItems={showClosedEntities => dataServices.groupService.readAllForList(showClosedEntities)}
					mapEntitiesToListItems={groups => groups.map(g => (
						{
							key: g.ID,
							Name: g.Title,
							DirectorGeneral: g.DirectorGeneralUser?.Title,
							Status: g.EntityStatus?.Title
						}
					))}
					entityForm={(showForm, entityId, onSaved, onCancelled) =>
						<GroupForm
							{...props}
							showForm={showForm}
							entityId={entityId}
							onSaved={onSaved}
							onCancelled={onCancelled} />
					}
					onCheckDelete={id => dataServices.groupService.entityChildren(id)}
					onDelete={id => dataServices.groupService.delete(id)}
				/>
			}
			{entity === 'Directorates' &&
				<EntityList<IDirectorate>
					{...props}
					disableAdd={disableDirectorateManagement}
					disableDelete={() => disableDirectorateManagement}
					enableShowHideClosedEntities={true}
					entityName={{ Plural: 'Directorates', Singular: 'Directorate' }}
					columns={[
						{ key: '1', name: 'Name', fieldName: 'Name', minWidth: 200, maxWidth: 400, isResizable: true },
						{ key: '2', name: 'Group', fieldName: 'Group', minWidth: 150, isResizable: true },
						{ key: '3', name: 'Director', fieldName: 'Director', minWidth: lcc.user, isResizable: true },
						{ key: '4', name: 'Alternative approver', fieldName: 'AlternativeApprover', minWidth: lcc.user, isResizable: true },
						{ key: '5', name: 'Status', fieldName: 'Status', minWidth: 100, isResizable: true }
					]}
					loadListItems={showClosedEntities => dataServices.directorateService.readAllForList(showClosedEntities)}
					mapEntitiesToListItems={directorates => directorates.map(d => (
						{
							key: d.ID,
							Name: d.Title,
							Director: d.DirectorUser?.Title,
							AlternativeApprover: d.ReportApproverUser?.Title,
							Group: d.Group?.Title,
							Status: d.EntityStatus?.Title
						}
					))}
					entityForm={(showForm, entityId, onSaved, onCancelled) =>
						<DirectorateForm
							{...props}
							entityName="Directorate"
							showForm={showForm}
							entityId={entityId}
							onSaved={onSaved}
							onCancelled={onCancelled}
						/>
					}
					onCheckDelete={id => dataServices.directorateService.entityChildren(id)}
					onDelete={id => dataServices.directorateService.delete(id)}
				/>
			}
			{entity === 'Projects' &&
				<EntityList<IProject>
					{...props}
					disableDelete={p => disableProjectManagement && p?.CorporateProjectID !== 'Local'}
					enableShowHideClosedEntities={true}
					entityName={{ Plural: 'Projects', Singular: 'Project' }}
					columns={[
						{ key: '8', name: 'BEIS project ID', fieldName: 'CorporateProjectID', minWidth: 80, maxWidth: 120, isResizable: true },
						{ key: '1', name: 'Project name', fieldName: 'Name', minWidth: 200, maxWidth: 400, isResizable: true },
						{ key: '2', name: 'Senior Responsible Owner', fieldName: 'SeniorResponsibleOwnerUser', minWidth: lcc.user, isResizable: true },
						{ key: '3', name: 'Project manager', fieldName: 'ProjectManagerUser', minWidth: lcc.user, isResizable: true },
						{ key: '4', name: 'Alternative approver', fieldName: 'AlternativeApproverUser', minWidth: lcc.user, isResizable: true },
						{ key: '5', name: 'Attributes', fieldName: 'ProjectAttributes', minWidth: 100, isResizable: true },
						{ key: '6', name: 'Start date', fieldName: 'StartDateValue', minWidth: 100, isResizable: true, onRender: item => renderDate(item.StartDate) },
						{ key: '7', name: 'End date', fieldName: 'EndDateValue', minWidth: 100, isResizable: true, onRender: item => renderDate(item.EndDate) }
					]}
					loadListItems={showClosedEntities => dataServices.projectService.readAllForList(showClosedEntities)}
					mapEntitiesToListItems={projects => projects.map(p => (
						{
							key: p.ID,
							Name: p.Title,
							CorporateProjectID: p.CorporateProjectID,
							SeniorResponsibleOwnerUser: p.SeniorResponsibleOwnerUser?.Title,
							ProjectManagerUser: p.ProjectManagerUser?.Title,
							AlternativeApproverUser: p.ReportApproverUser?.Title,
							ProjectAttributes: p.Attributes?.map(pa => pa.AttributeType?.Title).join(', '),
							StartDate: p.StartDate,
							StartDateValue: p.StartDate?.valueOf(),
							EndDate: p.EndDate,
							EndDateValue: p.EndDate?.valueOf()
						}
					))}
					entityForm={(showForm, entityId, onSaved, onCancelled) =>
						<ProjectForm
							{...props}
							showForm={showForm}
							entityId={entityId}
							onSaved={onSaved}
							onCancelled={onCancelled}
						/>
					}
					onCheckDelete={id => dataServices.projectService.entityChildren(id)}
					onDelete={id => dataServices.projectService.delete(id)}
				/>
			}
			{entity === 'KeyWorkAreas' &&
				<EntityList<IKeyWorkArea>
					{...props}
					enableShowHideClosedEntities={true}
					entityName={{ Plural: 'Key work areas', Singular: 'Key work area' }}
					columns={[
						{ key: '1', name: 'Key work area name', fieldName: 'Name', minWidth: 200, maxWidth: 400, isResizable: true },
						{ key: '2', name: 'Directorate', fieldName: 'Directorate', minWidth: 200, isResizable: true },
						{ key: '3', name: 'Lead', fieldName: 'LeadUser', minWidth: lcc.user, isResizable: true },
						{ key: '4', name: 'Contributors', fieldName: 'Contributors', minWidth: lcc.user, isResizable: true },
						{ key: '5', name: 'Status', fieldName: 'Status', minWidth: 100, isResizable: true }
					]}
					loadListItems={showClosedEntities => dataServices.keyWorkAreaService.readAllForList(showClosedEntities)}
					mapEntitiesToListItems={keyWorkAreas => keyWorkAreas.map(kwa => (
						{
							key: kwa.ID,
							Directorate: kwa.Directorate?.Title,
							Name: kwa.Title,
							LeadUser: kwa.LeadUser?.Title,
							Contributors: kwa.Contributors?.map(c => c.ContributorUser?.Title).join(', '),
							Status: kwa.EntityStatus?.Title
						}
					))}
					entityForm={(showForm: boolean, entityId: number, onSaved, onCancelled) =>
						<KeyWorkAreaForm
							{...props}
							entityName="Key Work Area"
							showForm={showForm}
							entityId={entityId}
							onSaved={onSaved}
							onCancelled={onCancelled}
						/>
					}
					onCheckDelete={id => dataServices.keyWorkAreaService.entityChildren(id)}
					onDelete={id => dataServices.keyWorkAreaService.delete(id)}
				/>
			}
			{entity === 'WorkStreams' &&
				<EntityList<IWorkStream>
					{...props}
					enableShowHideClosedEntities={true}
					entityName={{ Plural: 'Work streams', Singular: 'Work stream' }}
					columns={[
						{ key: '1', name: 'Work stream ID', fieldName: 'WorkStreamCode', minWidth: 50, maxWidth: 100, isResizable: true },
						{ key: '2', name: 'Work stream name', fieldName: 'Name', minWidth: 200, maxWidth: 400, isResizable: true },
						{ key: '3', name: 'Project', fieldName: 'Project', minWidth: 150, isResizable: true },
						{ key: '4', name: 'Lead', fieldName: 'LeadUser', minWidth: lcc.user, isResizable: true },
						{ key: '5', name: 'Contributors', fieldName: 'Contributors', minWidth: lcc.user, isResizable: true },
						{ key: '6', name: 'Status', fieldName: 'Status', minWidth: 100, isResizable: true }
					]}
					loadListItems={showClosedEntities => dataServices.workStreamService.readAllForList(showClosedEntities)}
					mapEntitiesToListItems={workStreams => workStreams.map(ws => (
						{
							key: ws.ID,
							Project: ws.Project?.Title,
							WorkStreamCode: ws.WorkStreamCode,
							Name: ws.Title,
							LeadUser: ws.LeadUser?.Title,
							Contributors: ws.Contributors?.map(c => c.ContributorUser?.Title).join(', '),
							Status: ws.EntityStatus?.Title
						}
					))}
					entityForm={(showForm, entityId, onSaved, onCancelled) =>
						<WorkStreamForm
							{...props}
							showForm={showForm}
							entityId={entityId}
							onSaved={onSaved}
							onCancelled={onCancelled} />
					}
					onCheckDelete={id => dataServices.workStreamService.entityChildren(id)}
					onDelete={id => dataServices.workStreamService.delete(id)}
				/>
			}
			{entity === 'Metrics' &&
				<EntityList<IMetric>
					{...props}
					enableShowHideClosedEntities={true}
					entityName={{ Plural: 'Metrics', Singular: 'Metric' }}
					columns={[
						{ key: '1', name: 'Name', fieldName: 'Name', minWidth: 150, maxWidth: 400, isResizable: true },
						{ key: '2', name: 'Directorate', fieldName: 'Directorate', minWidth: 150, isResizable: true },
						{ key: '3', name: 'Target performance lower limit', fieldName: 'TargetPerformanceLowerLimit', minWidth: 100, isResizable: true },
						{ key: '4', name: 'Target performance upper limit', fieldName: 'TargetPerformanceUpperLimit', minWidth: 100, isResizable: true },
						{ key: '5', name: 'Lead', fieldName: 'Lead', minWidth: lcc.user, isResizable: true },
						{ key: '6', name: 'Contributors', fieldName: 'Contributors', minWidth: lcc.user, isResizable: true },
						{ key: '7', name: 'Status', fieldName: 'Status', minWidth: 100, isResizable: true }
					]}
					loadListItems={showClosedEntities => dataServices.metricService.readAllForList(showClosedEntities)}
					mapEntitiesToListItems={metrics => metrics.map(m => (
						{
							key: m.ID,
							Name: m.Title,
							Directorate: m.Directorate?.Title,
							TargetPerformanceLowerLimit: m.TargetPerformanceLowerLimit || m.TargetPerformanceLowerLimit === 0 ? Number(m.TargetPerformanceLowerLimit) : null,
							TargetPerformanceUpperLimit: m.TargetPerformanceUpperLimit || m.TargetPerformanceUpperLimit === 0 ? Number(m.TargetPerformanceUpperLimit) : null,
							Lead: m.LeadUser?.Title,
							Contributors: m.Contributors?.map(c => c.ContributorUser?.Title).join(', '),
							Status: m.EntityStatus?.Title
						}
					))}
					entityForm={(showForm, entityId, onSaved, onCancelled) =>
						<MetricForm
							{...props}
							entityName="Metric"
							showForm={showForm}
							entityId={entityId}
							onSaved={onSaved}
							onCancelled={onCancelled}
						/>
					}
					onCheckDelete={id => dataServices.metricService.entityChildren(id)}
					onDelete={id => dataServices.metricService.delete(id)}
				/>
			}
			{entity === 'Milestones' &&
				<EntityList<IMilestone>
					{...props}
					enableShowHideClosedEntities={true}
					entityName={{ Plural: 'Milestones', Singular: 'Milestone' }}
					columns={[
						{ key: '1', name: 'Milestone ID', fieldName: 'MilestoneCode', minWidth: 100, maxWidth: 100, isResizable: true },
						{ key: '2', name: 'Name', fieldName: 'Name', minWidth: 200, maxWidth: 400, isResizable: true },
						{
							key: '3', name: 'Directorate/Project', fieldName: 'ParentsParentEntity', minWidth: 200, isResizable: true,
							onRender: function renderParent(m) { return <TooltipHost content={m.MilestoneType}>{m.ParentsParentEntity}</TooltipHost>; }
						},
						{ key: '4', name: 'Key work area/Work stream', fieldName: 'ParentEntity', minWidth: 200, isResizable: true },
						{ key: '5', name: 'Lead', fieldName: 'Lead', minWidth: lcc.user, isResizable: true },
						{ key: '6', name: 'Status', fieldName: 'Status', minWidth: 100, isResizable: true }
					]}
					loadListItems={showClosedEntities => dataServices.milestoneService.readAllDirectorateAndProjectMilestonesForList(showClosedEntities)}
					mapEntitiesToListItems={milestones => milestones.map(m => (
						{
							key: m.ID,
							ParentEntity: m.KeyWorkArea?.Title || m.WorkStream?.Title,
							ParentsParentEntity: m.KeyWorkArea?.Directorate?.Title || m.WorkStream?.Project?.Title,
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
							onCancelled={onCancelled} />
					}
					onCheckDelete={id => dataServices.milestoneService.entityChildren(id)}
					onDelete={id => dataServices.milestoneService.delete(id)}
				/>
			}
			{entity === 'Benefits' &&
				<EntityList<IBenefit>
					{...props}
					enableShowHideClosedEntities={true}
					entityName={{ Plural: 'Benefits', Singular: 'Benefit' }}
					columns={[
						{ key: '1', name: 'Name', fieldName: 'Name', minWidth: 200, maxWidth: 400, isResizable: true },
						{ key: '2', name: 'Project', fieldName: 'Project', minWidth: 150, isResizable: true },
						{ key: '3', name: 'Target performance lower limit', fieldName: 'TargetPerformanceLowerLimit', minWidth: 100, isResizable: true },
						{ key: '4', name: 'Target performance upper limit', fieldName: 'TargetPerformanceUpperLimit', minWidth: 100, isResizable: true },
						{ key: '5', name: 'Lead', fieldName: 'Lead', minWidth: lcc.user, isResizable: true },
						{ key: '6', name: 'Contributors', fieldName: 'Contributors', minWidth: lcc.user, isResizable: true },
						{ key: '7', name: 'Status', fieldName: 'Status', minWidth: 100, isResizable: true }
					]}
					loadListItems={showClosedEntities => dataServices.benefitService.readAllForList(showClosedEntities)}
					mapEntitiesToListItems={benefits => benefits.map(b => (
						{
							key: b.ID,
							Name: b.Title,
							Project: b.Project?.Title,
							TargetPerformanceLowerLimit: b.TargetPerformanceLowerLimit || b.TargetPerformanceLowerLimit === 0 ? Number(b.TargetPerformanceLowerLimit) : null,
							TargetPerformanceUpperLimit: b.TargetPerformanceUpperLimit || b.TargetPerformanceUpperLimit === 0 ? Number(b.TargetPerformanceUpperLimit) : null,
							Lead: b.LeadUser?.Title,
							Contributors: b.Contributors?.map(c => c.ContributorUser?.Title).join(', '),
							Status: b.EntityStatus?.Title
						}
					))}
					entityForm={(showForm, entityId, onSaved, onCancelled) =>
						<BenefitForm
							{...props}
							entityName="Benefit"
							showForm={showForm}
							entityId={entityId}
							onSaved={onSaved}
							onCancelled={onCancelled}
						/>
					}
					onCheckDelete={id => dataServices.benefitService.entityChildren(id)}
					onDelete={id => dataServices.benefitService.delete(id)}
				/>
			}
			{entity === 'Commitments' &&
				<EntityList<ICommitment>
					{...props}
					enableShowHideClosedEntities={true}
					entityName={{ Plural: 'Commitments', Singular: 'Commitment' }}
					columns={[
						{ key: '1', name: 'Name', fieldName: 'Name', minWidth: 200, maxWidth: 400, isResizable: true },
						{ key: '2', name: 'Directorate', fieldName: 'Directorate', minWidth: 200, isResizable: true },
						{ key: '3', name: 'Lead', fieldName: 'Lead', minWidth: lcc.user, isResizable: true },
						{ key: '4', name: 'Contributors', fieldName: 'Contributors', minWidth: lcc.user, isResizable: true },
						{ key: '5', name: 'Status', fieldName: 'Status', minWidth: 100, isResizable: true }
					]}
					loadListItems={showClosedEntities => dataServices.commitmentService.readAllForList(showClosedEntities)}
					mapEntitiesToListItems={commitments => commitments.map(c => (
						{
							key: c.ID,
							Directorate: c.Directorate?.Title,
							Name: c.Title,
							Lead: c.LeadUser?.Title,
							Contributors: c.Contributors?.map(co => co.ContributorUser?.Title).join(', '),
							Status: c.EntityStatus?.Title
						}
					))}
					entityForm={(showForm, entityId, onSaved, onCancelled) =>
						<CommitmentForm
							{...props}
							entityName="Commitment"
							showForm={showForm}
							entityId={entityId}
							onSaved={onSaved}
							onCancelled={onCancelled}
						/>
					}
					onCheckDelete={id => dataServices.commitmentService.entityChildren(id)}
					onDelete={id => dataServices.commitmentService.delete(id)}
				/>
			}
			{entity === 'Dependencies' &&
				<EntityList<IDependency>
					{...props}
					enableShowHideClosedEntities={true}
					entityName={{ Plural: 'Dependencies', Singular: 'Dependency' }}
					columns={[
						{ key: '1', name: 'Name', fieldName: 'Name', minWidth: 200, maxWidth: 400, isResizable: true },
						{ key: '2', name: 'Project', fieldName: 'Project', minWidth: 150, isResizable: true },
						{ key: '3', name: 'Lead', fieldName: 'Lead', minWidth: lcc.user, isResizable: true },
						{ key: '4', name: 'Contributors', fieldName: 'Contributors', minWidth: lcc.user, isResizable: true },
						{ key: '5', name: 'Status', fieldName: 'Status', minWidth: 100, isResizable: true }
					]}
					loadListItems={showClosedEntities => dataServices.dependencyService.readAllForList(showClosedEntities)}
					mapEntitiesToListItems={dependencies => dependencies.map(d => (
						{
							key: d.ID,
							Project: d.Project?.Title,
							Name: d.Title,
							Lead: d.LeadUser?.Title,
							Contributors: d.Contributors?.map(c => c.ContributorUser?.Title).join(', '),
							Status: d.EntityStatus?.Title
						}
					))}
					entityForm={(showForm, entityId, onSaved, onCancelled) =>
						<DependencyForm
							{...props}
							showForm={showForm}
							entityId={entityId}
							onSaved={onSaved}
							onCancelled={onCancelled} />
					}
					onCheckDelete={id => dataServices.dependencyService.entityChildren(id)}
					onDelete={id => dataServices.dependencyService.delete(id)}
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

export default withErrorHandling(PerformanceReportingAdmin);
