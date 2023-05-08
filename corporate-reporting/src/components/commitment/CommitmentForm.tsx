import React, { useContext, useMemo } from 'react';
import {
    ICommitment, Contributor, Attribute, EntityValidations,
    ISpecificEntityFormProps, Commitment
} from '../../types';
import { LookupService } from '../../services';
import styles from '../../styles/cr.module.scss';
import { CrDropdown } from '../cr/CrDropdown';
import { CrUserPicker } from '../cr/CrUserPicker';
import { CrDatePicker } from '../cr/CrDatePicker';
import { EntityStatus } from '../../refData/EntityStatus';
import { CrTextField } from '../cr/CrTextField';
import { CrMultiDropdownWithText } from '../cr/CrMultiDropdownWithText';
import { EntityForm } from '../EntityForm';
import { DataContext } from '../DataContext';

export class CommitmentValidations extends EntityValidations {
    public DirectorateID: string = null;
    public NormalContributors: string = null;
}

export const CommitmentForm = (props: ISpecificEntityFormProps): React.ReactElement => {
    const { dataServices: { attributeService, commitmentService, contributorService } } = useContext(DataContext);
    const { lookupData, loadLookupData: { attributeTypes, directorates, entityStatuses, userDirectorates, users: { all: allUsers } } } = useContext(DataContext);

    useMemo(() => attributeTypes(), [attributeTypes]);
    useMemo(() => directorates(), [directorates]);
    useMemo(() => entityStatuses(), [entityStatuses]);
    useMemo(() => userDirectorates(), [userDirectorates]);
    useMemo(() => allUsers(), [allUsers]);

    const validateEntity = (commitment: ICommitment): Promise<CommitmentValidations> => {
        const errors = new CommitmentValidations();

        if (commitment.Title === null || commitment.Title === '') {
            errors.Title = 'Commitment name is required';
            errors.Valid = false;
        }
        else
            errors.Title = null;

        if (commitment.DirectorateID === null) {
            errors.DirectorateID = 'Directorate is required';
            errors.Valid = false;
        }
        else
            errors.DirectorateID = null;

        if (commitment.Contributors.some(ct => ct.ContributorUserID === commitment.LeadUserID)) {
            errors.NormalContributors = 'A user cannot be both the lead and a contributor';
            errors.Valid = false;
        }
        else
            errors.NormalContributors = null;

        return Promise.resolve(errors);
    };

    return (
        <EntityForm<ICommitment, CommitmentValidations>
            {...props}
            entityName="Commitment"
            renderFormFields={(changeHandlers, formState) => {
                const { FormData: commitment, ValidationErrors: errors } = formState;
                const mappedUsers = LookupService.directorateUsers(lookupData, commitment.DirectorateID, commitment);
                const suggestions = {
                    initialSuggestionsHeaderText: `Directorate users`,
                    initialSuggestions: mappedUsers,
                    noResultsFoundText: mappedUsers.length === 0 ? `No users are mapped to this commitment's directorate` : null
                };
                return (
                    <div>
                        <CrDropdown
                            label="Directorate"
                            className={styles.formField}
                            required={true}
                            options={LookupService.entitiesToSelectableOptions(lookupData.Directorates)}
                            selectedKey={commitment.DirectorateID}
                            onChange={(_, v) => changeHandlers.changeDropdown(v, 'DirectorateID')}
                            errorMessage={errors.DirectorateID}
                        />
                        <CrTextField
                            label="Name"
                            className={styles.formField}
                            required={true}
                            maxLength={255}
                            value={commitment.Title}
                            onChange={v => changeHandlers.changeTextField(v, 'Title')}
                            errorMessage={errors.Title}
                        />
                        <CrTextField
                            label="Description"
                            className={styles.formField}
                            value={commitment.Description}
                            maxLength={500}
                            onChange={v => changeHandlers.changeTextField(v, 'Description')}
                            multiline
                        />
                        <CrDatePicker
                            label="Baseline delivery date"
                            className={styles.formField}
                            value={commitment.BaselineDate}
                            onSelectDate={d => changeHandlers.changeDatePicker(d, 'BaselineDate')}
                        />
                        <CrUserPicker
                            label="Lead"
                            className={styles.formField}
                            disabled={!commitment.DirectorateID}
                            users={mappedUsers}
                            selectedUsers={commitment.LeadUserID && [commitment.LeadUserID]}
                            onChange={v => changeHandlers.changeUserPicker(v, 'LeadUserID')}
                            {...suggestions}
                        />
                        <CrUserPicker
                            label="Contributors"
                            className={styles.formField}
                            disabled={!commitment.DirectorateID}
                            users={mappedUsers}
                            itemLimit={3}
                            selectedUsers={commitment.Contributors && commitment.Contributors.map(c => c.ContributorUserID)}
                            onChange={v => changeHandlers.changeMultiUserPicker(v, 'Contributors', new Contributor(), 'ContributorUserID')}
                            errorMessage={errors.NormalContributors}
                            {...suggestions}
                        />
                        <CrMultiDropdownWithText
                            label="Attributes"
                            className={styles.formField}
                            textMaxLength={255}
                            options={lookupData.AttributeTypes.map(a => ({ key: a.ID, text: a.Title, textRequired: false }))}
                            selectedItems={LookupService.attributesToDropdownWithText(commitment.Attributes)}
                            onChange={v => changeHandlers.changeMultiDropdownWithText(v, 'Attributes', new Attribute(), 'AttributeTypeID', 'AttributeValue')}
                        />
                        {formState.FormDataBeforeChanges.EntityStatusID === EntityStatus.Closed &&
                            <CrDropdown
                                label="Status"
                                className={styles.formField}
                                options={LookupService.entitiesToSelectableOptions(lookupData.EntityStatuses)}
                                selectedKey={commitment.EntityStatusID}
                                onChange={(_, o) => changeHandlers.changeDropdown(o, 'EntityStatusID')}
                            />
                        }
                    </div>
                );
            }}
            loadEntity={commitmentId => commitmentService.read(commitmentId, true, true)}
            loadNewEntity={() => new Commitment()}
            loadEntityValidations={() => new CommitmentValidations()}
            onValidateEntity={validateEntity}
            onCreate={c => commitmentService.create(c)}
            onUpdate={c => commitmentService.update(c.ID, c)}
            parentEntities={commitmentService.parentEntities}
            childEntities={[
                { ObjectParentProperty: 'Contributors', ParentIdProperty: 'CommitmentID', ChildIdProperty: 'ContributorUserID', ChildService: contributorService },
                { ObjectParentProperty: 'Attributes', ParentIdProperty: 'CommitmentID', ChildIdProperty: 'AttributeTypeID', ChildService: attributeService }
            ]}
        />
    );
};
