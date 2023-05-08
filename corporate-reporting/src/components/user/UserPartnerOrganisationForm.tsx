import React, { useContext, useMemo } from 'react';
import { IUserPartnerOrganisation, EntityValidations, ISpecificEntityFormProps, UserPartnerOrganisation } from '../../types';
import styles from '../../styles/cr.module.scss';
import { CrUserPicker } from '../cr/CrUserPicker';
import { CrDropdown } from '../cr/CrDropdown';
import { EntityForm } from '../EntityForm';
import { LookupService } from '../../services';
import { CrCheckbox } from '../cr/CrCheckbox';
import { DataContext } from '../DataContext';

export class UserPartnerOrganisationValidations extends EntityValidations {
    public PartnerOrganisationID: string = null;
    public UserID: string = null;
}

export const UserPartnerOrganisationForm = (props: ISpecificEntityFormProps): React.ReactElement => {
    const { dataServices, lookupData, loadLookupData: { partnerOrganisations, users: { enabled: enabledUsers } } } = useContext(DataContext);

    useMemo(() => partnerOrganisations(), [partnerOrganisations]);
    useMemo(() => enabledUsers(), [enabledUsers]);

    const validateEntity = async (userPartnerOrganisation: IUserPartnerOrganisation): Promise<UserPartnerOrganisationValidations> => {
        const errors = new UserPartnerOrganisationValidations();

        if (userPartnerOrganisation.PartnerOrganisationID === null) {
            errors.PartnerOrganisationID = 'Partner organisation name is required';
            errors.Valid = false;
        }
        else
            errors.PartnerOrganisationID = null;

        if (userPartnerOrganisation.UserID === null) {
            errors.UserID = 'User is required';
            errors.Valid = false;
        }
        else
            errors.UserID = null;

        if (userPartnerOrganisation.PartnerOrganisationID !== null && userPartnerOrganisation.UserID !== null) {
            const dupes = await dataServices.userPartnerOrganisationService.checkForDuplicates(userPartnerOrganisation.UserID, userPartnerOrganisation.PartnerOrganisationID);
            if (dupes.length > 0 && dupes[0].ID !== userPartnerOrganisation.ID) {
                errors.UserID = 'User is already assigned to the partner organisation';
                errors.Valid = false;
            }
        }

        return Promise.resolve(errors);
    };
    return (
        <EntityForm<IUserPartnerOrganisation, UserPartnerOrganisationValidations>
            {...props}
            entityName="User partner organisation"
            renderFormFields={(changeHandlers, formState) => {
                const { FormData: userPartnerOrganisation, ValidationErrors: errors } = formState;
                return (
                    <>
                        <CrDropdown
                            label="Partner organisation name"
                            className={styles.formField}
                            required={true}
                            options={LookupService.entitiesToSelectableOptions(lookupData.PartnerOrganisations)}
                            selectedKey={userPartnerOrganisation.PartnerOrganisationID}
                            onChange={(_, v) => changeHandlers.changeDropdown(v, 'PartnerOrganisationID')}
                            errorMessage={errors.PartnerOrganisationID}
                        />
                        <CrUserPicker
                            label="User"
                            className={styles.formField}
                            required={true}
                            users={lookupData.Users?.Enabled}
                            selectedUsers={userPartnerOrganisation.UserID && [userPartnerOrganisation.UserID]}
                            onChange={v => changeHandlers.changeUserPicker(v, 'UserID')}
                            errorMessage={errors.UserID}
                        />
                        <CrCheckbox
                            className={styles.formField}
                            label="Partner organisation administrator?"
                            checked={userPartnerOrganisation.IsAdmin}
                            onChange={(_, isChecked) => changeHandlers.changeCheckbox(isChecked, 'IsAdmin')}
                        />
                        <CrCheckbox
                            className={styles.formField}
                            label="Hide report headlines?"
                            checked={userPartnerOrganisation.HideHeadlines}
                            onChange={(_, isChecked) => changeHandlers.changeCheckbox(isChecked, 'HideHeadlines')}
                        />
                        <CrCheckbox
                            className={styles.formField}
                            label="Hide report milestones?"
                            checked={userPartnerOrganisation.HideMilestones}
                            onChange={(_, isChecked) => changeHandlers.changeCheckbox(isChecked, 'HideMilestones')}
                        />
                        <CrCheckbox
                            className={styles.formField}
                            label="Hide custom report sections?"
                            checked={userPartnerOrganisation.HideCustomSections}
                            onChange={(_, isChecked) => changeHandlers.changeCheckbox(isChecked, 'HideCustomSections')}
                        />
                    </>
                );
            }}
            loadEntity={id => dataServices.userPartnerOrganisationService.read(id, true, true)}
            loadNewEntity={() => new UserPartnerOrganisation()}
            loadEntityValidations={() => new UserPartnerOrganisationValidations()}
            onValidateEntity={validateEntity}
            onCreate={ud => dataServices.userPartnerOrganisationService.create(ud)}
            onUpdate={ud => dataServices.userPartnerOrganisationService.update(ud.ID, ud)}
        />
    );
};
