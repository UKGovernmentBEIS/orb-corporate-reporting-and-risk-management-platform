import React, { useContext, useMemo } from 'react';
import { IKeyWorkArea, KeyWorkArea, Contributor, Attribute, EntityValidations, ISpecificEntityFormProps } from '../../types';
import { LookupService } from '../../services';
import styles from '../../styles/cr.module.scss';
import { CrDropdown } from '../cr/CrDropdown';
import { CrUserPicker } from '../cr/CrUserPicker';
import { EntityStatus } from '../../refData/EntityStatus';
import { CrTextField } from '../cr/CrTextField';
import { CrMultiDropdownWithText } from '../cr/CrMultiDropdownWithText';
import { EntityForm } from '../EntityForm';
import { DataContext } from '../DataContext';

export class KeyWorkAreaValidations extends EntityValidations {
    public DirectorateID: string = null;
    public NormalContributors: string = null;
}

export const KeyWorkAreaForm = (props: ISpecificEntityFormProps): React.ReactElement => {
    const { dataServices: { keyWorkAreaService, attributeService, contributorService }, lookupData, loadLookupData: {
        attributeTypes, directorates, entityStatuses, userDirectorates, users: { all: allUsers } }
    } = useContext(DataContext);

    useMemo(() => attributeTypes(), [attributeTypes]);
    useMemo(() => directorates(), [directorates]);
    useMemo(() => entityStatuses(), [entityStatuses]);
    useMemo(() => userDirectorates(), [userDirectorates]);
    useMemo(() => allUsers(), [allUsers]);

    const validateEntity = (keyWorkArea: IKeyWorkArea): Promise<KeyWorkAreaValidations> => {
        const errors = new KeyWorkAreaValidations();

        if (keyWorkArea.Title === null || keyWorkArea.Title === '') {
            errors.Title = 'Key work area name is required';
            errors.Valid = false;
        }
        else
            errors.Title = null;

        if (keyWorkArea.DirectorateID === null) {
            errors.DirectorateID = 'Directorate is required';
            errors.Valid = false;
        }
        else
            errors.DirectorateID = null;

        if (keyWorkArea.Contributors.some(ct => ct.ContributorUserID === keyWorkArea.LeadUserID)) {
            errors.NormalContributors = 'A user cannot be both the lead and a contributor';
            errors.Valid = false;
        }
        else
            errors.NormalContributors = null;

        return Promise.resolve(errors);
    };

    return (
        <EntityForm<IKeyWorkArea, KeyWorkAreaValidations>
            {...props}
            entityName="Key work area"
            renderFormFields={(changeHandlers, formState) => {
                const { FormData: keyWorkArea, ValidationErrors: errors } = formState;
                const mappedUsers = LookupService.directorateUsers(lookupData, keyWorkArea.DirectorateID, keyWorkArea);
                const suggestions = {
                    initialSuggestionsHeaderText: `Directorate users`,
                    initialSuggestions: mappedUsers,
                    noResultsFoundText: mappedUsers.length === 0 ? `No users are mapped to this key work area's directorate` : null
                };
                return (
                    <div>
                        <CrDropdown
                            label="Directorate"
                            required={true}
                            className={styles.formField}
                            options={LookupService.entitiesToSelectableOptions(lookupData.Directorates)}
                            selectedKey={keyWorkArea.DirectorateID}
                            onChange={(_, o) => changeHandlers.changeDropdown(o, 'DirectorateID')}
                            errorMessage={errors.DirectorateID}
                        />
                        <CrTextField
                            label="Name"
                            required={true}
                            maxLength={255}
                            className={styles.formField}
                            value={keyWorkArea.Title}
                            onChange={v => changeHandlers.changeTextField(v, 'Title')}
                            errorMessage={errors.Title}
                        />
                        <CrTextField
                            label="Description"
                            className={styles.formField}
                            value={keyWorkArea.Description}
                            maxLength={500}
                            onChange={v => changeHandlers.changeTextField(v, 'Description')}
                            multiline
                        />
                        <CrUserPicker
                            label="Lead"
                            className={styles.formField}
                            disabled={!keyWorkArea.DirectorateID}
                            users={mappedUsers}
                            selectedUsers={keyWorkArea.LeadUserID ? [keyWorkArea.LeadUserID] : []}
                            onChange={v => changeHandlers.changeUserPicker(v, 'LeadUserID')}
                            {...suggestions}
                        />
                        <CrUserPicker
                            label="Contributors"
                            className={styles.formField}
                            disabled={!keyWorkArea.DirectorateID}
                            users={mappedUsers}
                            itemLimit={3}
                            selectedUsers={keyWorkArea.Contributors?.map(c => c.ContributorUserID)}
                            onChange={v => changeHandlers.changeMultiUserPicker(v, 'Contributors', new Contributor(), 'ContributorUserID')}
                            errorMessage={errors.NormalContributors}
                            {...suggestions}
                        />
                        <CrMultiDropdownWithText
                            label="Attributes"
                            className={styles.formField}
                            textMaxLength={255}
                            options={lookupData.AttributeTypes.map(a => ({ key: a.ID, text: a.Title, textRequired: false }))}
                            selectedItems={LookupService.attributesToDropdownWithText(keyWorkArea.Attributes)}
                            onChange={v => changeHandlers.changeMultiDropdownWithText(v, 'Attributes', new Attribute(), 'AttributeTypeID', 'AttributeValue')}
                        />
                        {formState.FormDataBeforeChanges.EntityStatusID === EntityStatus.Closed &&
                            <CrDropdown
                                label="Status"
                                className={styles.formField}
                                options={LookupService.entitiesToSelectableOptions(lookupData.EntityStatuses)}
                                selectedKey={keyWorkArea.EntityStatusID}
                                onChange={(_, o) => changeHandlers.changeDropdown(o, 'EntityStatusID')}
                            />
                        }
                    </div>
                );
            }}
            loadEntity={id => keyWorkAreaService.read(id, true, true)}
            loadNewEntity={() => new KeyWorkArea()}
            loadEntityValidations={() => new KeyWorkAreaValidations()}
            onValidateEntity={validateEntity}
            onCreate={k => keyWorkAreaService.create(k)}
            onUpdate={k => keyWorkAreaService.update(k.ID, k)}
            parentEntities={keyWorkAreaService.parentEntities}
            childEntities={[
                {
                    ObjectParentProperty: 'Contributors', ParentIdProperty: 'KeyWorkAreaID',
                    ChildIdProperty: 'ContributorUserID', ChildService: contributorService
                },
                {
                    ObjectParentProperty: 'Attributes', ParentIdProperty: 'KeyWorkAreaID',
                    ChildIdProperty: 'AttributeTypeID', ChildService: attributeService
                }
            ]}
        />
    );
};
