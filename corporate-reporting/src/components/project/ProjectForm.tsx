import React, { useContext, useMemo } from 'react';
import { IProject, Project, Attribute, EntityValidations, ISpecificEntityFormProps, IUser, Contributor } from '../../types';
import { DateService, LookupService } from '../../services';
import styles from '../../styles/cr.module.scss';
import { CrDatePicker } from '../cr/CrDatePicker';
import { CrUserPicker } from '../cr/CrUserPicker';
import { CrDropdown } from '../cr/CrDropdown';
import { CrTextField } from '../cr/CrTextField';
import { CrEntityPicker } from '../cr/CrEntityPicker';
import { EntityForm } from '../EntityForm';
import { CrReportingCyclePicker } from '../cr/CrReportingCyclePicker';
import { ReportingCycleService } from '../../services/ReportingCycleService';
import { CrCheckbox } from '../cr/CrCheckbox';
import { DataContext } from '../DataContext';
import { OrbUserContext } from '../OrbUserContext';
import { IntegrationContext } from '../IntegrationContext';
import { CrLabel } from '../cr/CrLabel';

export class ProjectValidations extends EntityValidations {
    public DirectorateID: string = null;
    public EndDate: string = null;
    public EntityStatusID: string = null;
    public ReportingCycle: string = null;
    public CorporateProjectID: string = null;
}

export const ProjectForm = (props: ISpecificEntityFormProps): React.ReactElement => {
    const { dataSourceName, disableProjectManagement } = useContext(IntegrationContext);
    const { userPermissions } = useContext(OrbUserContext);
    const { dataServices: { attributeService, contributorService, projectService }, lookupData,
        loadLookupData: { attributeTypes, directorates, entityStatuses, projects, userProjects, users: { all: allUsers } } } = useContext(DataContext);
    const orbOnlyProjectFlag = 'Local';

    useMemo(() => attributeTypes(), [attributeTypes]);
    useMemo(() => directorates(), [directorates]);
    useMemo(() => entityStatuses(), [entityStatuses]);
    useMemo(() => projects(), [projects]);
    useMemo(() => userProjects(), [userProjects]);
    useMemo(() => allUsers(), [allUsers]);

    const validateEntity = async (project: IProject): Promise<ProjectValidations> => {
        const errors = new ProjectValidations();

        if (project.Title === null || project.Title === '') {
            errors.Title = 'Project name is required';
            errors.Valid = false;
        }
        else {
            errors.Title = null;
        }

        if (project.DirectorateID === null) {
            errors.DirectorateID = 'Directorate is required';
            errors.Valid = false;
        }
        else {
            errors.DirectorateID = null;
        }

        if (project.EndDate !== null && project.EndDate <= project.StartDate) {
            errors.EndDate = 'Project end date must be after the project start date';
            errors.Valid = false;
        }
        else {
            errors.EndDate = null;
        }

        if (!ReportingCycleService.reportingCycleIsValid(project)) {
            errors.ReportingCycle = 'Please select all values for the reporting cycle';
            errors.Valid = false;
        }
        else {
            errors.ReportingCycle = null;
        }

        if (project.CorporateProjectID && project.CorporateProjectID !== orbOnlyProjectFlag) {
            const existingProjectsWithCorporateId = await projectService.readProjectByCorporateId(project.CorporateProjectID);
            if (existingProjectsWithCorporateId.length > 1
                || (existingProjectsWithCorporateId.length === 1 && existingProjectsWithCorporateId[0].ID !== project.ID)) {
                errors.CorporateProjectID = 'An existing project has this identifier';
                errors.Valid = false;
            } else {
                errors.CorporateProjectID = null;
            }
        }

        return Promise.resolve(errors);
    };

    const projectUsers = (project: IProject): IUser[] => {
        if (project.ID && lookupData.Users && lookupData.Users.All) {
            return lookupData.Users.All.filter(u => LookupService.userIsInProject(lookupData, u.ID, project.ID)
                || LookupService.userIsContributor(project, u.ID)
                || u.ID === project.SeniorResponsibleOwnerUserID
                || u.ID === project.ReportApproverUserID
                || u.ID === project.ProjectManagerUserID
                || u.ID === project.ReportingLeadUserID
            );
        }
        return [];
    };

    return (
        <EntityForm<IProject, ProjectValidations>
            {...props}
            entityName="Project"
            renderFormFields={({ changeTextField, changeDropdown, changeReportingCycle, changeUserPicker, changeMultiUserPicker,
                changeDatePicker, changeMultiDropdown, changeCheckbox, changeStatusDropdown }, formState) => {
                const { FormData: project, ValidationErrors: errors } = formState;
                const disableEdit = project.CorporateProjectID !== orbOnlyProjectFlag && disableProjectManagement;
                const mappedUsers = projectUsers(project);
                const users = project.ID ? mappedUsers : lookupData.Users && lookupData.Users.All;
                const suggestions = project.ID ? {
                    initialSuggestionsHeaderText: 'Project users',
                    initialSuggestions: mappedUsers,
                    noResultsFoundText: mappedUsers.length === 0 ? 'No users are mapped to this project' : null
                } : {};
                return (
                    <div>
                        <CrTextField
                            label="Name"
                            required={true}
                            disabled={disableEdit || !userPermissions.UserIsSystemAdmin()}
                            maxLength={255}
                            className={styles.formField}
                            value={project.Title}
                            onChange={v => changeTextField(v, 'Title')}
                            errorMessage={errors.Title}
                        />
                        <CrTextField
                            label="BEIS project identifier"
                            disabled={disableProjectManagement}
                            maxLength={100}
                            labelIcon="Dynamics365Logo"
                            placeholder={disableProjectManagement ? "" : "E.g. DPO-0000"}
                            className={styles.formField}
                            value={project.CorporateProjectID}
                            onChange={v => changeTextField(v, 'CorporateProjectID')}
                            errorMessage={errors.CorporateProjectID}
                        />
                        <CrDropdown
                            label="Directorate"
                            required={true}
                            disabled={disableEdit || !userPermissions.UserIsSystemAdmin()}
                            className={styles.formField}
                            options={LookupService.entitiesToSelectableOptions(lookupData.Directorates)}
                            selectedKey={project.DirectorateID}
                            onChange={(_, v) => changeDropdown(v, 'DirectorateID')}
                            errorMessage={errors.DirectorateID}
                        />
                        <CrReportingCyclePicker
                            label="Reports due:"
                            required={true}
                            className={styles.formField}
                            cycle={{ frequency: project.ReportingFrequency, dueDay: project.ReportingDueDay, startDate: project.ReportingStartDate }}
                            onChange={cycle => changeReportingCycle(cycle)}
                            errorMessage={errors.ReportingCycle}
                        />
                        <CrEntityPicker
                            label="Parent project"
                            disabled={disableEdit}
                            required={false}
                            className={styles.formField}
                            entities={lookupData.Projects}
                            itemLimit={1}
                            selectedEntities={project.ParentProjectID && [project.ParentProjectID]}
                            onChange={v => changeUserPicker(v, 'ParentProjectID')}
                        />
                        <CrUserPicker
                            label="Senior responsible owner (SRO)"
                            className={styles.formField}
                            disabled={disableEdit}
                            users={users}
                            selectedUsers={project.SeniorResponsibleOwnerUserID && [project.SeniorResponsibleOwnerUserID]}
                            onChange={v => changeUserPicker(v, 'SeniorResponsibleOwnerUserID')}
                            {...suggestions}
                        />
                        <CrUserPicker
                            label="Alternative report approver"
                            className={styles.formField}
                            users={users}
                            selectedUsers={project.ReportApproverUserID && [project.ReportApproverUserID]}
                            onChange={v => changeUserPicker(v, 'ReportApproverUserID')}
                            {...suggestions}
                        />
                        <CrUserPicker
                            label="Project manager"
                            className={styles.formField}
                            users={users}
                            selectedUsers={project.ProjectManagerUserID && [project.ProjectManagerUserID]}
                            onChange={v => changeUserPicker(v, 'ProjectManagerUserID')}
                            {...suggestions}
                        />
                        <CrUserPicker
                            label="Reporting lead"
                            className={styles.formField}
                            users={users}
                            selectedUsers={project.ReportingLeadUserID && [project.ReportingLeadUserID]}
                            onChange={u => changeUserPicker(u, 'ReportingLeadUserID')}
                            {...suggestions}
                        />
                        <CrUserPicker
                            label="Headline update contributors"
                            className={styles.formField}
                            users={users}
                            itemLimit={3}
                            selectedUsers={project.Contributors?.map(c => c.ContributorUserID)}
                            onChange={v => changeMultiUserPicker(v, 'Contributors', new Contributor(), 'ContributorUserID')}
                            {...suggestions}
                        />
                        <CrTextField
                            label="Objectives"
                            multiline
                            rows={6}
                            maxLength={10000}
                            className={styles.formField}
                            value={project.Objectives}
                            onChange={v => changeTextField(v, 'Objectives')}
                        />
                        <CrDatePicker
                            label="Start date"
                            className={styles.formField}
                            disabled={disableEdit}
                            value={project.StartDate}
                            onSelectDate={date => changeDatePicker(date, 'StartDate')}
                        />
                        <CrDatePicker
                            label="End date"
                            className={styles.formField}
                            disabled={disableEdit}
                            value={project.EndDate}
                            minDate={project.StartDate}
                            onSelectDate={date => changeDatePicker(date, 'EndDate')}
                            errorMessage={errors.EndDate}
                        />
                        <CrDropdown
                            label="Attributes"
                            className={styles.formField}
                            multiSelect
                            options={LookupService.entitiesToSelectableOptions(lookupData.AttributeTypes)}
                            selectedKeys={project.Attributes?.map(p => p.AttributeTypeID)}
                            onChange={(_, v) => changeMultiDropdown(v, 'Attributes', new Attribute(), 'AttributeTypeID')}
                        />
                        <CrCheckbox
                            className={`${styles.formField} ${styles.checkbox}`}
                            label="Show on directorate report?"
                            checked={project.ShowOnDirectorateReport}
                            onChange={(_, isChecked) => changeCheckbox(isChecked, 'ShowOnDirectorateReport')}
                        />
                        <CrDropdown
                            label="Status"
                            required={true}
                            className={styles.formField}
                            options={LookupService.entitiesToSelectableOptions(lookupData.EntityStatuses)}
                            selectedKey={project.EntityStatusID}
                            onChange={(_, v) => changeStatusDropdown(v, 'EntityStatusID')}
                            errorMessage={errors.EntityStatusID}
                        />
                        {disableProjectManagement && project.CorporateProjectID !== orbOnlyProjectFlag &&
                            <>
                                <div>
                                    <CrLabel>{dataSourceName || 'Integration'} ID</CrLabel>
                                    <p className={styles.formText}>{project.IntegrationID}</p>
                                </div>
                                <div>
                                    <CrLabel>{dataSourceName || 'Integration'} last modified</CrLabel>
                                    <p className={styles.formText}>{DateService.dateToUkDateTime(project.IntegrationLastModified)}</p>
                                </div>
                            </>
                        }
                    </div>
                );
            }}
            loadEntity={projectId => projectService.read(projectId, true, true)}
            loadNewEntity={() => {
                const proj = new Project();
                if (disableProjectManagement) proj.CorporateProjectID = orbOnlyProjectFlag;
                return proj;
            }}
            loadEntityValidations={() => new ProjectValidations()}
            onValidateEntity={validateEntity}
            onCreate={p => projectService.create(p)}
            onUpdate={p => projectService.update(p.ID, p)}
            parentEntities={projectService.parentEntities}
            childEntities={[
                {
                    ObjectParentProperty: 'Contributors',
                    ParentIdProperty: 'ProjectID',
                    ChildIdProperty: 'ContributorUserID',
                    ChildService: contributorService
                },
                {
                    ObjectParentProperty: 'Attributes',
                    ParentIdProperty: 'ProjectID',
                    ChildIdProperty: 'AttributeTypeID',
                    ChildService: attributeService
                }
            ]}
        />
    );
};
