import React, { useContext, useMemo } from 'react';
import { IUserGroup, UserGroup, ISpecificEntityFormProps, EntityValidations } from '../../types';
import { LookupService } from '../../services';
import styles from '../../styles/cr.module.scss';
import { CrUserPicker } from '../cr/CrUserPicker';
import { CrDropdown } from '../cr/CrDropdown';
import { EntityForm } from '../EntityForm';
import { DataContext } from '../DataContext';

export class FinancialRiskUserGroupValidations extends EntityValidations {
    public GroupID: string = null;
    public UserID: string = null;
}

export const FinancialRiskUserGroupForm = (props: ISpecificEntityFormProps): React.ReactElement => {
    const { dataServices, lookupData, loadLookupData: { groups, users: { enabled: enabledUsers } } } = useContext(DataContext);

    useMemo(() => groups(), [groups]);
    useMemo(() => enabledUsers(), [enabledUsers]);

    const validateEntity = async (userGroup: IUserGroup): Promise<FinancialRiskUserGroupValidations> => {
        const errors = new FinancialRiskUserGroupValidations();

        if (userGroup.GroupID === null) {
            errors.GroupID = 'Group is required';
            errors.Valid = false;
        }
        else {
            errors.GroupID = null;
        }

        if (userGroup.UserID === null) {
            errors.UserID = 'User is required';
            errors.Valid = false;
        }
        else {
            errors.UserID = null;
        }

        if (userGroup.GroupID !== null && userGroup.UserID !== null) {
            const dupes = await dataServices.financialRiskUserGroupService.checkForDuplicates(userGroup.UserID, userGroup.GroupID);
            if (dupes.length > 0 && dupes[0].ID !== userGroup.ID) {
                errors.UserID = 'User is already assigned to the group';
                errors.Valid = false;
            }
        }

        return Promise.resolve(errors);
    };
    return (
        <EntityForm<IUserGroup, FinancialRiskUserGroupValidations>
            {...props}
            entityName="User group"
            renderFormFields={(changeHandlers, { FormData: userGroup, ValidationErrors: errors }) =>
                <div>
                    <CrDropdown
                        label="Group"
                        className={styles.formField}
                        required={true}
                        options={LookupService.entitiesToSelectableOptions(lookupData.Groups)}
                        selectedKey={userGroup.GroupID}
                        onChange={(_, v) => changeHandlers.changeDropdown(v, 'GroupID')}
                        errorMessage={errors.GroupID}
                    />
                    <CrUserPicker
                        label="User"
                        className={styles.formField}
                        required={true}
                        users={lookupData.Users?.Enabled}
                        selectedUsers={userGroup.UserID && [userGroup.UserID]}
                        onChange={v => changeHandlers.changeUserPicker(v, 'UserID')}
                        errorMessage={errors.UserID}
                    />
                </div>
            }
            loadEntity={id => dataServices.financialRiskUserGroupService.read(id, true, true)}
            loadNewEntity={() => new UserGroup()}
            loadEntityValidations={() => new FinancialRiskUserGroupValidations()}
            onValidateEntity={validateEntity}
            onCreate={ud => dataServices.financialRiskUserGroupService.create(ud)}
            onUpdate={ud => dataServices.financialRiskUserGroupService.update(ud.ID, ud)}
        />
    );
};
