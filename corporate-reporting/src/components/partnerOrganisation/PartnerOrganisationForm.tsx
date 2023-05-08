import React, { useContext, useMemo } from 'react';
import {
    IPartnerOrganisation, PartnerOrganisation, Contributor,
    EntityValidations, ISpecificEntityFormProps, IUser
} from '../../types';
import styles from '../../styles/cr.module.scss';
import { CrDropdown } from '../cr/CrDropdown';
import { CrUserPicker } from '../cr/CrUserPicker';
import { CrTextField } from '../cr/CrTextField';
import { CrReportingCyclePicker } from '../cr/CrReportingCyclePicker';
import { EntityForm } from '../EntityForm';
import { LookupService } from '../../services';
import { ReportingCycleService } from '../../services/ReportingCycleService';
import { DataContext } from '../DataContext';
import { IntegrationContext } from '../IntegrationContext';
import { OrbUserContext } from '../OrbUserContext';

class PartnerOrganisationValidations extends EntityValidations {
    public ReportingCycle: string = null;
    public NormalContributors: string = null;
    public ReadOnlyContributors: string = null;
}

export const PartnerOrganisationForm = (props: ISpecificEntityFormProps): React.ReactElement => {
    const { userPermissions } = useContext(OrbUserContext);
    const { disablePartnerOrganisationManagement } = useContext(IntegrationContext);
    const { dataServices, lookupData,
        loadLookupData: { directorates, entityStatuses, userPartnerOrganisations, users: { all: allUsers } } } = useContext(DataContext);

    useMemo(() => directorates(), [directorates]);
    useMemo(() => entityStatuses(), [entityStatuses]);
    useMemo(() => userPartnerOrganisations(), [userPartnerOrganisations]);
    useMemo(() => allUsers(), [allUsers]);

    const validateEntity = (po: IPartnerOrganisation): Promise<PartnerOrganisationValidations> => {
        const errors = new PartnerOrganisationValidations();

        if (po.Title === null || po.Title === '') {
            errors.Title = 'Partner organisation name is required';
            errors.Valid = false;
        }
        else {
            errors.Title = null;
        }

        if (po.Contributors.some(ct => !ct.IsReadOnly && ct.ContributorUserID == po.LeadPolicySponsorUserID)) {
            errors.NormalContributors = 'A user cannot be both the lead and a contributor';
            errors.Valid = false;
        } else {
            errors.NormalContributors = null;
        }

        if (po.Contributors.some(ct => ct.IsReadOnly && ct.ContributorUserID == po.LeadPolicySponsorUserID)) {
            errors.ReadOnlyContributors = 'A user cannot be both the lead and a read-only contributor';
            errors.Valid = false;
        } else {
            errors.ReadOnlyContributors = null;
        }

        if (!ReportingCycleService.reportingCycleIsValid(po)) {
            errors.ReportingCycle = 'Please select all values for the reporting cycle';
            errors.Valid = false;
        }
        else {
            errors.ReportingCycle = null;
        }

        return Promise.resolve(errors);
    };

    const partnerOrganisationUsers = (partnerOrg: IPartnerOrganisation): IUser[] => {
        if (lookupData?.Users?.All && partnerOrg.ID) {
            return lookupData.Users.All.filter(u => LookupService.userIsInPartnerOrganisation(lookupData, u.ID, partnerOrg.ID)
                || LookupService.userIsContributor(partnerOrg, u.ID)
                || u.ID === partnerOrg.LeadPolicySponsorUserID
                || u.ID === partnerOrg.ReportAuthorUserID
            );
        }
        return [];
    };

    return (
        <EntityForm<IPartnerOrganisation, PartnerOrganisationValidations>
            {...props}
            entityName="Partner organisation"
            renderFormFields={(changeHandlers, formState) => {
                const { FormData: partnerOrg, ValidationErrors: errors } = formState;
                const mappedUsers = partnerOrganisationUsers(partnerOrg);
                const users = partnerOrg.ID ? mappedUsers : lookupData.Users && lookupData.Users.All;
                const suggestions = partnerOrg.ID ? {
                    initialSuggestionsHeaderText: 'Partner organisation users',
                    initialSuggestions: mappedUsers,
                    noResultsFoundText: mappedUsers.length === 0 ? 'No users are mapped to this partner organisation' : null
                } : {};
                return (
                    <>
                        <CrTextField
                            label="Partner organisation name"
                            maxLength={255}
                            required={true}
                            disabled={disablePartnerOrganisationManagement || !userPermissions.UserIsSystemAdmin()}
                            className={styles.formField}
                            value={partnerOrg.Title}
                            onChange={v => changeHandlers.changeTextField(v, 'Title')}
                            errorMessage={errors.Title}
                        />
                        <CrDropdown
                            label="Directorate"
                            disabled={!userPermissions.UserIsSystemAdmin()}
                            className={styles.formField}
                            options={LookupService.entitiesToSelectableOptions(lookupData.Directorates)}
                            selectedKey={partnerOrg.DirectorateID}
                            onChange={(_, option, index) => changeHandlers.changeDropdown(option, 'DirectorateID', index)}
                        />
                        <CrReportingCyclePicker
                            label="Reports due:"
                            required={true}
                            className={styles.formField}
                            cycle={{ frequency: partnerOrg.ReportingFrequency, dueDay: partnerOrg.ReportingDueDay, startDate: partnerOrg.ReportingStartDate }}
                            onChange={cycle => changeHandlers.changeReportingCycle(cycle)}
                            errorMessage={errors.ReportingCycle}
                        />
                        <CrUserPicker
                            label="SCS policy lead sponsor (approver)"
                            className={styles.formField}
                            users={users}
                            selectedUsers={partnerOrg.LeadPolicySponsorUserID && [partnerOrg.LeadPolicySponsorUserID]}
                            onChange={u => changeHandlers.changeUserPicker(u, 'LeadPolicySponsorUserID')}
                            {...suggestions}
                        />
                        <CrUserPicker
                            label="Alternative report approver"
                            className={styles.formField}
                            users={users}
                            selectedUsers={partnerOrg.ReportAuthorUserID && [partnerOrg.ReportAuthorUserID]}
                            onChange={u => changeHandlers.changeUserPicker(u, 'ReportAuthorUserID')}
                            {...suggestions}
                        />
                        <CrUserPicker
                            label="Contributors"
                            className={styles.formField}
                            users={users}
                            itemLimit={3}
                            selectedUsers={partnerOrg.Contributors.filter(c => !c.IsReadOnly).map(c => c.ContributorUserID)}
                            onChange={v => changeHandlers.changeMultiUserPickerC(v, 'Contributors', new Contributor(), 'ContributorUserID')}
                            errorMessage={errors.NormalContributors}
                            {...suggestions}
                        />
                        <CrUserPicker
                            label="Read-only contributors"
                            className={styles.formField}
                            users={users}
                            itemLimit={3}
                            selectedUsers={partnerOrg.Contributors.filter(c => c.IsReadOnly).map(c => c.ContributorUserID)}
                            onChange={v => changeHandlers.changeMultiUserPickerROC(v, 'Contributors', new Contributor(), 'ContributorUserID')}
                            errorMessage={errors.ReadOnlyContributors}
                            {...suggestions}
                        />
                        <CrTextField
                            label="Objectives"
                            className={styles.formField}
                            multiline
                            rows={6}
                            maxLength={10000}
                            value={partnerOrg.Objectives}
                            onChange={v => changeHandlers.changeTextField(v, 'Objectives')}
                        />
                        <CrDropdown
                            label="Status"
                            className={styles.formField}
                            disabled={disablePartnerOrganisationManagement}
                            options={LookupService.entitiesToSelectableOptions(lookupData.EntityStatuses)}
                            selectedKey={partnerOrg.EntityStatusID}
                            onChange={(_, o) => changeHandlers.changeStatusDropdown(o, 'EntityStatusID')}
                        />
                    </>
                );
            }}
            loadEntity={id => dataServices.partnerOrganisationService.read(id, true, true)}
            loadNewEntity={() => new PartnerOrganisation()}
            loadEntityValidations={() => new PartnerOrganisationValidations()}
            onValidateEntity={validateEntity}
            onCreate={po => dataServices.partnerOrganisationService.create(po)}
            onUpdate={po => dataServices.partnerOrganisationService.update(po.ID, po)}
            parentEntities={dataServices.partnerOrganisationService.parentEntities}
            childEntities={[
                {
                    ObjectParentProperty: 'Contributors', 
                    ParentIdProperty: 'PartnerOrganisationID',
                    ChildIdProperty: 'ContributorUserID', 
                    ChildService: dataServices.contributorService
                }
            ]}
        />
    );
};
