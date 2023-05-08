import React, { useContext, useMemo } from 'react';
import { IUserProject, UserProject, ISpecificEntityFormProps, EntityValidations } from '../../types';
import styles from '../../styles/cr.module.scss';
import { CrUserPicker } from '../cr/CrUserPicker';
import { Checkbox } from 'office-ui-fabric-react/lib/Checkbox';
import { CrComboBox } from '../cr/CrComboBox';
import { LookupService } from '../../services';
import { EntityForm } from '../EntityForm';
import { DataContext } from '../DataContext';

export class UserProjectValidations extends EntityValidations {
    public ProjectID: string = null;
    public UserID: string = null;
}

export const UserProjectForm = (props: ISpecificEntityFormProps): React.ReactElement => {
    const { dataServices, lookupData, loadLookupData: { projects, users: { enabled: enabledUsers } } } = useContext(DataContext);

    useMemo(() => projects(), [projects]);
    useMemo(() => enabledUsers(), [enabledUsers]);

    const validateEntity = async (userProject: IUserProject): Promise<UserProjectValidations> => {
        const errors = new UserProjectValidations();

        if (userProject.ProjectID === null) {
            errors.ProjectID = 'Project is required';
            errors.Valid = false;
        }
        else
            errors.ProjectID = null;

        if (userProject.UserID === null) {
            errors.UserID = 'User is required';
            errors.Valid = false;
        }
        else
            errors.UserID = null;

        if (userProject.ProjectID !== null && userProject.UserID !== null) {
            const dupes = await dataServices.userProjectService.checkForDuplicates(userProject.UserID, userProject.ProjectID);
            if (dupes.length > 0 && dupes[0].ID !== userProject.ID) {
                errors.UserID = 'User is already assigned to the project';
                errors.Valid = false;
            }
        }

        return Promise.resolve(errors);
    };
    return (
        <EntityForm<IUserProject, UserProjectValidations>
            {...props}
            entityName="User project"
            renderFormFields={(changeHandlers, formState) => {
                const { FormData: userProject, ValidationErrors: errors } = formState;
                return (
                    <div>
                        <CrComboBox
                            label="Project"
                            className={styles.formField}
                            required={true}
                            options={LookupService.entitiesToSelectableOptions(lookupData.Projects)}
                            selectedKey={userProject.ProjectID}
                            onChange={(_, v) => changeHandlers.changeDropdown(v, 'ProjectID')}
                            errorMessage={errors.ProjectID} />
                        <CrUserPicker
                            label="User"
                            className={styles.formField}
                            required={true}
                            users={lookupData.Users && lookupData.Users.Enabled}
                            selectedUsers={userProject.UserID && [userProject.UserID]}
                            onChange={v => changeHandlers.changeUserPicker(v, 'UserID')}
                            errorMessage={errors.UserID} />
                        <Checkbox
                            className={`${styles.formField} ${styles.formField}`}
                            label="Project administrator?"
                            checked={userProject.IsAdmin}
                            onChange={(_, isChecked) => changeHandlers.changeCheckbox(isChecked, 'IsAdmin')} />
                    </div>
                );
            }}
            loadEntity={id => dataServices.userProjectService.read(id, true, true)}
            loadNewEntity={() => new UserProject()}
            loadEntityValidations={() => new UserProjectValidations()}
            onValidateEntity={validateEntity}
            onCreate={up => dataServices.userProjectService.create(up)}
            onUpdate={up => dataServices.userProjectService.update(up.ID, up)}
        />
    );
};
