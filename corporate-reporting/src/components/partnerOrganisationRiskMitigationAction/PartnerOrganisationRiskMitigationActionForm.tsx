import React, { useContext, useMemo } from 'react';
import {
    Contributor, IPartnerOrganisationRiskMitigationAction, PartnerOrganisationRiskMitigationAction,
    ISpecificEntityFormProps, EntityValidations
} from '../../types';
import { LookupService } from '../../services';
import styles from '../../styles/cr.module.scss';
import { CrUserPicker } from '../cr/CrUserPicker';
import { CrDatePicker } from '../cr/CrDatePicker';
import { CrTextField } from '../cr/CrTextField';
import { CrDropdown } from '../cr/CrDropdown';
import { EntityStatus } from '../../refData/EntityStatus';
import { CrCheckbox } from '../cr/CrCheckbox';
import { EntityForm } from '../EntityForm';
import { DataContext } from '../DataContext';

export class PartnerOrganisationRiskMitigationActionValidations extends EntityValidations {
    public PartnerOrganisationRiskID: string = null;
    public NormalContributors: string;
    public ReadOnlyContributors: string;
}

export const PartnerOrganisationRiskMitigationActionForm = (props: ISpecificEntityFormProps): React.ReactElement => {
    const { dataServices, lookupData, loadLookupData:
        { entityStatuses, partnerOrganisationRisks, userPartnerOrganisations, users: { all: allUsers } } } = useContext(DataContext);

    useMemo(() => entityStatuses(), [entityStatuses]);
    useMemo(() => partnerOrganisationRisks(), [partnerOrganisationRisks]);
    useMemo(() => userPartnerOrganisations(), [userPartnerOrganisations]);
    useMemo(() => allUsers(), [allUsers]);

    const validateEntity = (porma: IPartnerOrganisationRiskMitigationAction): Promise<PartnerOrganisationRiskMitigationActionValidations> => {
        const errors = new PartnerOrganisationRiskMitigationActionValidations();

        if (porma.Title === null || porma.Title === '') {
            errors.Title = 'Risk mitigation action name is required';
            errors.Valid = false;
        }
        else
            errors.Title = null;

        if (porma.PartnerOrganisationRiskID === null) {
            errors.PartnerOrganisationRiskID = 'Partner organisation risk is required';
            errors.Valid = false;
        }
        else
            errors.PartnerOrganisationRiskID = null;

        if (porma.Contributors.some(ct => !ct.IsReadOnly && ct.ContributorUserID === porma.OwnerUserID)) {
            errors.NormalContributors = 'A user cannot be both the owner and a contributor';
            errors.Valid = false;
        } else
            errors.NormalContributors = null;

        if (porma.Contributors.some(ct => ct.IsReadOnly && ct.ContributorUserID === porma.OwnerUserID)) {
            errors.ReadOnlyContributors = 'A user cannot be both the owner and a read-only contributor';
            errors.Valid = false;
        } else
            errors.ReadOnlyContributors = null;

        return Promise.resolve(errors);
    };

    return (
        <EntityForm<IPartnerOrganisationRiskMitigationAction, PartnerOrganisationRiskMitigationActionValidations>
            {...props}
            entityName="Partner organisation risk mitigating action"
            renderFormFields={(changeHandlers, formState) => {
                const { FormData: action, ValidationErrors: errors } = formState;
                const risk = lookupData.PartnerOrganisationRisks.find(r => r.ID === action.PartnerOrganisationRiskID);
                const mappedUsers = LookupService.partnerOrganisationRiskUsers(lookupData, risk);
                const suggestions = {
                    initialSuggestionsHeaderText: `Partner organisation users`,
                    initialSuggestions: mappedUsers,
                    noResultsFoundText: mappedUsers.length === 0 ? `No users are mapped to this risk mitigating action's partner organisation` : null
                };
                return (
                    <div>
                        <CrTextField
                            label="Name"
                            required={true}
                            className={styles.formField}
                            value={action.Title}
                            onChange={v => changeHandlers.changeTextField(v, 'Title')}
                            maxLength={200}
                            errorMessage={errors.Title}
                        />
                        <CrDropdown
                            label="Partner organisation risk"
                            required={true}
                            className={styles.formField}
                            options={LookupService.entitiesToSelectableOptions(lookupData.PartnerOrganisationRisks)}
                            selectedKey={action.PartnerOrganisationRiskID}
                            onChange={(_, option, index) => changeHandlers.changeDropdown(option, 'PartnerOrganisationRiskID', index)}
                            errorMessage={errors.PartnerOrganisationRiskID}
                        />
                        <CrTextField
                            label="Description"
                            className={styles.formField}
                            value={action.Description}
                            onChange={v => changeHandlers.changeTextField(v, 'Description')}
                            maxLength={500}
                            multiline
                        />
                        <CrUserPicker
                            label="Mitigating action owner"
                            className={styles.formField}
                            disabled={!action.PartnerOrganisationRiskID}
                            users={mappedUsers}
                            selectedUsers={action.OwnerUserID && [action.OwnerUserID]}
                            onChange={u => changeHandlers.changeUserPicker(u, 'OwnerUserID')}
                            {...suggestions}
                        />
                        <CrUserPicker
                            label="Contributors"
                            className={styles.formField}
                            disabled={!action.PartnerOrganisationRiskID}
                            users={mappedUsers}
                            itemLimit={6}
                            selectedUsers={action.Contributors.filter(c => !c.IsReadOnly).map(c => c.ContributorUserID)}
                            onChange={v => changeHandlers.changeMultiUserPickerC(v, 'Contributors', new Contributor(), 'ContributorUserID')}
                            errorMessage={errors.NormalContributors}
                            {...suggestions}
                        />
                        <CrUserPicker
                            label="Read-only contributors"
                            className={styles.formField}
                            disabled={!action.PartnerOrganisationRiskID}
                            users={mappedUsers}
                            itemLimit={6}
                            selectedUsers={action.Contributors && action.Contributors.filter(c => c.IsReadOnly).map(c => c.ContributorUserID)}
                            onChange={v => changeHandlers.changeMultiUserPickerROC(v, 'Contributors', new Contributor(), 'ContributorUserID')}
                            errorMessage={errors.ReadOnlyContributors}
                            {...suggestions}
                        />
                        <CrCheckbox
                            label="Is the action ongoing?"
                            className={styles.formField}
                            checked={action.ActionIsOngoing}
                            onChange={(_, isChecked) => isChecked ?
                                changeHandlers.changeCheckbox(isChecked, 'ActionIsOngoing', () => changeHandlers.changeDatePicker(null, 'BaselineDate'))
                                : changeHandlers.changeCheckbox(isChecked, 'ActionIsOngoing')
                            }
                        />
                        <CrDatePicker
                            label="Delivery date"
                            className={styles.formField}
                            disabled={action.ActionIsOngoing}
                            value={action.BaselineDate}
                            onSelectDate={d => changeHandlers.changeDatePicker(d, 'BaselineDate')}
                        />
                        {formState.FormDataBeforeChanges.EntityStatusID === EntityStatus.Closed &&
                            <CrDropdown label="Status" className={styles.formField}
                                options={LookupService.entitiesToSelectableOptions(lookupData.EntityStatuses)}
                                selectedKey={action.EntityStatusID}
                                onChange={(_, o) => changeHandlers.changeDropdown(o, 'EntityStatusID')}
                            />
                        }
                    </div>
                );
            }}
            loadEntity={id => dataServices.partnerOrganisationRiskMitigationActionService.read(id, true, true)}
            loadNewEntity={() => new PartnerOrganisationRiskMitigationAction()}
            loadEntityValidations={() => new PartnerOrganisationRiskMitigationActionValidations()}
            onValidateEntity={validateEntity}
            onBeforeSave={porma => delete porma.PartnerOrganisationRisk}
            onCreate={porma => dataServices.partnerOrganisationRiskMitigationActionService.create(porma)}
            onUpdate={porma => dataServices.partnerOrganisationRiskMitigationActionService.update(porma.ID, porma)}
            parentEntities={dataServices.partnerOrganisationRiskMitigationActionService.parentEntities}
            childEntities={[
                {
                    ObjectParentProperty: 'Contributors', ParentIdProperty: 'PartnerOrganisationRiskMitigationActionID',
                    ChildIdProperty: 'ContributorUserID', ChildService: dataServices.contributorService
                }
            ]}
        />
    );
};
