import React, { useContext } from 'react';
import styles from '../styles/cr.module.scss';
import { IEntity, Entity, AttributeType, IAttributeType, EntityValidations, IEntityValidations, IUser } from '../types';
import { EntityList } from '../components/EntityList';
import { UserRoleForm } from '../components/user/UserRoleForm';
import { UserForm } from '../components/user/UserForm';
import { ThresholdForm } from '../components/threshold/ThresholdForm';
import { ThresholdAppetiteForm } from '../components/threshold/ThresholdAppetiteForm';
import { UserProjectForm } from '../components/user/UserProjectForm';
import { UserPartnerOrganisationForm } from '../components/user/UserPartnerOrganisationForm';
import { EntityForm } from '../components/EntityForm';
import { UserDirectorateForm } from '../components/user/UserDirectorateForm';
import { UserGroupForm } from '../components/user/UserGroupForm';
import { RiskTypeForm } from '../components/risk/RiskTypeForm';
import { ErrorBoundary } from '../components/ErrorBoundary';
import { CrTextField } from '../components/cr/CrTextField';
import { Checkbox } from 'office-ui-fabric-react/lib/Checkbox';
import { EntityStatus } from '../refData/EntityStatus';
import { IUseApiProps } from '../components/useApi';
import { IWithErrorHandlingProps, withErrorHandling } from '../components/withErrorHandling';
import { ReportingFrequencyForm } from './reportingFrequency/ReportingFrequencyForm';
import { FinancialRiskUserGroupForm } from './user/FinancialRiskUserGroupForm';
import { ReportingEntityTypeForm } from './reportingEntities/ReportingEntityTypeForm';
import { DataContext } from './DataContext';
import { IntegrationContext } from './IntegrationContext';

export interface ISystemAdministrationProps extends IUseApiProps, IWithErrorHandlingProps {
	entity: string;
}

const SystemAdministration = (props: ISystemAdministrationProps): React.ReactElement => {
	const { entity } = props;
	const { dataServices, loadLookupData } = useContext(DataContext);
	const { disableUserManagement } = useContext(IntegrationContext);

	const userWidths = { minWidth: 150, maxWidth: 300 };
	return (
		<ErrorBoundary>
			{entity === 'Administrators' &&
				<EntityList
					{...props}
					entityName={{ Plural: 'User roles', Singular: 'User role' }}
					columns={[
						{ key: '1', name: 'User', fieldName: 'User', ...userWidths, isResizable: true },
						{ key: '2', name: 'Role', fieldName: 'Role', minWidth: 200, isResizable: true }
					]}
					loadListItems={() => dataServices.userRoleService.readAllForList()}
					mapEntitiesToListItems={userRoles => userRoles.map(ur => (
						{
							key: ur.ID,
							User: ur.User?.Title,
							Role: ur.Role?.Title
						}
					))}
					entityForm={(showForm, entityId, onSaved, onCancelled) =>
						<UserRoleForm
							{...props}
							showForm={showForm}
							entityId={entityId}
							onSaved={onSaved}
							onCancelled={onCancelled} />
					}
					onCheckDelete={() => Promise.resolve([])}
					onDelete={id => dataServices.userRoleService.delete(id)}
				/>
			}
			{entity === 'Attributes' &&
				<EntityList
					{...props}
					entityName={{ Plural: "Attribute types", Singular: "Attribute type" }}
					columns={[
						{ key: '1', name: 'Attribute type name', fieldName: 'Name', minWidth: 150, maxWidth: 300, isResizable: true },
						{ key: '2', name: 'To be displayed', fieldName: 'Display', minWidth: 150, maxWidth: 300, isResizable: true }
					]}
					loadListItems={() => dataServices.attributeTypeService.readAllForList()}
					mapEntitiesToListItems={attributeTypes => attributeTypes.map(e => (
						{
							key: e.ID,
							Name: e.Title,
							Display: e.Display ? "Yes" : "No"
						}
					))}
					entityForm={(showForm, entityId, onSaved, onCancelled) =>
						<EntityForm<IAttributeType, IEntityValidations>
							{...props}
							renderFormFields={(changeHandlers, formState) =>
								<div>
									<CrTextField
										label="Name"
										className={styles.formField}
										required={true}
										maxLength={255}
										value={formState.FormData.Title}
										onChange={v => changeHandlers.changeTextField(v, 'Title')}
										errorMessage={formState.ValidationErrors.Title} />
									<Checkbox
										className={`${styles.formField} ${styles.formField}`}
										label="Display as Tag?"
										checked={formState.FormData.Display}
										onChange={(_e, isChecked) => changeHandlers.changeCheckbox(isChecked, 'Display')} />
								</div>
							}
							entityName="Attribute type"
							loadEntity={id => dataServices.attributeTypeService.read(id, true, true)}
							loadNewEntity={() => new AttributeType()}
							loadEntityValidations={() => new EntityValidations()}
							onCreate={at => dataServices.attributeTypeService.create(at)}
							onUpdate={at => dataServices.attributeTypeService.update(at.ID, at)}
							showForm={showForm}
							entityId={entityId}
							onSaved={onSaved}
							onCancelled={onCancelled}
						/>
					}
					onCheckDelete={id => dataServices.attributeTypeService.entityChildren(id)}
					onDelete={id => dataServices.attributeTypeService.delete(id)}
				/>
			}
			{entity === 'BenefitTypes' &&
				<EntityList
					{...props}
					entityName={{ Plural: "Benefit types", Singular: "Benefit type" }}
					columns={[
						{ key: '1', name: 'Name', fieldName: 'Name', minWidth: 300, isResizable: true }
					]}
					loadListItems={() => dataServices.benefitTypeService.readAllForList()}
					mapEntitiesToListItems={benefitTypes => benefitTypes.map(e => (
						{
							key: e.ID,
							Name: e.Title
						}
					))}
					entityForm={(showForm, entityId, onSaved, onCancelled) =>
						<EntityForm
							{...props}
							entityName="Benefit type"
							loadEntity={id => dataServices.benefitTypeService.read(id, true, true)}
							loadNewEntity={() => new Entity()}
							loadEntityValidations={() => new EntityValidations()}
							onCreate={bt => dataServices.benefitTypeService.create(bt)}
							onUpdate={bt => dataServices.benefitTypeService.update(bt.ID, bt)}
							showForm={showForm}
							entityId={entityId}
							onSaved={onSaved}
							onCancelled={onCancelled}
						/>
					}
					onChange={() => loadLookupData.benefitTypes(true)}
					onCheckDelete={id => dataServices.benefitTypeService.entityChildren(id)}
					onDelete={id => dataServices.benefitTypeService.delete(id)}
				/>
			}
			{entity === 'MilestoneTypes' &&
				<EntityList
					{...props}
					entityName={{ Plural: "Milestone types", Singular: "Milestone type" }}
					columns={[
						{ key: '1', name: 'Name', fieldName: 'Name', minWidth: 300, isResizable: true }
					]}
					loadListItems={() => dataServices.milestoneTypeService.readAllForList()}
					mapEntitiesToListItems={milestoneTypes => milestoneTypes.map(mt => (
						{
							key: mt.ID,
							Name: mt.Title
						}
					))}
					entityForm={(showForm, entityId, onSaved, onCancelled) =>
						<EntityForm
							{...props}
							entityName="Milestone type"
							loadEntity={id => dataServices.milestoneTypeService.read(id, true, true)}
							loadNewEntity={() => new Entity()}
							loadEntityValidations={() => new EntityValidations()}
							onCreate={mt => dataServices.milestoneTypeService.create(mt)}
							onUpdate={mt => dataServices.milestoneTypeService.update(mt.ID, mt)}
							showForm={showForm}
							entityId={entityId}
							onSaved={onSaved}
							onCancelled={onCancelled}
						/>
					}
					onChange={() => loadLookupData.milestoneTypes(true)}
					onCheckDelete={id => dataServices.milestoneTypeService.entityChildren(id)}
					onDelete={id => dataServices.milestoneTypeService.delete(id)}
				/>
			}
			{entity === 'ReportingFrequencies' &&
				<EntityList
					{...props}
					disableAdd={true}
					disableDelete={() => true}
					entityName={{ Plural: "Reporting frequencies", Singular: "Reporting frequency" }}
					columns={[
						{ key: '1', name: 'Name', fieldName: 'Name', minWidth: 300, maxWidth: 500, isResizable: true },
						{ key: '2', name: 'Days before due to remind authors', fieldName: 'RemindAuthorsDaysBeforeDue', minWidth: 200, isResizable: true },
						{ key: '3', name: 'Days before due to remind approvers', fieldName: 'RemindApproverDaysBeforeDue', minWidth: 200, isResizable: true },
						{ key: '4', name: 'Days for early update warning', fieldName: 'EarlyUpdateWarningDays', minWidth: 200, isResizable: true }
					]}
					loadListItems={() => dataServices.reportingFrequencyService.readAllForList()}
					mapEntitiesToListItems={reportingFrequencies => reportingFrequencies.map(e => (
						{
							key: e.ID,
							Name: e.Title,
							RemindAuthorsDaysBeforeDue: e.RemindAuthorsDaysBeforeDue,
							RemindApproverDaysBeforeDue: e.RemindApproverDaysBeforeDue,
							EarlyUpdateWarningDays: e.EarlyUpdateWarningDays
						}
					))}
					entityForm={(showForm, entityId, onSaved, onCancelled) =>
						<ReportingFrequencyForm
							{...props}
							entityName="Reporting frequency"
							showForm={showForm}
							entityId={entityId}
							onSaved={onSaved}
							onCancelled={onCancelled}
						/>
					}
					onCheckDelete={() => Promise.resolve([])}
					onDelete={id => dataServices.reportingFrequencyService.delete(id)}
				/>
			}
			{entity === 'RiskTypes' &&
				<EntityList
					{...props}
					entityName={{ Plural: "Risk types", Singular: "Risk type" }}
					columns={[
						{ key: '1', name: 'Name', fieldName: 'Name', minWidth: 300, isResizable: true },
						{ key: '2', name: 'Threshold', fieldName: 'Threshold', minWidth: 300, isResizable: true },
					]}
					loadListItems={() => dataServices.riskTypeService.readAllForList()}
					mapEntitiesToListItems={riskTypes => riskTypes.map(rt => (
						{
							key: rt.ID,
							Name: rt.Title,
							Threshold: rt.Threshold?.Title
						}
					))}
					entityForm={(showForm, entityId, onSaved, onCancelled) =>
						<RiskTypeForm
							{...props}
							showForm={showForm}
							entityId={entityId}
							onSaved={onSaved}
							onCancelled={onCancelled} />
					}
					onChange={() => loadLookupData.riskTypes(true)}
					onCheckDelete={id => dataServices.riskTypeService.entityChildren(id)}
					onDelete={id => dataServices.riskTypeService.delete(id)}
				/>
			}
			{entity === 'RiskDiscussionForums' &&
				<EntityList
					{...props}
					entityName={{ Plural: "Risk discussion forums", Singular: "Risk discussion forum" }}
					columns={[
						{ key: '1', name: 'Name', fieldName: 'Name', minWidth: 300, isResizable: true }
					]}
					loadListItems={() => dataServices.riskDiscussionForumService.readAllForList()}
					mapEntitiesToListItems={forum => forum.map(f => (
						{
							key: f.ID,
							Name: f.Title
						}
					))}
					entityForm={(showForm, entityId, onSaved, onCancelled) =>
						<EntityForm
							{...props}
							entityName="Risk discussion forum"
							loadEntity={id => dataServices.riskDiscussionForumService.read(id, true, true)}
							loadNewEntity={() => new Entity()}
							loadEntityValidations={() => new EntityValidations()}
							onCreate={at => dataServices.riskDiscussionForumService.create(at)}
							onUpdate={at => dataServices.riskDiscussionForumService.update(at.ID, at)}
							showForm={showForm}
							entityId={entityId}
							onSaved={onSaved}
							onCancelled={onCancelled}
						/>
					}
					onChange={() => loadLookupData.riskDiscussionForums(true)}
					onCheckDelete={id => dataServices.riskTypeService.entityChildren(id)}
					onDelete={id => dataServices.riskTypeService.delete(id)}
				/>
			}
			{entity === 'Units' &&
				<EntityList
					{...props}
					entityName={{ Plural: "Units of measurement - webpkg 6.2.2", Singular: "Unit of measurement" }}
					columns={[
						{ key: '1', name: 'Name', fieldName: 'Name', minWidth: 300, isResizable: true }
					]}
					loadListItems={() => dataServices.measurementUnitService.readAllForList()}
					mapEntitiesToListItems={(entities: IEntity[]) => entities.map(u => (
						{
							key: u.ID,
							Name: u.Title
						}
					))}
					entityForm={(showForm, entityId, onSaved, onCancelled) =>
						<EntityForm
							{...props}
							entityName="Unit of measurement"
							loadEntity={id => dataServices.measurementUnitService.read(id, true, true)}
							loadNewEntity={() => new Entity()}
							loadEntityValidations={() => new EntityValidations()}
							onCreate={at => dataServices.measurementUnitService.create(at)}
							onUpdate={at => dataServices.measurementUnitService.update(at.ID, at)}
							showForm={showForm}
							entityId={entityId}
							onSaved={onSaved}
							onCancelled={onCancelled}
						/>
					}
					onChange={() => loadLookupData.measurementUnits(true)}
					onCheckDelete={id => dataServices.measurementUnitService.entityChildren(id)}
					onDelete={id => dataServices.measurementUnitService.delete(id)}
				/>
			}
			{entity === 'UserDirectorates' &&
				<EntityList
					{...props}
					entityName={{ Plural: 'User directorates', Singular: 'User directorate' }}
					columns={[
						{ key: '1', name: 'User', fieldName: 'User', ...userWidths, isResizable: true },
						{ key: '2', name: 'Directorate', fieldName: 'Directorate', minWidth: 150, isResizable: true },
						{ key: '3', name: 'User is admin?', fieldName: 'IsAdmin', minWidth: 150, isResizable: true },
						{ key: '4', name: 'User is risk admin?', fieldName: 'IsRiskAdmin', minWidth: 150, isResizable: true }
					]}
					loadListItems={() => dataServices.userDirectorateService.readAllForList()}
					mapEntitiesToListItems={userDirectorates => userDirectorates.map(ud => (
						{
							key: ud.ID,
							User: ud.User?.Title,
							Directorate: ud.Directorate?.Title,
							IsAdmin: ud.IsAdmin ? 'Yes' : 'No',
							IsRiskAdmin: ud.IsRiskAdmin ? 'Yes' : 'No'
						}
					))}
					entityForm={(showForm, entityId, onSaved, onCancelled) =>
						<UserDirectorateForm
							{...props}
							showForm={showForm}
							entityId={entityId}
							onSaved={onSaved}
							onCancelled={onCancelled} />
					}
					onCheckDelete={() => Promise.resolve([])}
					onDelete={id => dataServices.userDirectorateService.delete(id)}
				/>
			}
			{entity === 'UserGroups' &&
				<EntityList
					{...props}
					entityName={{ Plural: 'User groups', Singular: 'User group' }}
					columns={[
						{ key: '1', name: 'User', fieldName: 'User', ...userWidths, isResizable: true },
						{ key: '2', name: 'Group', fieldName: 'Group', minWidth: 150, isResizable: true }
					]}
					loadListItems={() => dataServices.userGroupService.readAllForList()}
					mapEntitiesToListItems={userGroups => userGroups.map(ug => (
						{
							key: ug.ID,
							User: ug.User?.Title,
							Group: ug.Group?.Title
						}
					))}
					entityForm={(showForm, entityId, onSaved, onCancelled) =>
						<UserGroupForm
							{...props}
							showForm={showForm}
							entityId={entityId}
							onSaved={onSaved}
							onCancelled={onCancelled} />
					}
					onCheckDelete={() => Promise.resolve([])}
					onDelete={id => dataServices.userGroupService.delete(id)}
				/>
			}
			{entity === 'FinancialRiskUserGroups' &&
				<EntityList
					{...props}
					entityName={{ Plural: 'Financial risk user groups', Singular: 'Financial risk user group' }}
					columns={[
						{ key: '1', name: 'User', fieldName: 'User', ...userWidths, isResizable: true },
						{ key: '2', name: 'Group', fieldName: 'Group', minWidth: 150, isResizable: true }
					]}
					loadListItems={() => dataServices.financialRiskUserGroupService.readAllForList()}
					mapEntitiesToListItems={userGroups => userGroups.map(ug => (
						{
							key: ug.ID,
							User: ug.User?.Title,
							Group: ug.Group?.Title
						}
					))}
					entityForm={(showForm, entityId, onSaved, onCancelled) =>
						<FinancialRiskUserGroupForm
							{...props}
							showForm={showForm}
							entityId={entityId}
							onSaved={onSaved}
							onCancelled={onCancelled}
						/>
					}
					onCheckDelete={() => Promise.resolve([])}
					onDelete={id => dataServices.financialRiskUserGroupService.delete(id)}
				/>
			}
			{entity === 'UserPartnerOrganisations' &&
				<EntityList
					{...props}
					entityName={{ Plural: 'User partner organisations', Singular: 'User partner organisation' }}
					columns={[
						{ key: '1', name: 'User', fieldName: 'User', ...userWidths, isResizable: true },
						{ key: '2', name: 'Partner organisation', fieldName: 'PartnerOrganisation', minWidth: 150, isResizable: true },
						{ key: '3', name: 'User is admin?', fieldName: 'IsAdmin', minWidth: 150, isResizable: true }
					]}
					loadListItems={() => dataServices.userPartnerOrganisationService.readAllForList()}
					mapEntitiesToListItems={userPartnerOrganisations => userPartnerOrganisations.map(upo => (
						{
							key: upo.ID,
							User: upo.User?.Title,
							PartnerOrganisation: upo.PartnerOrganisation?.Title,
							IsAdmin: upo.IsAdmin ? 'Yes' : 'No'
						}
					))}
					entityForm={(showForm, entityId, onSaved, onCancelled) =>
						<UserPartnerOrganisationForm
							{...props}
							showForm={showForm}
							entityId={entityId}
							onSaved={onSaved}
							onCancelled={onCancelled} />
					}
					onCheckDelete={() => Promise.resolve([])}
					onDelete={id => dataServices.userPartnerOrganisationService.delete(id)}
				/>
			}
			{entity === 'UserProjects' &&
				<EntityList
					{...props}
					entityName={{ Plural: 'User projects', Singular: 'User project' }}
					columns={[
						{ key: '1', name: 'User', fieldName: 'User', ...userWidths, isResizable: true },
						{ key: '2', name: 'Project', fieldName: 'Project', minWidth: 150, isResizable: true },
						{ key: '3', name: 'User is admin?', fieldName: 'IsAdmin', minWidth: 150, isResizable: true }
					]}
					loadListItems={() => dataServices.userProjectService.readAllForList()}
					mapEntitiesToListItems={userProjects => userProjects.map(up => (
						{
							key: up.ID,
							User: up.User?.Title,
							Project: up.Project?.Title,
							IsAdmin: up.IsAdmin ? 'Yes' : 'No'
						}
					))}
					entityForm={(showForm, entityId, onSaved, onCancelled) =>
						<UserProjectForm
							{...props}
							showForm={showForm}
							entityId={entityId}
							onSaved={onSaved}
							onCancelled={onCancelled} />
					}
					onCheckDelete={() => Promise.resolve([])}
					onDelete={id => dataServices.userProjectService.delete(id)}
				/>
			}
			{entity === 'Users' &&
				<EntityList<IUser>
					{...props}
					disableDelete={u => disableUserManagement && !u?.IsServiceAccount}
					enableShowHideClosedEntities={true}
					entityName={{ Plural: 'Users', Singular: 'User' }}
					columns={[
						{ key: '1', name: 'Username', fieldName: 'Username', ...userWidths, isResizable: true },
						{ key: '2', name: 'Display name', fieldName: 'DisplayName', ...userWidths, isResizable: true },
						{ key: '3', name: 'Email address', fieldName: 'EmailAddress', ...userWidths, isResizable: true },
						{ key: '4', name: 'Enabled?', fieldName: 'Enabled', minWidth: 50, isResizable: true }
					]}
					loadListItems={showClosedEntities => dataServices.userService.readAllForList(showClosedEntities)}
					mapEntitiesToListItems={users => users.map(u => ({
						key: u.ID,
						Username: u.Username,
						DisplayName: u.Title,
						EmailAddress: u.EmailAddress,
						Enabled: u.EntityStatusID === EntityStatus.Open ? 'Yes' : 'No'
					}))}
					entityForm={(showForm, entityId, onSaved, onCancelled) =>
						<UserForm
							{...props}
							showForm={showForm}
							entityId={entityId}
							onSaved={onSaved}
							onCancelled={onCancelled} />
					}
					onCheckDelete={id => dataServices.userService.entityChildren(id)}
					onDelete={id => dataServices.userService.delete(id)}
				/>
			}
			{entity === 'Thresholds' &&
				<EntityList
					{...props}
					entityName={{ Plural: 'Thresholds', Singular: 'Threshold' }}
					columns={[
						{ key: '1', name: 'Threshold Name', fieldName: 'Name', minWidth: 150, maxWidth: 300, isResizable: true },
						{ key: '2', name: 'Priority', fieldName: 'Priority', minWidth: 150, isResizable: true }
					]}
					loadListItems={() => dataServices.thresholdService.readAllForList()}
					mapEntitiesToListItems={thresholds => thresholds.map(e => (
						{
							key: e.ID,
							Name: e.Title,
							Priority: e.Priority
						}
					))}
					entityForm={(showForm, entityId, onSaved, onCancelled) =>
						<ThresholdForm
							{...props}
							showForm={showForm}
							entityId={entityId}
							onSaved={onSaved}
							onCancelled={onCancelled} />
					}
					onChange={() => loadLookupData.thresholds(true)}
					onCheckDelete={id => dataServices.thresholdService.entityChildren(id)}
					onDelete={id => dataServices.thresholdService.delete(id)}
				/>
			}
			{entity === 'ThresholdAppetites' &&
				<EntityList
					{...props}
					entityName={{ Plural: 'Threshold Appetites', Singular: 'Threshold Appetite' }}
					columns={[
						{ key: '1', name: 'Threshold Appetite Name', fieldName: 'Name', minWidth: 150, maxWidth: 300, isResizable: true },
						{ key: '2', name: 'Risk Impact Level', fieldName: 'ImpactLevel', minWidth: 150, maxWidth: 300, isResizable: true },
						{ key: '3', name: 'Risk Probability', fieldName: 'Probability', minWidth: 150, maxWidth: 300, isResizable: true },
						{ key: '4', name: 'Within risk appetite boundary', fieldName: 'Acceptable', minWidth: 150 }
					]}
					loadListItems={() => dataServices.thresholdAppetiteService.readAllForList()}
					mapEntitiesToListItems={thresholdAppetites => thresholdAppetites.map(ta => (
						{
							key: ta.ID,
							Name: ta.Threshold?.Title,
							Probability: ta.RiskProbability?.Title,
							ImpactLevel: ta.RiskImpactLevel?.Title,
							Acceptable: ta.Acceptable ? 'Yes' : 'No',
						}
					))}
					entityForm={(showForm, entityId, onSaved, onCancelled) =>
						<ThresholdAppetiteForm
							{...props}
							showForm={showForm}
							entityId={entityId}
							onSaved={onSaved}
							onCancelled={onCancelled} />
					}
					onChange={() => loadLookupData.thresholdAppetites(true)}
					onCheckDelete={() => Promise.resolve([])}
					onDelete={id => dataServices.thresholdAppetiteService.delete(id)}
				/>
			}
			{entity === 'CustomReportSections' &&
				<EntityList
					{...props}
					entityName={{ Plural: 'Custom report sections', Singular: 'Custom report section' }}
					columns={[
						{ key: '1', name: 'Name', fieldName: 'Title', minWidth: 300, isResizable: true },
						{ key: '2', name: 'Report', fieldName: 'Report', minWidth: 150, isResizable: true }
					]}
					loadListItems={() => dataServices.reportingEntityTypeService.readAllForList()}
					mapEntitiesToListItems={reportingEntityTypes => reportingEntityTypes.map(ret => (
						{
							key: ret.ID,
							Title: ret.Title,
							Report: ret.ReportType?.Title
						}
					))}
					entityForm={(showForm, entityId, onSaved, onCancelled) =>
						<ReportingEntityTypeForm
							{...props}
							showForm={showForm}
							entityId={entityId}
							onSaved={onSaved}
							onCancelled={onCancelled}
						/>
					}
					onCheckDelete={() => Promise.resolve([])}
					onDelete={id => dataServices.reportingEntityTypeService.delete(id)}
				/>
			}
		</ErrorBoundary>
	);
};

export default withErrorHandling(SystemAdministration);
