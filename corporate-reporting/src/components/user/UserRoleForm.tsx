import React, { useContext, useMemo } from 'react';
import styles from '../../styles/cr.module.scss';
import { IUserRole, UserRole, ISpecificEntityFormProps, EntityValidations } from '../../types';
import { LookupService } from '../../services';
import { CrDropdown } from '../cr/CrDropdown';
import { CrUserPicker } from '../cr/CrUserPicker';
import { EntityForm } from '../EntityForm';
import { DataContext } from '../DataContext';

export class UserRoleValidations extends EntityValidations {
    public UserID: string = null;
    public RoleID: string = null;
}

export const UserRoleForm = (props: ISpecificEntityFormProps): React.ReactElement => {
    const { dataServices, lookupData, loadLookupData: { roles, users: { enabled: enabledUsers } } } = useContext(DataContext);

    useMemo(() => roles(), [roles]);
    useMemo(() => enabledUsers(), [enabledUsers]);

    const validateEntity = async (userRole: IUserRole): Promise<UserRoleValidations> => {
        const errors = new UserRoleValidations();

        if (userRole.UserID === null) {
            errors.UserID = 'User is required';
            errors.Valid = false;
        }
        else
            errors.UserID = null;

        if (userRole.RoleID === null) {
            errors.RoleID = 'Role is required';
            errors.Valid = false;
        }
        else
            errors.RoleID = null;

        if (userRole.RoleID !== null && userRole.UserID !== null) {
            const dupes = await dataServices.userRoleService.checkForDuplicates(userRole.UserID, userRole.RoleID);
            if (dupes.length > 0 && dupes[0].ID !== userRole.ID) {
                errors.UserID = 'User is already assigned to the role';
                errors.Valid = false;
            }
        }

        return Promise.resolve(errors);
    };
    return (
        <EntityForm<IUserRole, UserRoleValidations>
            {...props}
            entityName="User role"
            renderFormFields={(changeHandlers, formState) => {
                const { FormData: userRole, ValidationErrors: errors } = formState;
                return (
                    <div>
                        <CrUserPicker
                            label="User"
                            className={styles.formField}
                            required={true}
                            users={lookupData.Users?.Enabled}
                            selectedUsers={userRole.UserID && [userRole.UserID]}
                            onChange={v => changeHandlers.changeUserPicker(v, 'UserID')}
                            errorMessage={errors.UserID} />
                        <CrDropdown
                            label="Role"
                            className={styles.formField}
                            required={true}
                            options={LookupService.entitiesToSelectableOptions(lookupData.Roles)}
                            selectedKey={userRole.RoleID}
                            onChange={(_, v) => changeHandlers.changeDropdown(v, 'RoleID')}
                            errorMessage={errors.RoleID} />
                    </div>
                );
            }}
            loadEntity={id => dataServices.userRoleService.read(id, true, true)}
            loadNewEntity={() => new UserRole()}
            loadEntityValidations={() => new UserRoleValidations()}
            onValidateEntity={validateEntity}
            onCreate={ur => dataServices.userRoleService.create(ur)}
            onUpdate={ur => dataServices.userRoleService.update(ur.ID, ur)}
        />
    );
};
