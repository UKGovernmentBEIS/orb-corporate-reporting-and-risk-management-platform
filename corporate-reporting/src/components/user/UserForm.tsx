import React, { useContext, useMemo } from 'react';
import { EntityStatus } from '../../refData/EntityStatus';
import styles from '../../styles/cr.module.scss';
import { IUser, User, ISpecificEntityFormProps, EntityValidations } from '../../types';
import { DataContext } from '../DataContext';
import { CrDropdown } from '../cr/CrDropdown';
import { CrTextField } from '../cr/CrTextField';
import { EntityForm } from '../EntityForm';
import { isValidEmailAddress, isValidGuid } from '../../services';
import { IntegrationContext } from '../IntegrationContext';
import { CrCheckbox } from '../cr/CrCheckbox';

export class UserValidations extends EntityValidations {
    public Username: string = null;
    public EmailAddress: string = null;
}

export const UserForm = (props: ISpecificEntityFormProps): React.ReactElement => {
    const { disableUserManagement } = useContext(IntegrationContext);
    const { dataServices: { userService }, loadLookupData: { entityStatuses } } = useContext(DataContext);

    useMemo(() => entityStatuses(), [entityStatuses]);

    const validateEntity = async (user: IUser): Promise<UserValidations> => {
        const errors = new UserValidations();
        const [matchingUsernames, matchingEmails] = await Promise.all([userService.readUsersByUsername(user.Username), userService.readUsersByEmailAddress(user.EmailAddress)]);

        if (user.Username == null || user.Username === '') {
            errors.Username = 'Username is required';
            errors.Valid = false;
        } else if (!user.IsServiceAccount && !isValidEmailAddress(user.Username)) {
            errors.Username = 'Username must be in a valid user@domain.gov.uk format';
            errors.Valid = false;
        } else if (user.IsServiceAccount && !isValidGuid(user.Username)) {
            errors.Username = 'Username must be in a valid GUID (00000000-0000-0000-0000-000000000000) format';
            errors.Valid = false;
        } else if (matchingUsernames?.length > 0 && matchingUsernames?.some(u => u.ID !== user.ID)) {
            errors.Username = 'Username already exists';
            errors.Valid = false;
        } else {
            errors.Username = null;
        }

        if (user.Title == null || user.Title === '') {
            errors.Title = 'Display name is required';
            errors.Valid = false;
        }
        else {
            errors.Title = null;
        }

        if (!user.IsServiceAccount && (user.EmailAddress == null || user.EmailAddress === '')) {
            errors.EmailAddress = 'Email address is required';
            errors.Valid = false;
        } else if (!user.IsServiceAccount && !isValidEmailAddress(user.EmailAddress)) {
            errors.EmailAddress = 'Email address must be a valid email address';
            errors.Valid = false;
        } else if (!user.IsServiceAccount && matchingEmails?.length > 0 && matchingEmails?.some(u => u.ID !== user.ID)) {
            errors.EmailAddress = 'Email address already exists';
            errors.Valid = false;
        } else {
            errors.EmailAddress = null;
        }

        return errors;
    };

    return (
        <EntityForm<IUser, UserValidations>
            {...props}
            entityName="User"
            renderFormFields={({ changeTextField, changeCheckbox, changeStatusDropdown, clearField }, formState) => {
                const { FormData: user, ValidationErrors: errors } = formState;
                return (
                    <div>
                        <CrTextField
                            label="Username"
                            className={styles.formField}
                            required={true}
                            maxLength={255}
                            placeholder="E.g. john.smith@beis.gov.uk"
                            value={user.Username}
                            onChange={v => changeTextField(v, 'Username')}
                            errorMessage={errors.Username}
                        />
                        <CrTextField
                            label="Display name"
                            className={styles.formField}
                            required={true}
                            maxLength={255}
                            value={user.Title}
                            onChange={v => changeTextField(v, 'Title')}
                            errorMessage={errors.Title}
                        />
                        <CrCheckbox
                            label="User is an app/service account?"
                            className={styles.formField}
                            disabled={disableUserManagement && user.ID !== 0}
                            checked={user.IsServiceAccount}
                            onChange={(_, c) => changeCheckbox(c, 'IsServiceAccount', () => clearField('EmailAddress'))}
                        />
                        <CrTextField
                            label="Email address"
                            className={styles.formField}
                            required={!user.IsServiceAccount}
                            maxLength={255}
                            disabled={(disableUserManagement && user.ID !== 0) || user.IsServiceAccount}
                            placeholder="E.g. john.smith@beis.gov.uk"
                            value={user.EmailAddress || ''}
                            onChange={v => changeTextField(v, 'EmailAddress')}
                            errorMessage={errors.EmailAddress}
                        />
                        {user.ID !== 0 &&
                            <CrDropdown
                                label="Account status"
                                className={styles.formField}
                                required={true}
                                options={[{ key: EntityStatus.Open, text: 'Enabled' }, { key: EntityStatus.Closed, text: 'Disabled' }]}
                                selectedKey={user.EntityStatusID}
                                onChange={(_, o) => changeStatusDropdown(o, 'EntityStatusID')}
                            />
                        }
                    </div>
                );
            }}
            loadEntity={id => userService.read(id, true, true)}
            loadNewEntity={() => new User()}
            loadEntityValidations={() => new UserValidations()}
            onValidateEntity={validateEntity}
            onCreate={u => userService.create(u)}
            onUpdate={u => userService.update(u.ID, u)}
            closeEntityConfirm={{
                header: `Are you sure you want to disable this user account?`,
                text: `All the permissions for this user will be deleted. `
                    + `If you need to re-enable this user account, you will also need to set up its user permissions.`
            }}
        />
    );
};
