import React, { useContext, useMemo } from 'react';
import {
    IGroup, Group, IEntityFormValidations, EntityFormValidations,
    IEntityValidations, EntityValidations, ISpecificEntityFormProps
} from '../../types';
import { LookupService } from '../../services';
import styles from '../../styles/cr.module.scss';
import { CrUserPicker } from '../cr/CrUserPicker';
import { CrTextField } from '../cr/CrTextField';
import { CrDropdown } from '../cr/CrDropdown';
import { EntityForm } from '../EntityForm';
import { DataContext } from '../DataContext';
import { IntegrationContext } from '../IntegrationContext';
import { OrbUserContext } from '../OrbUserContext';

export const GroupForm = (props: ISpecificEntityFormProps): React.ReactElement => {
    const { userPermissions } = useContext(OrbUserContext);
    const { disableGroupManagement } = useContext(IntegrationContext);
    const { dataServices, lookupData, loadLookupData: { entityStatuses, users: { all: allUsers } } } = useContext(DataContext);

    useMemo(() => entityStatuses(), [entityStatuses]);
    useMemo(() => allUsers(), [allUsers]);

    const validateEntity = (group: IGroup): Promise<IEntityFormValidations> => {
        const errors = new EntityFormValidations();

        if (group.Title === null || group.Title === '') {
            errors.Title = 'Group name is required';
            errors.Valid = false;
        }
        else
            errors.Title = null;

        return Promise.resolve(errors);
    };

    return (
        <EntityForm<IGroup, IEntityValidations>
            {...props}
            entityName="Group"
            renderFormFields={(changeHandlers, formState) => {
                const { FormData: group, ValidationErrors: errors } = formState;
                return (
                    <div>
                        <CrTextField
                            label="Name"
                            maxLength={50}
                            className={styles.formField}
                            required={true}
                            disabled={disableGroupManagement || !userPermissions.UserIsSystemAdmin()}
                            value={group.Title}
                            onChange={v => changeHandlers.changeTextField(v, 'Title')}
                            errorMessage={errors.Title} />
                        <CrUserPicker
                            label="Director General (DG)"
                            className={styles.formField}
                            users={lookupData.Users?.All}
                            selectedUsers={group.DirectorGeneralUserID && [group.DirectorGeneralUserID]}
                            onChange={v => changeHandlers.changeUserPicker(v, 'DirectorGeneralUserID')} />
                        <CrUserPicker
                            label="Deputy Director risk champion"
                            className={styles.formField}
                            users={lookupData.Users?.All}
                            selectedUsers={group.RiskChampionDeputyDirectorUserID && [group.RiskChampionDeputyDirectorUserID]}
                            onChange={v => changeHandlers.changeUserPicker(v, 'RiskChampionDeputyDirectorUserID')} />
                        <CrUserPicker
                            label="Portfolio Office business partner"
                            className={styles.formField}
                            users={lookupData.Users?.All}
                            selectedUsers={group.BusinessPartnerUserID && [group.BusinessPartnerUserID]}
                            onChange={v => changeHandlers.changeUserPicker(v, 'BusinessPartnerUserID')} />
                        <CrDropdown
                            label="Status"
                            className={styles.formField}
                            disabled={disableGroupManagement}
                            options={LookupService.entitiesToSelectableOptions(lookupData.EntityStatuses)}
                            selectedKey={group.EntityStatusID}
                            onChange={(_, o) => changeHandlers.changeStatusDropdown(o, 'EntityStatusID')} />
                    </div>
                );
            }}
            loadEntity={id => dataServices.groupService.read(id, true, true)}
            loadNewEntity={() => new Group()}
            loadEntityValidations={() => new EntityValidations()}
            onValidateEntity={validateEntity}
            onCreate={g => dataServices.groupService.create(g)}
            onUpdate={g => dataServices.groupService.update(g.ID, g)}
        />
    );
};
