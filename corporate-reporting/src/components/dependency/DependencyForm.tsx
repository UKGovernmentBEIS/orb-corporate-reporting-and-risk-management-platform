import React, { useContext, useMemo } from 'react';
import { IDependency, Contributor, ISpecificEntityFormProps, EntityValidations, Dependency, Attribute } from '../../types';
import { LookupService } from '../../services';
import styles from '../../styles/cr.module.scss';
import { CrDropdown } from '../cr/CrDropdown';
import { CrUserPicker } from '../cr/CrUserPicker';
import { EntityStatus } from '../../refData/EntityStatus';
import { CrTextField } from '../cr/CrTextField';
import { CrComboBox } from '../cr/CrComboBox';
import { EntityForm } from '../EntityForm';
import { CrDatePicker } from '../cr/CrDatePicker';
import { CrMultiDropdownWithText } from '../cr/CrMultiDropdownWithText';
import { DataContext } from '../DataContext';

export class DependencyValidations extends EntityValidations {
    public ProjectID: string = null;
    public NormalContributors: string = null;
}

export const DependencyForm = (props: ISpecificEntityFormProps): React.ReactElement => {
    const { dataServices, lookupData, loadLookupData: { attributeTypes, entityStatuses,
        projects, userProjects, users: { all: allUsers } } } = useContext(DataContext);

    useMemo(() => attributeTypes(), [attributeTypes]);
    useMemo(() => entityStatuses(), [entityStatuses]);
    useMemo(() => projects(), [projects]);
    useMemo(() => userProjects(), [userProjects]);
    useMemo(() => allUsers(), [allUsers]);

    const validateEntity = (dependency: IDependency): Promise<DependencyValidations> => {
        const errors = new DependencyValidations();

        if (dependency.Title === null || dependency.Title === '') {
            errors.Title = 'Dependency name is required';
            errors.Valid = false;
        }
        else
            errors.Title = null;

        if (dependency.ProjectID === null) {
            errors.ProjectID = 'Project is required';
            errors.Valid = false;
        }
        else
            errors.ProjectID = null;

        if (dependency.Contributors.some(ct => ct.ContributorUserID === dependency.LeadUserID)) {
            errors.NormalContributors = 'A user cannot be both the lead and a contributor';
            errors.Valid = false;
        }
        else
            errors.NormalContributors = null;

        return Promise.resolve(errors);
    };

    return (
        <EntityForm<IDependency, DependencyValidations>
            {...props}
            entityName="Dependency"
            renderFormFields={(changeHandlers, formState) => {
                const { FormData: dependency, ValidationErrors: errors } = formState;
                const mappedUsers = LookupService.projectUsers(lookupData, dependency.ProjectID, dependency);
                const suggestions = {
                    initialSuggestionsHeaderText: `Project users`,
                    initialSuggestions: mappedUsers,
                    noResultsFoundText: mappedUsers.length === 0 ? `No users are mapped to this dependency's project` : null
                };
                return (
                    <div>
                        <CrComboBox
                            label="Project"
                            className={styles.formField}
                            required={true}
                            options={LookupService.entitiesToSelectableOptions(lookupData.Projects)}
                            selectedKey={dependency.ProjectID}
                            onChange={(_, v) => changeHandlers.changeDropdown(v, 'ProjectID')}
                            errorMessage={errors.ProjectID}
                        />
                        <CrTextField
                            label="Name"
                            className={styles.formField}
                            required={true}
                            maxLength={255}
                            value={dependency.Title}
                            onChange={v => changeHandlers.changeTextField(v, 'Title')}
                            errorMessage={errors.Title}
                        />
                        <CrTextField
                            label="Description"
                            className={styles.formField}
                            value={dependency.Description}
                            maxLength={500}
                            onChange={v => changeHandlers.changeTextField(v, 'Description')}
                            multiline
                        />
                        <CrTextField
                            label="Name of third party"
                            className={styles.formField}
                            maxLength={255}
                            value={dependency.ThirdParty}
                            onChange={v => changeHandlers.changeTextField(v, 'ThirdParty')}
                        />
                        <CrUserPicker
                            label="Lead"
                            className={styles.formField}
                            disabled={!dependency.ProjectID}
                            users={mappedUsers}
                            selectedUsers={dependency.LeadUserID && [dependency.LeadUserID]}
                            onChange={v => changeHandlers.changeUserPicker(v, 'LeadUserID')}
                            {...suggestions}
                        />
                        <CrUserPicker
                            label="Contributors"
                            className={styles.formField}
                            disabled={!dependency.ProjectID}
                            users={mappedUsers}
                            itemLimit={3}
                            selectedUsers={dependency.Contributors && dependency.Contributors.map(c => c.ContributorUserID)}
                            onChange={v => changeHandlers.changeMultiUserPicker(v, 'Contributors', new Contributor(), 'ContributorUserID')}
                            errorMessage={errors.NormalContributors}
                            {...suggestions}
                        />
                        <CrDatePicker
                            label="Start date"
                            className={styles.formField}
                            value={dependency.StartDate}
                            onSelectDate={d => changeHandlers.changeDatePicker(d, 'StartDate')}
                        />
                        <CrDatePicker
                            label="Baseline end date"
                            className={styles.formField}
                            value={dependency.BaselineDate}
                            onSelectDate={date => changeHandlers.changeDatePicker(date, 'BaselineDate')}
                        />
                        <CrMultiDropdownWithText
                            label="Attributes"
                            className={styles.formField}
                            textMaxLength={255}
                            options={lookupData.AttributeTypes.map(a => ({ key: a.ID, text: a.Title, textRequired: false }))}
                            selectedItems={LookupService.attributesToDropdownWithText(dependency.Attributes)}
                            onChange={v => changeHandlers.changeMultiDropdownWithText(v, 'Attributes', new Attribute(), 'AttributeTypeID', 'AttributeValue')}
                        />
                        {formState.FormDataBeforeChanges.EntityStatusID === EntityStatus.Closed &&
                            <CrDropdown
                                label="Status"
                                className={styles.formField}
                                options={LookupService.entitiesToSelectableOptions(lookupData.EntityStatuses)}
                                selectedKey={dependency.EntityStatusID}
                                onChange={(_, o) => changeHandlers.changeDropdown(o, 'EntityStatusID')}
                            />
                        }
                    </div>
                );
            }}
            loadEntity={id => dataServices.dependencyService.read(id, true, true)}
            loadNewEntity={() => new Dependency()}
            loadEntityValidations={() => new DependencyValidations()}
            onValidateEntity={validateEntity}
            onCreate={d => dataServices.dependencyService.create(d)}
            onUpdate={d => dataServices.dependencyService.update(d.ID, d)}
            parentEntities={dataServices.dependencyService.parentEntities}
            childEntities={[
                { ObjectParentProperty: 'Contributors', ParentIdProperty: 'DependencyID', ChildIdProperty: 'ContributorUserID', ChildService: dataServices.contributorService },
                { ObjectParentProperty: 'Attributes', ParentIdProperty: 'DependencyID', ChildIdProperty: 'AttributeTypeID', ChildService: dataServices.attributeService }
            ]}
        />
    );
};
