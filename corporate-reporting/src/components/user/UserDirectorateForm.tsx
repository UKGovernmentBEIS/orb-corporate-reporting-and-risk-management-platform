import React, { useContext, useMemo } from 'react';
import {
    IUserDirectorate, EntityValidations, ISpecificEntityFormProps, UserDirectorate
} from '../../types';
import styles from '../../styles/cr.module.scss';
import { CrUserPicker } from '../cr/CrUserPicker';
import { CrDropdown } from '../cr/CrDropdown';
import { Checkbox } from 'office-ui-fabric-react/lib/Checkbox';
import { EntityForm } from '../EntityForm';
import { LookupService } from '../../services';
import { DataContext } from '../DataContext';

export class UserDirectorateValidations extends EntityValidations {
    public DirectorateID: string = null;
    public UserID: string = null;
}

export const UserDirectorateForm = (props: ISpecificEntityFormProps): React.ReactElement => {
    const { dataServices, lookupData, loadLookupData: { directorates, users: { enabled: enabledUsers } } } = useContext(DataContext);

    useMemo(() => directorates(), [directorates]);
    useMemo(() => enabledUsers(), [enabledUsers]);

    const validateEntity = async (userDirectorate: IUserDirectorate): Promise<UserDirectorateValidations> => {
        const errors = new UserDirectorateValidations();

        if (userDirectorate.DirectorateID === null) {
            errors.DirectorateID = 'Directorate is required';
            errors.Valid = false;
        }
        else
            errors.DirectorateID = null;

        if (userDirectorate.UserID === null) {
            errors.UserID = 'User is required';
            errors.Valid = false;
        }
        else
            errors.UserID = null;

        if (userDirectorate.DirectorateID !== null && userDirectorate.UserID !== null) {
            const dupes = await dataServices.userDirectorateService.checkForDuplicates(userDirectorate.UserID, userDirectorate.DirectorateID);
            if (dupes.length > 0 && dupes[0].ID !== userDirectorate.ID) {
                errors.UserID = 'User is already assigned to the directorate';
                errors.Valid = false;
            }
        }

        return Promise.resolve(errors);
    };

    return (
        <EntityForm<IUserDirectorate, UserDirectorateValidations>
            {...props}
            entityName="User directorate"
            renderFormFields={(changeHandlers, formState) => {
                const { FormData: userDirectorate, ValidationErrors: errors } = formState;
                return (
                    <div>
                        <CrDropdown
                            label="Directorate"
                            className={styles.formField}
                            required={true}
                            options={LookupService.entitiesToSelectableOptions(lookupData.Directorates)}
                            selectedKey={userDirectorate.DirectorateID}
                            onChange={(_, v) => changeHandlers.changeDropdown(v, 'DirectorateID')}
                            errorMessage={errors.DirectorateID} />
                        <CrUserPicker
                            label="User"
                            className={styles.formField}
                            required={true}
                            users={lookupData.Users && lookupData.Users.Enabled}
                            selectedUsers={userDirectorate.UserID && [userDirectorate.UserID]}
                            onChange={v => changeHandlers.changeUserPicker(v, 'UserID')}
                            errorMessage={errors.UserID} />
                        <Checkbox
                            className={`${styles.formField} ${styles.formField}`}
                            label="Directorate administrator?"
                            checked={userDirectorate.IsAdmin}
                            onChange={(_, isChecked) => changeHandlers.changeCheckbox(isChecked, 'IsAdmin')} />
                        <Checkbox
                            className={`${styles.formField} ${styles.formField}`}
                            label="Directorate risk administrator?"
                            checked={userDirectorate.IsRiskAdmin}
                            onChange={(_, isChecked) => changeHandlers.changeCheckbox(isChecked, 'IsRiskAdmin')} />
                    </div>
                );
            }}
            loadEntity={id => dataServices.userDirectorateService.read(id, true, true)}
            loadNewEntity={() => new UserDirectorate()}
            loadEntityValidations={() => new UserDirectorateValidations()}
            onValidateEntity={validateEntity}
            onCreate={ud => dataServices.userDirectorateService.create(ud)}
            onUpdate={ud => dataServices.userDirectorateService.update(ud.ID, ud)}
        />
    );
};
