import React from 'react';
import {
    Contributor, PartnerOrganisationRisk, IPartnerOrganisationRisk, IPartnerOrganisationRiskUpdate,
    PartnerOrganisationRiskRiskType, EntityValidations, ISpecificEntityFormProps, Attribute
} from '../../types';
import { LookupService } from '../../services';
import styles from '../../styles/cr.module.scss';
import { CrUserPicker } from '../cr/CrUserPicker';
import { CrDropdown } from '../cr/CrDropdown';
import { CrTextField } from '../cr/CrTextField';
import { EntityStatus } from '../../refData/EntityStatus';
import { CrDatePicker } from '../cr/CrDatePicker';
import { CrCheckbox } from '../cr/CrCheckbox';
import { EntityForm } from '../EntityForm';
import { IEntityFormChangeHandlers } from '../../types/EntityFormProps';
import { CrMultiDropdownWithText } from '../cr/CrMultiDropdownWithText';
import { DataContext } from '../DataContext';

export class PartnerOrganisationRiskValidations extends EntityValidations {
    public RiskOwnerUserID: string;
    public BeisRiskOwnerUserID: string;
    public PartnerOrganisationID: string;
    public RiskProximity: string;
    public NormalContributors: string;
    public ReadOnlyContributors: string;
}

export interface IPartnerOrganisationRiskFormState {
    LastSignedOffRiskUpdate: IPartnerOrganisationRiskUpdate;
}

export class PartnerOrganisationRiskForm extends React.Component<ISpecificEntityFormProps, IPartnerOrganisationRiskFormState> {
    static contextType = DataContext;
    context!: React.ContextType<typeof DataContext>;

    constructor(props: ISpecificEntityFormProps) {
        super(props);
        this.state = { LastSignedOffRiskUpdate: null };
    }

    public render(): React.ReactElement {
        const { dataServices } = this.context;

        const validateEntity = (por: IPartnerOrganisationRisk): Promise<PartnerOrganisationRiskValidations> => {
            const errors = new PartnerOrganisationRiskValidations();

            if (por.Title === null || por.Title === '') {
                errors.Title = 'Risk name is required';
                errors.Valid = false;
            }
            else
                errors.Title = null;

            if (por.PartnerOrganisationID === null) {
                errors.PartnerOrganisationID = 'Partner organisation is required';
                errors.Valid = false;
            }
            else
                errors.PartnerOrganisationID = null;

            if (por.RiskOwnerUserID === null) {
                errors.RiskOwnerUserID = 'Partner organisation risk owner is required';
                errors.Valid = false;
            }
            else
                errors.RiskOwnerUserID = null;

            if (por.BeisRiskOwnerUserID === null) {
                errors.BeisRiskOwnerUserID = 'BEIS lead is required';
                errors.Valid = false;
            }
            else
                errors.BeisRiskOwnerUserID = null;

            if (por.Contributors.some(ct => !ct.IsReadOnly && ct.ContributorUserID === por.BeisRiskOwnerUserID)) {
                errors.NormalContributors = 'A user cannot be both the BEIS lead and a contributor';
                errors.Valid = false;
            }

            if (por.Contributors.some(ct => !ct.IsReadOnly && ct.ContributorUserID === por.RiskOwnerUserID)) {
                errors.NormalContributors = 'A user cannot be both the Partner organisation risk owner and a contributor';
                errors.Valid = false;
            }

            if (por.Contributors.some(ct => ct.IsReadOnly && ct.ContributorUserID === por.BeisRiskOwnerUserID)) {
                errors.ReadOnlyContributors = 'A user cannot be both the BEIS lead and a read-only contributor';
                errors.Valid = false;
            }

            if (por.Contributors.some(ct => ct.IsReadOnly && ct.ContributorUserID === por.RiskOwnerUserID)) {
                errors.ReadOnlyContributors = 'A user cannot be both the Partner organisation risk owner and a read-only contributor';
                errors.Valid = false;
            }

            if (!por.Contributors.some(ct => ct.IsReadOnly && ct.ContributorUserID === por.BeisRiskOwnerUserID)
                && !por.Contributors.some(ct => ct.IsReadOnly && ct.ContributorUserID === por.RiskOwnerUserID))
                errors.ReadOnlyContributors = null;

            if (!por.Contributors.some(ct => !ct.IsReadOnly && ct.ContributorUserID === por.BeisRiskOwnerUserID)
                && !por.Contributors.some(ct => !ct.IsReadOnly && ct.ContributorUserID === por.RiskOwnerUserID))
                errors.NormalContributors = null;

            if (por.ID === 0 && por.RiskProximity !== null && por.RiskProximity < new Date()) {
                errors.RiskProximity = 'Risk proximity cannot be in the past';
                errors.Valid = false;
            } else
                errors.RiskProximity = null;

            return Promise.resolve(errors);
        };

        const changeOngoingCheckbox = (isChecked: boolean, changeHandlers: IEntityFormChangeHandlers<IPartnerOrganisationRisk>) => {
            if (isChecked)
                changeHandlers.changeCheckbox(isChecked, 'RiskIsOngoing', () => changeHandlers.clearField('RiskProximity'));
            else
                changeHandlers.changeCheckbox(isChecked, 'RiskIsOngoing');
        }

        const today = new Date();
        const endOfMonth = new Date(Date.UTC(today.getFullYear(), today.getMonth() + 1, 0));
        const { lookupData } = this.context;
        return (
            <EntityForm<IPartnerOrganisationRisk, PartnerOrganisationRiskValidations>
                {...this.props}
                entityName="Partner organisation risk"
                renderFormFields={(changeHandlers, formState) => {
                    const { FormData: risk, ValidationErrors: errors } = formState;
                    const mappedUsers = LookupService.partnerOrganisationRiskUsers(lookupData, risk);
                    const suggestions = {
                        initialSuggestionsHeaderText: `Partner organisation users`,
                        initialSuggestions: mappedUsers,
                        noResultsFoundText: mappedUsers.length === 0 ? `No users are mapped to this risk's partner organisation` : null
                    };
                    return (
                        <div>
                            <CrTextField
                                label="Risk name"
                                required={true}
                                maxLength={255}
                                className={styles.formField}
                                value={risk.Title}
                                onChange={v => changeHandlers.changeTextField(v, 'Title')}
                                errorMessage={errors.Title}
                            />
                            <CrDropdown
                                label="Partner organisation"
                                className={styles.formField}
                                required={true}
                                options={LookupService.entitiesToSelectableOptions(lookupData?.PartnerOrganisations)}
                                selectedKey={risk.PartnerOrganisationID}
                                onChange={(_, o) => changeHandlers.changeDropdown(o, 'PartnerOrganisationID')}
                                errorMessage={errors.PartnerOrganisationID}
                            />
                            <CrUserPicker
                                label="Partner organisation risk owner"
                                required={true}
                                className={styles.formField}
                                disabled={!risk.PartnerOrganisationID}
                                users={mappedUsers}
                                selectedUsers={risk.RiskOwnerUserID && [risk.RiskOwnerUserID]}
                                onChange={u => changeHandlers.changeUserPicker(u, 'RiskOwnerUserID')}
                                errorMessage={errors.RiskOwnerUserID}
                                {...suggestions}
                            />
                            <CrUserPicker
                                label="BEIS lead"
                                required={true}
                                className={styles.formField}
                                disabled={!risk.PartnerOrganisationID}
                                users={mappedUsers}
                                selectedUsers={risk.BeisRiskOwnerUserID && [risk.BeisRiskOwnerUserID]}
                                onChange={u => changeHandlers.changeUserPicker(u, 'BeisRiskOwnerUserID')}
                                errorMessage={errors.BeisRiskOwnerUserID}
                                {...suggestions}
                            />
                            <CrUserPicker
                                label="Contributors"
                                className={styles.formField}
                                disabled={!risk.PartnerOrganisationID}
                                users={mappedUsers}
                                itemLimit={6}
                                selectedUsers={risk.Contributors.filter(c => !c.IsReadOnly).map(c => c.ContributorUserID)}
                                onChange={v => changeHandlers.changeMultiUserPickerC(v, 'Contributors', new Contributor(), 'ContributorUserID')}
                                errorMessage={errors.NormalContributors}
                                {...suggestions}
                            />
                            <CrUserPicker
                                label="Read-only contributors"
                                className={styles.formField}
                                disabled={!risk.PartnerOrganisationID}
                                users={mappedUsers}
                                itemLimit={6}
                                selectedUsers={risk.Contributors.filter(c => c.IsReadOnly).map(c => c.ContributorUserID)}
                                onChange={v => changeHandlers.changeMultiUserPickerROC(v, 'Contributors', new Contributor(), 'ContributorUserID')}
                                errorMessage={errors.ReadOnlyContributors}
                                {...suggestions}
                            />
                            <CrDropdown
                                label="Risk type"
                                className={styles.formField}
                                multiSelect
                                options={LookupService.entitiesToSelectableOptions(lookupData?.RiskTypes)}
                                selectedKeys={risk.PartnerOrganisationRiskRiskTypes && risk.PartnerOrganisationRiskRiskTypes.map(r => r.RiskTypeID)}
                                onChange={(_e, v) => changeHandlers.changeMultiDropdown(v, 'PartnerOrganisationRiskRiskTypes', new PartnerOrganisationRiskRiskType(), 'RiskTypeID')}
                            />
                            <CrTextField
                                label="Risk event description"
                                maxLength={600}
                                multiline
                                className={styles.formField}
                                value={risk.RiskEventDescription}
                                onChange={v => changeHandlers.changeTextField(v, 'RiskEventDescription')}
                            />
                            <CrTextField
                                label="Risk cause description"
                                maxLength={600}
                                multiline
                                className={styles.formField}
                                value={risk.RiskCauseDescription}
                                onChange={v => changeHandlers.changeTextField(v, 'RiskCauseDescription')}
                            />
                            <CrTextField
                                label="Risk impact description"
                                maxLength={600}
                                multiline
                                className={styles.formField}
                                value={risk.RiskImpactDescription}
                                onChange={v => changeHandlers.changeTextField(v, 'RiskImpactDescription')}
                            />
                            <CrDropdown
                                label="Partner organisation unmitigated probability"
                                className={styles.formField}
                                options={LookupService.entitiesToSelectableOptionsFilteredByDate(endOfMonth, lookupData?.RiskProbabilities)}
                                selectedKey={risk.UnmitigatedRiskProbabilityID}
                                onChange={(_, v) => changeHandlers.changeDropdown(v, 'UnmitigatedRiskProbabilityID')}
                            />
                            <CrDropdown
                                label="Partner organisation unmitigated impact"
                                className={styles.formField}
                                options={LookupService.entitiesToSelectableOptionsFilteredByDate(endOfMonth, lookupData?.RiskImpactLevels)}
                                selectedKey={risk.UnmitigatedRiskImpactLevelID}
                                onChange={(_, v) => changeHandlers.changeDropdown(v, 'UnmitigatedRiskImpactLevelID')}
                            />
                            <CrDropdown
                                label="Partner organisation target probability"
                                className={styles.formField}
                                options={LookupService.entitiesToSelectableOptionsFilteredByDate(endOfMonth, lookupData?.RiskProbabilities)}
                                selectedKey={risk.TargetRiskProbabilityID}
                                onChange={(_, v) => changeHandlers.changeDropdown(v, 'TargetRiskProbabilityID')}
                            />
                            <CrDropdown
                                label="Partner organisation target impact"
                                className={styles.formField}
                                options={LookupService.entitiesToSelectableOptionsFilteredByDate(endOfMonth, lookupData?.RiskImpactLevels)}
                                selectedKey={risk.TargetRiskImpactLevelID}
                                onChange={(_, v) => changeHandlers.changeDropdown(v, 'TargetRiskImpactLevelID')}
                            />
                            <CrDropdown label="BEIS unmitigated probability"
                                className={styles.formField}
                                options={LookupService.entitiesToSelectableOptionsFilteredByDate(endOfMonth, lookupData?.RiskProbabilities)}
                                selectedKey={risk.BEISUnmitigatedRiskProbabilityID}
                                onChange={(_, v) => changeHandlers.changeDropdown(v, 'BEISUnmitigatedRiskProbabilityID')}
                            />
                            <CrDropdown
                                label="BEIS unmitigated impact"
                                className={styles.formField}
                                options={LookupService.entitiesToSelectableOptionsFilteredByDate(endOfMonth, lookupData?.RiskImpactLevels)}
                                selectedKey={risk.BEISUnmitigatedRiskImpactLevelID}
                                onChange={(_, v) => changeHandlers.changeDropdown(v, 'BEISUnmitigatedRiskImpactLevelID')}
                            />
                            <CrDropdown
                                label="BEIS target probability"
                                className={styles.formField}
                                options={LookupService.entitiesToSelectableOptionsFilteredByDate(endOfMonth, lookupData?.RiskProbabilities)}
                                selectedKey={risk.BEISTargetRiskProbabilityID}
                                onChange={(_, v) => changeHandlers.changeDropdown(v, 'BEISTargetRiskProbabilityID')}
                            />
                            <CrDropdown
                                label="BEIS target impact"
                                className={styles.formField}
                                options={LookupService.entitiesToSelectableOptionsFilteredByDate(endOfMonth, lookupData?.RiskImpactLevels)}
                                selectedKey={risk.BEISTargetRiskImpactLevelID}
                                onChange={(_, v) => changeHandlers.changeDropdown(v, 'BEISTargetRiskImpactLevelID')}
                            />
                            <CrCheckbox
                                label="Is the risk ongoing?"
                                className={styles.formField}
                                checked={risk.RiskIsOngoing}
                                onChange={(_, isChecked) => changeOngoingCheckbox(isChecked, changeHandlers)}
                            />
                            <CrDatePicker
                                label="What is the proximity of this risk/when do you expect this risk to materialise?"
                                className={styles.formField}
                                disabled={risk.RiskIsOngoing}
                                value={risk.RiskProximity}
                                onSelectDate={v => changeHandlers.changeDatePicker(v, 'RiskProximity')}
                                minDate={risk.ID === 0 && new Date()}
                                errorMessage={errors.RiskProximity}
                            />
                            <CrDropdown
                                label="Partner organisation risk appetite"
                                className={styles.formField}
                                options={LookupService.entitiesToSelectableOptions(lookupData?.RiskAppetites)}
                                selectedKey={risk.RiskAppetiteID}
                                onChange={(_, v) => changeHandlers.changeDropdown(v, 'RiskAppetiteID')}
                            />
                            <CrDropdown
                                label="Which Departmental Objective will this most impact?"
                                className={styles.formField}
                                options={LookupService.entitiesToSelectableOptions(lookupData?.DepartmentalObjectives)}
                                selectedKey={risk.DepartmentalObjectiveID}
                                onChange={(_, v) => changeHandlers.changeDropdown(v, 'DepartmentalObjectiveID')}
                            />
                            <CrMultiDropdownWithText
                                label="Attributes"
                                className={styles.formField}
                                textMaxLength={255}
                                options={LookupService.attributeTypesToMultiDropdownWithTextOptions(lookupData?.AttributeTypes)}
                                selectedItems={LookupService.attributesToDropdownWithText(risk.Attributes)}
                                onChange={v => changeHandlers.changeMultiDropdownWithText(v, 'Attributes', new Attribute(), 'AttributeTypeID', 'AttributeValue')}
                            />
                            {formState.FormDataBeforeChanges.EntityStatusID === EntityStatus.Closed &&
                                <CrDropdown
                                    label="Status"
                                    className={styles.formField}
                                    options={LookupService.entitiesToSelectableOptions(lookupData?.EntityStatuses)}
                                    selectedKey={risk.EntityStatusID}
                                    onChange={(_, o) => changeHandlers.changeDropdown(o, 'EntityStatusID')}
                                />
                            }
                        </div>
                    );
                }}
                loadEntity={id => dataServices.partnerOrganisationRiskService.read(id, true, true)}
                loadNewEntity={() => new PartnerOrganisationRisk()}
                loadEntityValidations={() => new PartnerOrganisationRiskValidations()}
                onValidateEntity={validateEntity}
                onBeforeSave={r => delete r.Attributes}
                onCreate={r => dataServices.partnerOrganisationRiskService.create(r)}
                onUpdate={r => dataServices.partnerOrganisationRiskService.update(r.ID, r)}
                parentEntities={dataServices.partnerOrganisationRiskService.parentEntities}
                childEntities={[
                    {
                        ObjectParentProperty: 'PartnerOrganisationRiskRiskTypes', ParentIdProperty: 'PartnerOrganisationRiskID',
                        ChildIdProperty: 'RiskTypeID', ChildService: dataServices.partnerOrganisationRiskRiskTypeService
                    },
                    {
                        ObjectParentProperty: 'Contributors', ParentIdProperty: 'PartnerOrganisationRiskID',
                        ChildIdProperty: 'ContributorUserID', ChildService: dataServices.contributorService
                    },
                    {
                        ObjectParentProperty: 'Attributes', ParentIdProperty: 'PartnerOrganisationRiskID',
                        ChildIdProperty: 'AttributeTypeID', ChildService: dataServices.attributeService
                    }
                ]}
            />
        );
    }

    public componentDidMount(): void {
        this.loadLastSignedOffRiskUpdate();
        const { loadLookupData: lld } = this.context;
        lld?.attributeTypes();
        lld?.departmentalObjectives();
        lld?.entityStatuses();
        lld?.partnerOrganisations();
        lld?.riskAppetites();
        lld?.riskImpactLevels();
        lld?.riskProbabilities();
        lld?.riskTypes();
        lld?.userPartnerOrganisations();
        lld?.users.all();
    }

    private loadLastSignedOffRiskUpdate = async (): Promise<IPartnerOrganisationRiskUpdate[]> => {
        try {
            const signedOffUpdate = await this.context.dataServices.partnerOrganisationRiskUpdateService.readLatestSignedOffUpdate(this.props.entityId);
            this.setState({ LastSignedOffRiskUpdate: signedOffUpdate });
            return [signedOffUpdate];
        } catch (err) {
            this.props.errorHandling?.onError(`Error loading latest risk update`, err.message);
        }
    }
}
