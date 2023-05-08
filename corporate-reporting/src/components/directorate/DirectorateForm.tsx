import React, { useContext, useMemo } from 'react';
import { IDirectorate, EntityValidations, Directorate, ISpecificEntityFormProps, IUser, Attribute, Contributor } from '../../types';
import { LookupService } from '../../services';
import styles from '../../styles/cr.module.scss';
import { CrDropdown } from '../cr/CrDropdown';
import { CrUserPicker } from '../cr/CrUserPicker';
import { CrTextField } from '../cr/CrTextField';
import { EntityForm } from '../EntityForm';
import { CrReportingCyclePicker } from '../cr/CrReportingCyclePicker';
import { ReportingCycleService } from '../../services/ReportingCycleService';
import { CrMultiDropdownWithText } from '../cr/CrMultiDropdownWithText';
import { DataContext } from '../DataContext';
import { IntegrationContext } from '../IntegrationContext';
import { OrbUserContext } from '../OrbUserContext';

export class DirectorateValidations extends EntityValidations {
    public GroupID: string = null;
    public ReportingCycle: string = null;
}

export const DirectorateForm = (props: ISpecificEntityFormProps): React.ReactElement => {
    const { userPermissions } = useContext(OrbUserContext);
    const { disableDirectorateManagement } = useContext(IntegrationContext);
    const { dataServices, lookupData, loadLookupData: { attributeTypes, entityStatuses, groups, userDirectorates, users: { all: allUsers } } } = useContext(DataContext);

    useMemo(() => attributeTypes(), [attributeTypes]);
    useMemo(() => entityStatuses(), [entityStatuses]);
    useMemo(() => groups(), [groups]);
    useMemo(() => userDirectorates(), [userDirectorates]);
    useMemo(() => allUsers(), [allUsers]);

    const validateEntity = (directorate: IDirectorate): Promise<DirectorateValidations> => {
        const errors = new DirectorateValidations();

        if (directorate.Title === null || directorate.Title === '') {
            errors.Title = 'Directorate name is required';
            errors.Valid = false;
        }
        else {
            errors.Title = null;
        }

        if (directorate.GroupID === null) {
            errors.GroupID = 'Group is required';
            errors.Valid = false;
        }
        else {
            errors.GroupID = null;
        }

        if (!ReportingCycleService.reportingCycleIsValid(directorate)) {
            errors.ReportingCycle = 'Please select all values for the reporting cycle';
            errors.Valid = false;
        }
        else {
            errors.ReportingCycle = null;
        }

        return Promise.resolve(errors);
    };

    const directorateUsers = (directorate: IDirectorate): IUser[] => {
        if (lookupData?.Users?.All && directorate.ID) {
            return lookupData.Users.All.filter(u => LookupService.userIsInDirectorate(lookupData, u.ID, directorate.ID)
                || LookupService.userIsContributor(directorate, u.ID)
                || u.ID === directorate.DirectorUserID
                || u.ID === directorate.ReportApproverUserID
                || u.ID === directorate.ReportingLeadUserID
            );
        }
        return [];
    };

    return (
        <EntityForm<IDirectorate, DirectorateValidations>
            {...props}
            entityName="Directorate"
            renderFormFields={(changeHandlers, formState) => {
                const { FormData: directorate, ValidationErrors: errors } = formState;
                const mappedUsers = directorateUsers(directorate);
                const users = directorate.ID ? mappedUsers : lookupData.Users?.All;
                const suggestions = directorate.ID ? {
                    initialSuggestionsHeaderText: 'Directorate users',
                    initialSuggestions: mappedUsers,
                    noResultsFoundText: 'No users are mapped to this directorate'
                } : {};
                return (
                    <div>
                        <CrTextField
                            label="Name"
                            maxLength={255}
                            required={true}
                            disabled={disableDirectorateManagement || !userPermissions.UserIsSystemAdmin()}
                            className={styles.formField}
                            value={directorate.Title}
                            onChange={v => changeHandlers.changeTextField(v, 'Title')}
                            errorMessage={errors.Title}
                        />
                        <CrDropdown
                            label="Group"
                            required={true}
                            disabled={disableDirectorateManagement || !userPermissions.UserIsSystemAdmin()}
                            className={styles.formField}
                            options={LookupService.entitiesToSelectableOptions(lookupData.Groups)}
                            selectedKey={directorate.GroupID}
                            onChange={(_, option, index) => changeHandlers.changeDropdown(option, 'GroupID', index)}
                            errorMessage={errors.GroupID}
                        />
                        <CrReportingCyclePicker
                            label="Reports due:"
                            required={true}
                            className={styles.formField}
                            cycle={{ frequency: directorate.ReportingFrequency, dueDay: directorate.ReportingDueDay, startDate: directorate.ReportingStartDate }}
                            onChange={cycle => changeHandlers.changeReportingCycle(cycle)}
                            errorMessage={errors.ReportingCycle}
                        />
                        <CrUserPicker
                            label="Director"
                            className={styles.formField}
                            users={users}
                            selectedUsers={directorate.DirectorUserID && [directorate.DirectorUserID]}
                            onChange={u => changeHandlers.changeUserPicker(u, 'DirectorUserID')}
                            {...suggestions}
                        />
                        <CrUserPicker
                            label="Alternative report approver"
                            className={styles.formField}
                            users={users}
                            selectedUsers={directorate.ReportApproverUserID && [directorate.ReportApproverUserID]}
                            onChange={u => changeHandlers.changeUserPicker(u, 'ReportApproverUserID')}
                            {...suggestions}
                        />
                        <CrUserPicker
                            label="Reporting lead"
                            className={styles.formField}
                            users={users}
                            selectedUsers={directorate.ReportingLeadUserID && [directorate.ReportingLeadUserID]}
                            onChange={u => changeHandlers.changeUserPicker(u, 'ReportingLeadUserID')}
                            {...suggestions}
                        />
                        <CrUserPicker
                            label="Headline update contributors"
                            className={styles.formField}
                            users={users}
                            itemLimit={3}
                            selectedUsers={directorate.Contributors?.map(c => c.ContributorUserID)}
                            onChange={v => changeHandlers.changeMultiUserPicker(v, 'Contributors', new Contributor(), 'ContributorUserID')}
                            {...suggestions}
                        />
                        <CrTextField
                            label="Objectives"
                            multiline
                            rows={6}
                            maxLength={10000}
                            className={styles.formField}
                            value={directorate.Objectives}
                            onChange={v => changeHandlers.changeTextField(v, 'Objectives')}
                        />
                        <CrMultiDropdownWithText
                            label="Attributes"
                            className={styles.formField}
                            textMaxLength={255}
                            options={lookupData.AttributeTypes.map(a => ({ key: a.ID, text: a.Title, textRequired: false }))}
                            selectedItems={LookupService.attributesToDropdownWithText(directorate.Attributes)}
                            onChange={v => changeHandlers.changeMultiDropdownWithText(v, 'Attributes', new Attribute(), 'AttributeTypeID', 'AttributeValue')}
                        />
                        <CrDropdown
                            label="Status"
                            className={styles.formField}
                            disabled={disableDirectorateManagement}
                            options={LookupService.entitiesToSelectableOptions(lookupData.EntityStatuses)}
                            selectedKey={directorate.EntityStatusID}
                            onChange={(_, o) => changeHandlers.changeStatusDropdown(o, 'EntityStatusID')}
                        />
                    </div>
                );
            }}
            loadEntity={directorateId => dataServices.directorateService.read(directorateId, true, true)}
            loadNewEntity={() => new Directorate()}
            loadEntityValidations={() => new DirectorateValidations()}
            onValidateEntity={validateEntity}
            onCreate={directorate => dataServices.directorateService.create(directorate)}
            onUpdate={directorate => dataServices.directorateService.update(directorate.ID, directorate)}
            parentEntities={dataServices.directorateService.parentEntities}
            childEntities={[
                {
                    ObjectParentProperty: 'Contributors',
                    ParentIdProperty: 'DirectorateID',
                    ChildIdProperty: 'ContributorUserID',
                    ChildService: dataServices.contributorService
                },
                {
                    ObjectParentProperty: 'Attributes',
                    ParentIdProperty: 'DirectorateID',
                    ChildIdProperty: 'AttributeTypeID',
                    ChildService: dataServices.attributeService
                }
            ]}
        />
    );
};
