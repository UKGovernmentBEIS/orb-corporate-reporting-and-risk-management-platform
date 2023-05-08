import React from 'react';
import {
    IRisk, IRiskUpdate, IDirectorate, Contributor, RiskRiskType, IEntity, IProject,
    EntityValidations, ISpecificEntityFormProps, Attribute, ICorporateRisk, CorporateRisk
} from '../../types';
import { LookupService } from '../../services';
import styles from '../../styles/cr.module.scss';
import { CrUserPicker } from '../cr/CrUserPicker';
import { CrDropdown } from '../cr/CrDropdown';
import { CrTextField } from '../cr/CrTextField';
import { CrChoiceGroup } from '../cr/CrChoiceGroup';
import { EntityStatus } from '../../refData/EntityStatus';
import { CrDatePicker } from '../cr/CrDatePicker';
import { RiskRegister } from '../../refData/RiskRegister';
import { CrCheckbox } from '../cr/CrCheckbox';
import { CrComboBox } from '../cr/CrComboBox';
import { CrEntityPicker } from '../cr/CrEntityPicker';
import { EntityForm } from '../EntityForm';
import { IEntityFormChangeHandlers } from '../../types/EntityFormProps';
import { IDropdownOption } from 'office-ui-fabric-react/lib/Dropdown';
import { IChoiceGroupOption } from 'office-ui-fabric-react/lib/ChoiceGroup';
import { CrMultiDropdownWithText } from '../cr/CrMultiDropdownWithText';
import { DataContext } from '../DataContext';
import { OrbUserContext } from '../OrbUserContext';
import { IUseUserContextProps } from '../useUserContext';
import { IUseDataContextProps } from '../useDataContext';

// Add wrapper to enable use of multiple contexts in class component
export const RiskForm = (props: ISpecificEntityFormProps): React.ReactElement =>
    <OrbUserContext.Consumer>
        {orbUserContext =>
            <DataContext.Consumer>
                {dataContext =>
                    <RiskFormInner orbUserContext={orbUserContext} dataContext={dataContext} {...props} />
                }
            </DataContext.Consumer>
        }
    </OrbUserContext.Consumer>

export class RiskValidations extends EntityValidations {
    public RiskRegisterID: string;
    public RiskOwnerUserID: string;
    public DirectorateID: string;
    public ProjectID: string;
    public RiskProximity: string;
    public NormalContributors: string = null;
}

export interface IRiskFormInnerProps extends ISpecificEntityFormProps {
    orbUserContext: IUseUserContextProps;
    dataContext: IUseDataContextProps;
}

export interface IRiskFormState {
    LastSignedOffRiskUpdate: IRiskUpdate;
    FilteredDirectorates: IDirectorate[];
    FilteredProjects: IProject[];
}

export class RiskFormState implements IRiskFormState {
    public LastSignedOffRiskUpdate = null;
    public FilteredDirectorates = [];
    public FilteredProjects = [];
}

export class RiskFormInner extends React.Component<IRiskFormInnerProps, IRiskFormState> {

    constructor(props: IRiskFormInnerProps) {
        super(props);
        this.state = new RiskFormState();
    }

    public render(): React.ReactElement {
        const { orbUserContext: { userContext }, dataContext: { dataServices, lookupData } } = this.props;

        const validateEntity = (risk: ICorporateRisk): Promise<RiskValidations> => {
            const errors = new RiskValidations();

            if (risk.Title === null || risk.Title === '') {
                errors.Title = 'Risk name is required';
                errors.Valid = false;
            }
            else {
                errors.Title = null;
            }

            if (risk.RiskRegisterID === null) {
                errors.RiskRegisterID = 'Register is required';
                errors.Valid = false;
            }
            else {
                errors.RiskRegisterID = null;
            }

            if (risk.DirectorateID === null) {
                errors.DirectorateID = 'Directorate is required';
                errors.Valid = false;
            }
            else {
                errors.DirectorateID = null;
            }

            if (risk.IsProjectRisk && risk.ProjectID === null) {
                errors.ProjectID = 'Project is required';
                errors.Valid = false;
            }
            else {
                errors.ProjectID = null;
            }

            if (risk.RiskOwnerUserID === null) {
                errors.RiskOwnerUserID = 'Risk owner is required';
                errors.Valid = false;
            }
            else {
                errors.RiskOwnerUserID = null;
            }

            if (risk.ID === 0 && risk.RiskProximity !== null && risk.RiskProximity < new Date()) {
                errors.RiskProximity = 'Risk proximity cannot be in the past';
                errors.Valid = false;
            } else {
                errors.RiskProximity = null;
            }

            if (risk.Contributors.some(ct => ct.ContributorUserID === risk.RiskOwnerUserID)) {
                errors.NormalContributors = 'A user cannot be both the lead and a contributor';
                errors.Valid = false;
            }
            else {
                errors.NormalContributors = null;
            }

            return Promise.resolve(errors);
        };

        const today = new Date();
        return (
            <EntityForm<ICorporateRisk, RiskValidations>
                {...this.props}
                entityName="Risk"
                renderFormFields={(changeHandlers, formState) => {
                    const { FormData: risk, ValidationErrors: errors } = formState;
                    const escalationOptions = this.getRegisterOptions(risk, this.state.LastSignedOffRiskUpdate, lookupData.RiskRegisters, formState.FormDataBeforeChanges);
                    const mappedUsers = LookupService.riskUsers(lookupData, risk);
                    const suggestions = {
                        initialSuggestionsHeaderText:
                            risk.IsProjectRisk && risk.ProjectID ? `Project users` :
                                risk.DirectorateID ? `Directorate and group users` : null,
                        initialSuggestions: mappedUsers,
                        noResultsFoundText:
                            mappedUsers.length === 0 ?
                                risk.IsProjectRisk && risk.ProjectID ? `No users are mapped to this risk's project` :
                                    risk.DirectorateID ? `No users are mapped to this risk's directorate or group` : null : null
                    };
                    const nowPlusOneMonth = new Date(Date.UTC(today.getFullYear(), today.getMonth() + 1, 0)); // AL: Not sure why this was implemented like this

                    return (
                        <>
                            <CrTextField
                                label="Risk name"
                                required={true}
                                maxLength={255}
                                className={styles.formField}
                                value={risk.Title}
                                onChange={v => changeHandlers.changeTextField(v, 'Title')}
                                errorMessage={errors.Title}
                                disabled={(this.isNameDisabled(risk)) || (risk.IsProjectRisk && risk.Attributes.filter(x => x.AttributeTypeID===1000).length > 0)}
                            />
                            <CrChoiceGroup
                                label="Register"
                                required={true}
                                disabled={this.isRegisterDisabled() || (risk.IsProjectRisk && risk.Attributes.filter(x => x.AttributeTypeID===1000).length > 0)}
                                className={styles.formField}
                                options={escalationOptions}
                                selectedKey={risk.RiskRegisterID?.toString()}
                                onChange={(_, option) => changeHandlers.changeChoiceGroup(option, 'RiskRegisterID')}
                                errorMessage={errors.RiskRegisterID || (escalationOptions.length === 0 && 'You do not have permission to create a risk in any register')}
                            />
                            <CrDatePicker
                                label="Date risk created"
                                className={styles.formField}
                                value={risk.RiskRegisteredDate}
                                onSelectDate={date => changeHandlers.changeDatePicker(date, 'RiskRegisteredDate')}
                                disabled={risk.IsProjectRisk && risk.Attributes.filter(x => x.AttributeTypeID===1000).length > 0}
                            />
                            <CrDropdown
                                label="Directorate"
                                className={styles.formField}
                                required={true}
                                disabled={(this.isDirectorateDisabled()) || (risk.IsProjectRisk && risk.Attributes.filter(x => x.AttributeTypeID===1000).length > 0)}
                                options={this.getDirectorateOptions(lookupData.Directorates, risk)}
                                selectedKey={risk.DirectorateID}
                                onChange={(_, o) => this.changeDirectorateDropdown(o, changeHandlers)}
                                errorMessage={errors.DirectorateID}
                            />
                            <CrCheckbox
                                label="Is this a project risk?"
                                className={styles.formField}
                                styles={{ label: { paddingTop: '5px' } }}
                                checked={risk.IsProjectRisk}
                                onChange={(_, isChecked) => this.changeIsProjectRiskCheckbox(isChecked, changeHandlers)}
                                disabled={risk.IsProjectRisk && risk.Attributes.filter(x => x.AttributeTypeID===1000).length > 0}
                            />
                            {risk.IsProjectRisk &&
                                <CrComboBox
                                    label="Project"
                                    className={styles.formField}
                                    required={true}
                                    options={this.getProjectOptions(this.state.FilteredProjects)}
                                    selectedKey={risk.ProjectID}
                                    onChange={(_, v) => changeHandlers.changeDropdown(v, 'ProjectID')}
                                    errorMessage={errors.ProjectID}
                                    disabled={risk.IsProjectRisk && risk.Attributes.filter(x => x.AttributeTypeID===1000).length > 0}
                                />
                            }
                            <CrUserPicker
                                label="Risk owner (approver)"
                                required={true}
                                className={styles.formField}
                                disabled={!risk.DirectorateID && !risk.ProjectID}
                                users={mappedUsers}
                                selectedUsers={risk.RiskOwnerUserID && [risk.RiskOwnerUserID]}
                                onChange={u => changeHandlers.changeUserPicker(u, 'RiskOwnerUserID')}
                                errorMessage={errors.RiskOwnerUserID}
                                {...suggestions}
                            />
                            <CrUserPicker
                                label="Alternative risk approver"
                                required={false}
                                className={styles.formField}
                                disabled={!risk.DirectorateID && !risk.ProjectID}
                                users={mappedUsers}
                                selectedUsers={risk.ReportApproverUserID && [risk.ReportApproverUserID]}
                                onChange={u => changeHandlers.changeUserPicker(u, 'ReportApproverUserID')}
                                {...suggestions}
                            />
                            <CrUserPicker
                                label="Contributors"
                                className={styles.formField}
                                disabled={!risk.DirectorateID && !risk.ProjectID}
                                users={mappedUsers}
                                itemLimit={6}
                                selectedUsers={risk.Contributors?.map(c => c.ContributorUserID)}
                                onChange={v => changeHandlers.changeMultiUserPicker(v, 'Contributors', new Contributor(), 'ContributorUserID')}
                                errorMessage={errors.NormalContributors}
                                {...suggestions}
                            />
                            <CrDropdown
                                label="Risk type"
                                className={styles.formField}
                                multiSelect
                                options={LookupService.entitiesToSelectableOptions(lookupData.RiskTypes)}
                                selectedKeys={risk.RiskRiskTypes?.map(r => r.RiskTypeID)}
                                onChange={(_, v) => changeHandlers.changeMultiDropdown(v, 'RiskRiskTypes', new RiskRiskType(), 'RiskTypeID')}
                                disabled={risk.IsProjectRisk && risk.Attributes.filter(x => x.AttributeTypeID===1000).length > 0}
                            />
                            {risk.RiskRegisterID !== RiskRegister.Departmental &&
                                <CrEntityPicker
                                    label="Linked risk"
                                    className={styles.formField}
                                    itemLimit={1}
                                    required={false}
                                    entities={this.getAvailableRisksForLinking(risk)}
                                    selectedEntities={risk.LinkedRiskID && [risk.LinkedRiskID]}
                                    onChange={v => changeHandlers.changeUserPicker(v, 'LinkedRiskID')}
                                    disabled={risk.IsProjectRisk && risk.Attributes.filter(x => x.AttributeTypeID===1000).length > 0}
                                />
                            }
                            <CrTextField
                                label="Risk event description"
                                maxLength={750}
                                rows={6}
                                multiline
                                className={styles.formField}
                                value={risk.RiskEventDescription}
                                onChange={v => changeHandlers.changeTextField(v, 'RiskEventDescription')}
                                disabled={risk.IsProjectRisk && risk.Attributes.filter(x => x.AttributeTypeID===1000).length > 0}
                            />
                            <CrTextField
                                label="Risk cause description"
                                maxLength={750}
                                rows={6}
                                multiline
                                className={styles.formField}
                                value={risk.RiskCauseDescription}
                                onChange={v => changeHandlers.changeTextField(v, 'RiskCauseDescription')}
                                disabled={risk.IsProjectRisk && risk.Attributes.filter(x => x.AttributeTypeID===1000).length > 0}
                            />
                            <CrTextField
                                label="Risk impact description"
                                maxLength={750}
                                rows={6}
                                multiline
                                className={styles.formField}
                                value={risk.RiskImpactDescription}
                                onChange={v => changeHandlers.changeTextField(v, 'RiskImpactDescription')}
                                disabled={risk.IsProjectRisk && risk.Attributes.filter(x => x.AttributeTypeID===1000).length > 0}
                            />
                            <CrDropdown
                                label="Unmitigated probability"
                                className={styles.formField}
                                options={LookupService.entitiesToSelectableOptionsFilteredByDate(nowPlusOneMonth, lookupData.RiskProbabilities)}
                                selectedKey={risk.UnmitigatedRiskProbabilityID}
                                onChange={(_, v) => changeHandlers.changeDropdown(v, 'UnmitigatedRiskProbabilityID')}
                                disabled={risk.IsProjectRisk && risk.Attributes.filter(x => x.AttributeTypeID===1000).length > 0}
                            />
                            <CrDropdown
                                label="Unmitigated impact"
                                className={styles.formField}
                                options={LookupService.entitiesToSelectableOptionsFilteredByDate(nowPlusOneMonth, lookupData.RiskImpactLevels)}
                                selectedKey={risk.UnmitigatedRiskImpactLevelID}
                                onChange={(_, v) => changeHandlers.changeDropdown(v, 'UnmitigatedRiskImpactLevelID')}
                                disabled={risk.IsProjectRisk && risk.Attributes.filter(x => x.AttributeTypeID===1000).length > 0}
                            />
                            <CrDropdown
                                label="Target probability"
                                className={styles.formField}
                                options={LookupService.entitiesToSelectableOptionsFilteredByDate(nowPlusOneMonth, lookupData.RiskProbabilities)}
                                selectedKey={risk.TargetRiskProbabilityID}
                                onChange={(_, v) => changeHandlers.changeDropdown(v, 'TargetRiskProbabilityID')}
                                disabled={risk.IsProjectRisk && risk.Attributes.filter(x => x.AttributeTypeID===1000).length > 0}
                            />
                            <CrDropdown
                                label="Target impact"
                                className={styles.formField}
                                options={LookupService.entitiesToSelectableOptionsFilteredByDate(nowPlusOneMonth, lookupData.RiskImpactLevels)}
                                selectedKey={risk.TargetRiskImpactLevelID}
                                onChange={(_, v) => changeHandlers.changeDropdown(v, 'TargetRiskImpactLevelID')}
                                disabled={risk.IsProjectRisk && risk.Attributes.filter(x => x.AttributeTypeID===1000).length > 0}
                            />
                            <CrCheckbox
                                label="Is the risk ongoing?"
                                className={styles.formField}
                                checked={risk.RiskIsOngoing}
                                onChange={(_, isChecked) => this.changeOngoingCheckbox(isChecked, changeHandlers)}
                                disabled={risk.IsProjectRisk && risk.Attributes.filter(x => x.AttributeTypeID===1000).length > 0}
                            />
                            <CrDatePicker
                                label="What is the proximity of this risk/when do you expect this risk to materialise?"
                                className={styles.formField}
                                disabled={(risk.RiskIsOngoing) || (risk.IsProjectRisk && risk.Attributes.filter(x => x.AttributeTypeID===1000).length > 0)}
                                value={risk.RiskProximity}
                                onSelectDate={v => changeHandlers.changeDatePicker(v, 'RiskProximity')}
                                minDate={risk.ID === 0 && new Date()}
                                errorMessage={errors.RiskProximity}
                                
                            />
                            <CrDropdown
                                label="Which Departmental Objective will this most impact?"
                                className={styles.formField}
                                options={LookupService.entitiesToSelectableOptions(lookupData.DepartmentalObjectives)}
                                selectedKey={risk.DepartmentalObjectiveID}
                                onChange={(_, v) => changeHandlers.changeDropdown(v, 'DepartmentalObjectiveID')}
                                disabled={risk.IsProjectRisk && risk.Attributes.filter(x => x.AttributeTypeID===1000).length > 0}
                            />
                            <CrMultiDropdownWithText
                                label="Attributes"
                                className={styles.formField}
                                textMaxLength={255}
                                options={LookupService.attributeTypesToMultiDropdownWithTextOptions(lookupData.AttributeTypes)}
                                selectedItems={LookupService.attributesToDropdownWithText(risk.Attributes)}
                                onChange={v => changeHandlers.changeMultiDropdownWithText(v, 'Attributes', new Attribute(), 'AttributeTypeID', 'AttributeValue')}
                            />
                            {(formState.FormDataBeforeChanges.EntityStatusID === EntityStatus.Closed
                                || dataServices.riskPermissionsService.RiskCanBeClosed(userContext.UserEntities, risk, this.state.LastSignedOffRiskUpdate)) &&
                                <CrDropdown
                                    label="Status"
                                    className={styles.formField}
                                    options={LookupService.entitiesToSelectableOptions(lookupData.EntityStatuses)}
                                    selectedKey={risk.EntityStatusID}
                                    onChange={(_, o) => changeHandlers.changeDropdown(o, 'EntityStatusID')}
                                />
                            }
                        </>
                    );
                }}
                loadEntity={id => dataServices.corporateRiskService.read(id, true, true)}
                loadNewEntity={() => new CorporateRisk()}
                onAfterLoad={risk => {
                    if (risk.DirectorateID)
                        this.setState({ FilteredProjects: lookupData.Projects.filter(p => p.DirectorateID === risk.DirectorateID) });
                }}
                loadEntityValidations={() => new RiskValidations()}
                onValidateEntity={validateEntity}
                onBeforeSave={risk => { delete risk.Directorate; delete risk.Attributes; }}
                onCreate={r => dataServices.corporateRiskService.create(r)}
                onUpdate={r => dataServices.corporateRiskService.update(r.ID, r)}
                parentEntities={dataServices.corporateRiskService.parentEntities}
                childEntities={[
                    {
                        ObjectParentProperty: 'RiskRiskTypes',
                        ParentIdProperty: 'RiskID',
                        ChildIdProperty: 'RiskTypeID',
                        ChildService: dataServices.riskRiskTypeService
                    },
                    {
                        ObjectParentProperty: 'Contributors',
                        ParentIdProperty: 'RiskID',
                        ChildIdProperty: 'ContributorUserID',
                        ChildService: dataServices.contributorService
                    },
                    {
                        ObjectParentProperty: 'Attributes',
                        ParentIdProperty: 'RiskID',
                        ChildIdProperty: 'AttributeTypeID',
                        ChildService: dataServices.attributeService
                    }
                ]}
            />
        );
    }

    public componentDidMount(): void {
        this.loadLastSignedOffRiskUpdate();
        const { loadLookupData: lld } = this.props.dataContext;
        lld?.attributeTypes();
        lld?.corporateRisks();
        lld?.departmentalObjectives();
        lld?.directorates();
        lld?.entityStatuses();
        lld?.projects();
        lld?.riskImpactLevels();
        lld?.riskProbabilities();
        lld?.riskRegisters();
        lld?.riskTypes();
        lld?.userDirectorates();
        lld?.userGroups();
        lld?.userProjects();
        lld?.users.all();
    }

    public componentDidUpdate(prevProps: ISpecificEntityFormProps): void {
        if (prevProps.entityId !== this.props.entityId) {
            this.loadLastSignedOffRiskUpdate();
        }
    }

    private loadLastSignedOffRiskUpdate = async (): Promise<IRiskUpdate[]> => {
        try {
            const ru = await this.props.dataContext.dataServices.corporateRiskUpdateService.readLatestSignedOffUpdate(this.props.entityId);
            this.setState({ LastSignedOffRiskUpdate: ru });
            return [ru];
        } catch (err) {
            this.props.errorHandling?.onError(`Error loading latest risk update`, err.message);
        }
    }

    private changeDirectorateDropdown = (option: IDropdownOption, changeHandlers: IEntityFormChangeHandlers<IRisk>): void => {
        this.setState({ FilteredProjects: this.props.dataContext.lookupData.Projects.filter(p => p.DirectorateID === option.key) });
        changeHandlers.changeDropdown(option, 'DirectorateID', null, () => changeHandlers.clearField('ProjectID'));
    }

    private changeIsProjectRiskCheckbox = (isChecked: boolean, changeHandlers: IEntityFormChangeHandlers<IRisk>): void => {
        changeHandlers.changeCheckbox(isChecked, 'IsProjectRisk', () => isChecked || changeHandlers.clearField('ProjectID'));
    }

    private changeOngoingCheckbox = (isChecked: boolean, changeHandlers: IEntityFormChangeHandlers<IRisk>) => {
        if (isChecked)
            changeHandlers.changeCheckbox(isChecked, 'RiskIsOngoing', () => changeHandlers.clearField('RiskProximity'));
        else
            changeHandlers.changeCheckbox(isChecked, 'RiskIsOngoing');
    }

    private getRegisterOptions(risk: IRisk, lastRiskUpdate: IRiskUpdate, registers: IEntity[], formDataBeforeChanges: IRisk): IChoiceGroupOption[] {
        if (risk.ID === 0) {
            const registerIDs = this.props.dataContext.dataServices.riskPermissionsService.RiskCanBeCreatedInRegisters(this.props.orbUserContext.userContext.UserEntities);
            return LookupService.entitiesToChoiceGroupOptions(registers.filter(r => registerIDs.indexOf(r.ID) !== -1));
        } else {
            const registerIDs = this.props.dataContext.dataServices.riskPermissionsService.RiskCanBeEscalatedToRegisters(this.props.orbUserContext.userContext.UserEntities, risk, lastRiskUpdate);
            registerIDs.push(formDataBeforeChanges.RiskRegisterID);
            return LookupService.entitiesToChoiceGroupOptions(registers.filter(r => registerIDs.indexOf(r.ID) !== -1));
        }
    }

    private getDirectorateOptions(directorates: IDirectorate[], risk: IRisk): IDropdownOption[] {
        const directorateIDs = this.props.dataContext.dataServices.riskPermissionsService.RiskCanBeOwnedByDirectorates(this.props.orbUserContext.userContext.UserEntities, directorates);
        if (risk.DirectorateID) directorateIDs.push(risk.DirectorateID);
        return LookupService.entitiesToSelectableOptions(directorates.filter(d => directorateIDs.indexOf(d.ID) !== -1));
    }

    private getAvailableRisksForLinking(risk: IRisk): IEntity[] {
        // Show risks for the Risk Register level above that for the current Risk
        // Ensure the currently-selected linked risk (if any) is always in the list
        if (risk.RiskRegisterID === RiskRegister.Directorate) {
            return this.props.dataContext.lookupData.CorporateRisks
                .filter(r => r.ID !== risk.LinkedRiskID && r.RiskRegisterID === RiskRegister.Group)
                .concat(this.props.dataContext.lookupData.CorporateRisks.filter(r => r.ID === risk.LinkedRiskID));
        } else if (risk.RiskRegisterID === RiskRegister.Group) {
            return this.props.dataContext.lookupData.CorporateRisks
                .filter(r => r.ID !== risk.LinkedRiskID && r.RiskRegisterID === RiskRegister.Departmental)
                .concat(this.props.dataContext.lookupData.CorporateRisks.filter(r => r.ID === risk.LinkedRiskID));
        }
        return this.props.dataContext.lookupData.CorporateRisks.filter(r => r.ID === risk.LinkedRiskID);
    }

    private getProjectOptions(projects: IProject[]): IDropdownOption[] {
        return LookupService.entitiesToSelectableOptions(projects);
    }

    private isNameDisabled(risk: IRisk): boolean {
        return !this.props.dataContext.dataServices.riskPermissionsService.RiskNameCanBeChanged(this.props.orbUserContext.userContext.UserEntities, risk);
    }

    private isRegisterDisabled(): boolean {
        return !this.props.dataContext.dataServices.riskPermissionsService.RiskRegisterCanBeChanged(this.props.orbUserContext.userContext.UserEntities);
    }

    private isDirectorateDisabled(): boolean {
        return !this.props.dataContext.dataServices.riskPermissionsService.RiskDirectorateCanBeChanged(this.props.orbUserContext.userContext.UserEntities);
    }
}
