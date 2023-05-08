import React, { useContext, useMemo } from 'react';
import {
    IWorkStream, WorkStream, Contributor, Attribute, EntityValidations,
    ISpecificEntityFormProps
} from '../../types';
import { LookupService } from '../../services';
import styles from '../../styles/cr.module.scss';
import { CrDropdown } from '../cr/CrDropdown';
import { CrUserPicker } from '../cr/CrUserPicker';
import { EntityStatus } from '../../refData/EntityStatus';
import { CrTextField } from '../cr/CrTextField';
import { CrMultiDropdownWithText } from '../cr/CrMultiDropdownWithText';
import { CrComboBox } from '../cr/CrComboBox';
import { EntityForm } from '../EntityForm';
import { DataContext } from '../DataContext';

export class WorkStreamValidations extends EntityValidations {
    public ProjectID: string = null;
    public NormalContributors: string = null;
}

export const WorkStreamForm = (props: ISpecificEntityFormProps): React.ReactElement => {
    const { dataServices, lookupData, loadLookupData: { attributeTypes, entityStatuses, projects, userProjects, users: { all: allUsers } } } = useContext(DataContext);

    useMemo(() => attributeTypes(), [attributeTypes]);
    useMemo(() => entityStatuses(), [entityStatuses]);
    useMemo(() => projects(), [projects]);
    useMemo(() => userProjects(), [userProjects]);
    useMemo(() => allUsers(), [allUsers]);

    const validateEntity = (workStream: IWorkStream): Promise<WorkStreamValidations> => {
        const errors = new WorkStreamValidations();

        if (workStream.Title === null || workStream.Title === '') {
            errors.Title = 'Work stream name is required';
            errors.Valid = false;
        }
        else
            errors.Title = null;

        if (workStream.ProjectID === null) {
            errors.ProjectID = 'Project is required';
            errors.Valid = false;
        }
        else
            errors.ProjectID = null;

        if (workStream.Contributors.some(ct => ct.ContributorUserID == workStream.LeadUserID)) {
            errors.NormalContributors = 'A user cannot be both the lead and a contributor';
            errors.Valid = false;
        }
        else
            errors.NormalContributors = null;

        return Promise.resolve(errors);
    };

    return (
        <EntityForm<IWorkStream, WorkStreamValidations>
            {...props}
            entityName="Work stream"
            renderFormFields={(changeHandlers, formState) => {
                const { FormData: workStream, ValidationErrors: errors } = formState;
                const mappedUsers = LookupService.projectUsers(lookupData, workStream.ProjectID, workStream);
                const suggestions = {
                    initialSuggestionsHeaderText: `Project users`,
                    initialSuggestions: mappedUsers,
                    noResultsFoundText: mappedUsers.length === 0 ? `No users are mapped to this work stream's project` : null
                };
                return (
                    <div>
                        <CrComboBox
                            label="Project"
                            required={true}
                            className={styles.formField}
                            options={LookupService.entitiesToSelectableOptions(lookupData.Projects)}
                            selectedKey={workStream.ProjectID}
                            onChange={(_, v) => changeHandlers.changeDropdown(v, 'ProjectID')}
                            errorMessage={errors.ProjectID}
                            disabled={workStream.Attributes.filter(x => x.AttributeTypeID===1000).length > 0}
                        />
                        <CrTextField
                            label="Name"
                            required={true}
                            maxLength={255}
                            className={styles.formField}
                            value={workStream.Title}
                            onChange={v => changeHandlers.changeTextField(v, 'Title')}
                            errorMessage={errors.Title}
                            disabled={workStream.Attributes.filter(x => x.AttributeTypeID===1000).length > 0}
                        />
                        <CrTextField
                            label="Description"
                            className={styles.formField}
                            value={workStream.Description}
                            maxLength={500}
                            onChange={v => changeHandlers.changeTextField(v, 'Description')}
                            multiline
                            disabled={workStream.Attributes.filter(x => x.AttributeTypeID===1000).length > 0}
                        />
                        <CrTextField
                            label="Work stream ID"
                            maxLength={255}
                            className={styles.formField}
                            value={workStream.WorkStreamCode}
                            onChange={v => changeHandlers.changeTextField(v, 'WorkStreamCode')}
                        />
                        <CrUserPicker
                            label="Lead"
                            className={styles.formField}
                            disabled={!workStream.ProjectID}
                            users={mappedUsers}
                            selectedUsers={workStream.LeadUserID && [workStream.LeadUserID]}
                            onChange={u => changeHandlers.changeUserPicker(u, 'LeadUserID')}
                            {...suggestions}
                        />
                        <CrUserPicker
                            label="Contributors"
                            className={styles.formField}
                            disabled={!workStream.ProjectID}
                            users={mappedUsers}
                            itemLimit={3}
                            selectedUsers={workStream.Contributors && workStream.Contributors.map(c => c.ContributorUserID)}
                            onChange={v => changeHandlers.changeMultiUserPicker(v, 'Contributors', new Contributor(), 'ContributorUserID')}
                            errorMessage={errors.NormalContributors}
                            {...suggestions}
                        />
                        <CrMultiDropdownWithText
                            label="Attributes"
                            className={styles.formField}
                            textMaxLength={255}
                            options={LookupService.attributeTypesToMultiDropdownWithTextOptions(lookupData.AttributeTypes)}
                            selectedItems={LookupService.attributesToDropdownWithText(workStream.Attributes)}
                            onChange={v => changeHandlers.changeMultiDropdownWithText(v, 'Attributes', new Attribute(), 'AttributeTypeID', 'AttributeValue')}
                        />
                        {formState.FormDataBeforeChanges.EntityStatusID === EntityStatus.Closed &&
                            <CrDropdown
                                label="Status"
                                className={styles.formField}
                                options={LookupService.entitiesToSelectableOptions(lookupData.EntityStatuses)}
                                selectedKey={workStream.EntityStatusID}
                                onChange={(_, o) => changeHandlers.changeDropdown(o, 'EntityStatusID')}
                            />
                        }
                    </div>
                );
            }}
            loadEntity={id => dataServices.workStreamService.read(id, true, true)}
            loadNewEntity={() => new WorkStream()}
            loadEntityValidations={() => new WorkStreamValidations()}
            onValidateEntity={validateEntity}
            onCreate={w => dataServices.workStreamService.create(w)}
            onUpdate={w => dataServices.workStreamService.update(w.ID, w)}
            parentEntities={dataServices.workStreamService.parentEntities}
            childEntities={[
                { ObjectParentProperty: 'Contributors', ParentIdProperty: 'WorkStreamID', ChildIdProperty: 'ContributorUserID', ChildService: dataServices.contributorService },
                { ObjectParentProperty: 'Attributes', ParentIdProperty: 'WorkStreamID', ChildIdProperty: 'AttributeTypeID', ChildService: dataServices.attributeService }
            ]}
        />
    );
};
