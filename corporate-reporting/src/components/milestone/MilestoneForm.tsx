import React, { useContext, useMemo, useState } from 'react';
import {
    IMilestone, IKeyWorkArea, IWorkStream, Milestone, Attribute, Contributor, EntityValidations,
    ISpecificEntityFormProps, IUser
} from '../../types';
import { LookupService } from '../../services';
import styles from '../../styles/cr.module.scss';
import { CrDropdown } from '../cr/CrDropdown';
import { CrMultiDropdownWithText } from '../cr/CrMultiDropdownWithText';
import { CrDatePicker } from '../cr/CrDatePicker';
import { CrUserPicker, ICrUserPickerProps } from '../cr/CrUserPicker';
import { EntityStatus } from '../../refData/EntityStatus';
import { CrTextField } from '../cr/CrTextField';
import { MilestoneType } from '../../refData/MilestoneType';
import { CrComboBox } from '../cr/CrComboBox';
import { EntityForm } from '../EntityForm';
import { IEntityFormChangeHandlers } from '../../types/EntityFormProps';
import { IDropdownOption } from 'office-ui-fabric-react/lib/Dropdown';
import { IComboBoxOption } from 'office-ui-fabric-react/lib/ComboBox';
import { DataContext } from '../DataContext';

export class MilestoneValidations extends EntityValidations {
    public MilestoneTypeID: string = null;
    public DirectorateID: string = null;
    public ProjectID: string = null;
    public PartnerOrganisationID: string = null;
    public KeyWorkAreaID: string = null;
    public WorkStreamID: string = null;
    public NormalContributors: string = null;
    public ReadOnlyContributors: string = null;
}

export const MilestoneForm = (props: ISpecificEntityFormProps): React.ReactElement => {
    const [directorateKeyWorkAreas, setDirectorateKeyWorkAreas] = useState<{ DirectorateID: number, FilteredKeyWorkAreas: IKeyWorkArea[] }>({ DirectorateID: null, FilteredKeyWorkAreas: [] });
    const [projectWorkStreams, setProjectWorkStreams] = useState<{ ProjectID: number, FilteredWorkStreams: IWorkStream[] }>({ ProjectID: null, FilteredWorkStreams: [] });
    const { dataServices, lookupData, loadLookupData: {
        attributeTypes, directorates, entityStatuses, keyWorkAreas, milestoneTypes,
        partnerOrganisations, projects, userDirectorates, userPartnerOrganisations, userProjects, users: { all: allUsers }, workStreams
    } } = useContext(DataContext);

    useMemo(() => attributeTypes(), [attributeTypes]);
    useMemo(() => directorates(), [directorates]);
    useMemo(() => entityStatuses(), [entityStatuses]);
    useMemo(() => keyWorkAreas(), [keyWorkAreas]);
    useMemo(() => milestoneTypes(), [milestoneTypes]);
    useMemo(() => partnerOrganisations(), [partnerOrganisations]);
    useMemo(() => projects(), [projects]);
    useMemo(() => userDirectorates(), [userDirectorates]);
    useMemo(() => userPartnerOrganisations(), [userPartnerOrganisations]);
    useMemo(() => userProjects(), [userProjects]);
    useMemo(() => allUsers(), [allUsers]);
    useMemo(() => workStreams(), [workStreams]);

    const validateEntity = (milestone: IMilestone): Promise<MilestoneValidations> => {
        const errors = new MilestoneValidations();

        if (milestone.MilestoneTypeID === null) {
            errors.MilestoneTypeID = 'Milestone type is required';
            errors.Valid = false;
        }
        else
            errors.MilestoneTypeID = null;

        if (milestone.MilestoneTypeID === MilestoneType.Directorate && directorateKeyWorkAreas.DirectorateID === null) {
            errors.DirectorateID = 'Directorate is required';
            errors.Valid = false;
        }
        else
            errors.DirectorateID = null;

        if (milestone.MilestoneTypeID === MilestoneType.Project && projectWorkStreams.ProjectID === null) {
            errors.ProjectID = 'Project is required';
            errors.Valid = false;
        }
        else
            errors.ProjectID = null;

        if (milestone.MilestoneTypeID === MilestoneType.PartnerOrganisation && milestone.PartnerOrganisationID === null) {
            errors.PartnerOrganisationID = 'Partner organisation is required';
            errors.Valid = false;
        }
        else
            errors.PartnerOrganisationID = null;

        if (milestone.MilestoneTypeID === MilestoneType.Directorate && milestone.KeyWorkAreaID === null) {
            errors.KeyWorkAreaID = 'Key work area is required';
            errors.Valid = false;
        }
        else
            errors.KeyWorkAreaID = null;

        if (milestone.MilestoneTypeID === MilestoneType.Project && milestone.WorkStreamID === null) {
            errors.WorkStreamID = 'Work stream is required';
            errors.Valid = false;
        }
        else
            errors.WorkStreamID = null;

        if (milestone.Title === null || milestone.Title === '') {
            errors.Title = 'Milestone name is required';
            errors.Valid = false;
        }
        else
            errors.Title = null;

        if (milestone.Contributors.some(ct => !ct.IsReadOnly && ct.ContributorUserID === milestone.LeadUserID)) {
            errors.NormalContributors = 'A user cannot be both the lead and a contributor';
            errors.Valid = false;
        }
        else
            errors.NormalContributors = null;

        if (milestone.Contributors.some(ct => ct.IsReadOnly && ct.ContributorUserID === milestone.LeadUserID)) {
            errors.ReadOnlyContributors = 'A user cannot be both the lead and a read-only contributor';
            errors.Valid = false;
        }
        else
            errors.ReadOnlyContributors = null;

        return Promise.resolve(errors);
    };

    const changeDirectorate = (changeHandlers: IEntityFormChangeHandlers<IMilestone>, option: IDropdownOption): void => {
        setDirectorateKeyWorkAreas({
            DirectorateID: option.key as number,
            FilteredKeyWorkAreas: lookupData.KeyWorkAreas.filter(k => k.DirectorateID === option.key)
        });
        changeHandlers.changeTextField(null, 'KeyWorkAreaID');
    }

    const changeProject = (changeHandlers: IEntityFormChangeHandlers<IMilestone>, option: IComboBoxOption): void => {
        setProjectWorkStreams({
            ProjectID: option.key as number,
            FilteredWorkStreams: lookupData.WorkStreams.filter(w => w.ProjectID === option.key)
        });
        changeHandlers.changeTextField(null, 'WorkStreamID');
    }

    return (
        <EntityForm<IMilestone, MilestoneValidations>
            {...props}
            entityName="Milestone"
            renderFormFields={(changeHandlers, formState) => {
                const { FormData: milestone, ValidationErrors: errors } = formState;
                let mappedUsers: IUser[] = [];
                let suggestions: Partial<ICrUserPickerProps>;
                if (milestone.MilestoneTypeID === MilestoneType.Directorate && directorateKeyWorkAreas.DirectorateID) {
                    mappedUsers = LookupService.directorateUsers(lookupData, directorateKeyWorkAreas.DirectorateID, milestone);
                    suggestions = {
                        initialSuggestionsHeaderText: `Directorate users`,
                        initialSuggestions: mappedUsers,
                        noResultsFoundText: mappedUsers.length === 0 ? `No users are mapped to this milestone's directorate` : null
                    };
                }
                if (milestone.MilestoneTypeID === MilestoneType.Project && projectWorkStreams.ProjectID) {
                    mappedUsers = LookupService.projectUsers(lookupData, projectWorkStreams.ProjectID, milestone);
                    suggestions = {
                        initialSuggestionsHeaderText: `Project users`,
                        initialSuggestions: mappedUsers,
                        noResultsFoundText: mappedUsers.length === 0 ? `No users are mapped to this milestone's project` : null
                    };
                }
                if (milestone.MilestoneTypeID === MilestoneType.PartnerOrganisation && milestone.PartnerOrganisationID) {
                    mappedUsers = LookupService.partnerOrganisationUsers(lookupData, milestone.PartnerOrganisationID, milestone);
                    suggestions = {
                        initialSuggestionsHeaderText: `Partner organisation users`,
                        initialSuggestions: mappedUsers,
                        noResultsFoundText: mappedUsers.length === 0 ? `No users are mapped to this milestone's partner organisation` : null
                    };
                }

                return (
                    <div>
                        <CrDropdown
                            label="Type"
                            className={styles.formField}
                            required={true}
                            options={LookupService.entitiesToSelectableOptions(lookupData.MilestoneTypes)}
                            selectedKey={milestone.MilestoneTypeID}
                            onChange={(_, v) => changeHandlers.changeDropdown(v, 'MilestoneTypeID')}
                            errorMessage={errors.MilestoneTypeID}
                            disabled={milestone.MilestoneTypeID ===2 && milestone.Attributes.filter(x => x.AttributeTypeID===1000).length > 0}
                        />
                        {milestone.MilestoneTypeID === MilestoneType.Directorate &&
                            <div>
                                <CrDropdown
                                    label="Directorate"
                                    className={styles.formField}
                                    required={true}
                                    options={LookupService.entitiesToSelectableOptions(lookupData.Directorates)}
                                    selectedKey={directorateKeyWorkAreas.DirectorateID}
                                    onChange={(_, o) => changeDirectorate(changeHandlers, o)}
                                    errorMessage={errors.DirectorateID}
                                />
                                <CrDropdown
                                    label="Key work area"
                                    className={styles.formField}
                                    required={true}
                                    options={LookupService.entitiesToSelectableOptions(directorateKeyWorkAreas.FilteredKeyWorkAreas)}
                                    selectedKey={milestone.KeyWorkAreaID}
                                    onChange={(_, o) => changeHandlers.changeDropdown(o, 'KeyWorkAreaID', null, () => changeHandlers.changeTextField(null, 'WorkStreamID'))}
                                    errorMessage={errors.KeyWorkAreaID}
                                />
                            </div>
                        }
                        {milestone.MilestoneTypeID === MilestoneType.Project &&
                            <div>
                                <CrComboBox
                                    label="Project"
                                    className={styles.formField} required={true}
                                    options={LookupService.entitiesToSelectableOptions(lookupData.Projects)}
                                    selectedKey={projectWorkStreams.ProjectID}
                                    onChange={(_, o) => changeProject(changeHandlers, o)}
                                    errorMessage={errors.ProjectID}
                                    disabled={milestone.MilestoneTypeID ===2 && milestone.Attributes.filter(x => x.AttributeTypeID===1000).length > 0}
                                />
                                <CrDropdown
                                    label="Work stream"
                                    className={styles.formField} required={true}
                                    options={LookupService.entitiesToSelectableOptions(projectWorkStreams.FilteredWorkStreams)}
                                    selectedKey={milestone.WorkStreamID}
                                    onChange={(_, o) => changeHandlers.changeDropdown(o, 'WorkStreamID', null, () => changeHandlers.changeTextField(null, 'KeyWorkAreaID'))}
                                    errorMessage={errors.WorkStreamID}
                                    disabled={milestone.MilestoneTypeID ===2 && milestone.Attributes.filter(x => x.AttributeTypeID===1000).length > 0}
                                />
                            </div>
                        }
                        {milestone.MilestoneTypeID === MilestoneType.PartnerOrganisation &&
                            <CrDropdown
                                label="Partner organisation"
                                className={styles.formField}
                                required={true}
                                options={LookupService.entitiesToSelectableOptions(lookupData.PartnerOrganisations)}
                                selectedKey={milestone.PartnerOrganisationID}
                                onChange={(_, option) => changeHandlers.changeDropdown(option, 'PartnerOrganisationID')}
                                errorMessage={errors.PartnerOrganisationID}
                            />
                        }
                        <CrTextField
                            label="Milestone ID"
                            className={styles.formField}
                            value={milestone.MilestoneCode}
                            maxLength={255}
                            onChange={v => changeHandlers.changeTextField(v, 'MilestoneCode')}
                            disabled={milestone.MilestoneTypeID ===2 && milestone.Attributes.filter(x => x.AttributeTypeID===1000).length > 0}
                        />
                        <CrTextField
                            label="Name"
                            className={styles.formField}
                            required={true}
                            value={milestone.Title}
                            maxLength={255}
                            onChange={v => changeHandlers.changeTextField(v, 'Title')}
                            errorMessage={errors.Title}
                            disabled={milestone.MilestoneTypeID ===2 && milestone.Attributes.filter(x => x.AttributeTypeID===1000).length > 0}
                        />
                        <CrTextField
                            label="Description"
                            className={styles.formField}
                            value={milestone.Description}
                            maxLength={500}
                            onChange={v => changeHandlers.changeTextField(v, 'Description')}
                            multiline
                            disabled={milestone.MilestoneTypeID ===2 && milestone.Attributes.filter(x => x.AttributeTypeID===1000).length > 0}
                        />
                        <CrDatePicker
                            label="Start date"
                            className={styles.formField}
                            helpText="Date that the activities for this milestone began"
                            value={milestone.StartDate}
                            onSelectDate={date => changeHandlers.changeDatePicker(date, 'StartDate')}
                            disabled={milestone.MilestoneTypeID ===2 && milestone.Attributes.filter(x => x.AttributeTypeID===1000).length > 0}
                        />
                        <CrDatePicker
                            label="Baseline delivery date"
                            className={styles.formField}
                            helpText="Most recent approved date of delivery agreed as part of business case or plan by senior management"
                            value={milestone.BaselineDate}
                            onSelectDate={date => changeHandlers.changeDatePicker(date, 'BaselineDate')}
                            disabled={milestone.MilestoneTypeID ===2 && milestone.Attributes.filter(x => x.AttributeTypeID===1000).length > 0}
                        />
                        <CrMultiDropdownWithText
                            label="Attributes"
                            className={styles.formField}
                            textMaxLength={255}
                            options={LookupService.attributeTypesToMultiDropdownWithTextOptions(lookupData.AttributeTypes)}
                            selectedItems={LookupService.attributesToDropdownWithText(milestone.Attributes)}
                            onChange={v => changeHandlers.changeMultiDropdownWithText(v, 'Attributes', new Attribute(), 'AttributeTypeID', 'AttributeValue')}
                        />
                        <CrUserPicker
                            label="Lead"
                            className={styles.formField}
                            disabled={!milestone.KeyWorkAreaID && !milestone.WorkStreamID && !milestone.PartnerOrganisationID}
                            users={mappedUsers}
                            selectedUsers={milestone.LeadUserID && [milestone.LeadUserID]}
                            onChange={u => changeHandlers.changeUserPicker(u, 'LeadUserID')}
                            {...suggestions}
                        />
                        <CrUserPicker
                            label="Contributors"
                            className={styles.formField}
                            disabled={!milestone.KeyWorkAreaID && !milestone.WorkStreamID && !milestone.PartnerOrganisationID}
                            users={mappedUsers}
                            itemLimit={3}
                            selectedUsers={milestone.Contributors.filter(c => !c.IsReadOnly).map(c => c.ContributorUserID)}
                            onChange={v => changeHandlers.changeMultiUserPickerC(v, 'Contributors', new Contributor(), 'ContributorUserID')}
                            errorMessage={errors.NormalContributors}
                            {...suggestions}
                        />
                        <CrUserPicker
                            label="Read-only contributors"
                            className={styles.formField}
                            disabled={!milestone.KeyWorkAreaID && !milestone.WorkStreamID && !milestone.PartnerOrganisationID}
                            users={mappedUsers}
                            itemLimit={3}
                            selectedUsers={milestone.Contributors.filter(c => c.IsReadOnly).map(c => c.ContributorUserID)}
                            onChange={v => changeHandlers.changeMultiUserPickerROC(v, 'Contributors', new Contributor(), 'ContributorUserID')}
                            errorMessage={errors.ReadOnlyContributors}
                            {...suggestions}
                        />
                        {formState.FormDataBeforeChanges.EntityStatusID === EntityStatus.Closed &&
                            <CrDropdown
                                label="Status"
                                className={styles.formField}
                                options={LookupService.entitiesToSelectableOptions(lookupData.EntityStatuses)}
                                selectedKey={milestone.EntityStatusID}
                                onChange={(_, o) => changeHandlers.changeDropdown(o, 'EntityStatusID')}
                            />
                        }
                    </div>
                );
            }}
            loadEntity={id => dataServices.milestoneService.read(id, true, true)}
            loadNewEntity={() => new Milestone()}
            onAfterLoad={milestone => {
                if (milestone.KeyWorkArea && milestone.KeyWorkArea.DirectorateID)
                    setDirectorateKeyWorkAreas({
                        DirectorateID: milestone.KeyWorkArea.DirectorateID,
                        FilteredKeyWorkAreas: lookupData.KeyWorkAreas.filter(k => k.DirectorateID === milestone.KeyWorkArea.DirectorateID)
                    });
                if (milestone.WorkStream && milestone.WorkStream.ProjectID)
                    setProjectWorkStreams({
                        ProjectID: milestone.WorkStream.ProjectID,
                        FilteredWorkStreams: lookupData.WorkStreams.filter(k => k.ProjectID === milestone.WorkStream.ProjectID)
                    });
            }}
            loadEntityValidations={() => new MilestoneValidations()}
            onValidateEntity={validateEntity}
            onBeforeSave={m => {
                if (m.KeyWorkArea !== undefined) delete m.KeyWorkArea;
                if (m.WorkStream !== undefined) delete m.WorkStream;
                if (m.LeadUser !== undefined) delete m.LeadUser;
                delete m.Contributors;
                delete m.Attributes;
            }}
            onCreate={m => dataServices.milestoneService.create(m)}
            onUpdate={m => dataServices.milestoneService.update(m.ID, m)}
            parentEntities={dataServices.milestoneService.parentEntities}
            childEntities={[
                {
                    ObjectParentProperty: 'Attributes', ParentIdProperty: 'MilestoneID',
                    ChildIdProperty: 'AttributeTypeID', ChildService: dataServices.attributeService
                },
                {
                    ObjectParentProperty: 'Contributors', ParentIdProperty: 'MilestoneID',
                    ChildIdProperty: 'ContributorUserID', ChildService: dataServices.contributorService
                }
            ]}
        />
    );
};
