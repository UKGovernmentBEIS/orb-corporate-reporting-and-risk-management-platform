import React from 'react';
import {
    CrUpdateFormState, IRiskUpdate, IRisk,
    RiskUpdate, Risk, ProgressUpdateValidations, IEntityProgressUpdateFormProps, IRiskMitigationAction,
    IRiskMitigationActionUpdate, ISignOff
} from '../../types';
import styles from '../../styles/cr.module.scss';
import { CrTextField } from '../cr/CrTextField';
import { ProgressUpdateForm } from '../ProgressUpdateForm';
import { RiskRegister } from '../../refData/RiskRegister';
import { CrDropdown } from '../cr/CrDropdown';
import { RiskRagService, LookupService, DateService, EntityPeopleService, RiskAppetiteService, AttributeService } from '../../services';
import { MessageBar, MessageBarType } from 'office-ui-fabric-react/lib/MessageBar';
import { CrChoiceGroup } from '../cr/CrChoiceGroup';
import { CrCheckbox } from '../cr/CrCheckbox';
import { CrDatePicker } from '../cr/CrDatePicker';
import { AddNewEntityCommandBar } from '../cr/AddNewEntityCommandBar';
import { RiskMitigationActionProgressUpdateReviewList } from '../riskMitigationAction/RiskMitigationActionProgressUpdateReviewList';
import { CrApprovalDetails } from '../cr/CrApprovalDetails';
import { RiskMitigationActionForm } from '../riskMitigationAction/RiskMitigationActionForm';
import { Text } from 'office-ui-fabric-react/lib/Text';
import { IDropdownOption } from 'office-ui-fabric-react/lib/Dropdown';
import { RiskKeyInfo } from './RiskKeyInfo';
import { HyperlinksField } from '../cr/HyperlinksField';
import { CrLabel } from '../cr/CrLabel';
import { DataContext } from '../DataContext';

export class RiskUpdateFormValidations extends ProgressUpdateValidations {
    public Title: string = null;
    public Escalate: string = null;
    public DeEscalate: string = null;
    public RiskProximity: string = null;
}

export interface IParentRiskProgressUpdateFormState {
    RiskMitigationActions: IRiskMitigationAction[];
    RiskMitigationActionUpdates: IRiskMitigationActionUpdate[];
    SignOff: ISignOff;
    ShowChildForm: boolean;
    NotificationsSent: Date;
}

export class RiskProgressUpdateFormState extends CrUpdateFormState<IRiskUpdate, RiskUpdateFormValidations, IRisk> {
    constructor(riskId: number, period: Date, parentEntity?: IRisk, showForm?: boolean) {
        super(
            new RiskUpdate(riskId, period),
            parentEntity || new Risk(),
            new RiskUpdate(),
            new RiskUpdateFormValidations(),
            showForm
        );
    }
}

export class RiskProgressUpdateForm extends React.Component<IEntityProgressUpdateFormProps<IRisk>, IParentRiskProgressUpdateFormState>  {
    static contextType = DataContext;
    context!: React.ContextType<typeof DataContext>;

    constructor(props: IEntityProgressUpdateFormProps<IRisk>) {
        super(props);
        this.state = {
            RiskMitigationActions: [],
            RiskMitigationActionUpdates: [],
            SignOff: null,
            ShowChildForm: false,
            NotificationsSent: null
        };
    }

    public render(): React.ReactElement {
        const { entityId, entity, reportDates, entityUpdateId, defaultShowForm, onSaved, onCancelled } = this.props;
        const { dataServices } = this.context;
        const { NotificationsSent } = this.state;
        const { lookupData } = this.context;

        return (
            <ProgressUpdateForm<IRiskUpdate, RiskUpdateFormValidations, IRisk>
                {...this.props}
                dueDate={() => reportDates?.Next}
                disableSave={risk => risk.IsProjectRisk && risk.Attributes.filter(x => x.AttributeTypeID===1000).length > 0}
                vertoMsg={risk => risk.IsProjectRisk && risk.Attributes.filter(x => x.AttributeTypeID===1000).length > 0}
                
                // parents={r => {
                //     if (r) {
                //         if (r.RiskRegisterID === RiskRegister.Departmental)
                //             return [r.Directorate.Group.Title, r.Directorate.Title];
                //         if (r.RiskRegisterID === RiskRegister.Group)
                //             return [r.Directorate.Group.Title, r.Directorate.Title];
                //         if (r.RiskRegisterID === RiskRegister.Directorate)
                //             return [r.Directorate.Title];
                //     }
                //     return [];
                // }}
                loadPeople={async r => {
                    const people = [];
                    if (r) {
                        people.push(...await EntityPeopleService.GetRiskEntityPeople({
                            riskService: dataServices.corporateRiskService,
                            riskId: r.ID
                        }));
                        if (r.Contributors?.length > 0)
                            people.push({ role: 'Contributors', names: r.Contributors.map(c => c.ContributorUser?.Title) });
                    }
                    return people;
                }}
                title={r => {
                    const title = [];
                    if (r.Title) {
                        if (r.RiskCode) title.push(r.RiskCode);
                        title.push(r.Title);
                        return title.join(' - ');
                    }
                }}
                tags={r => AttributeService.attributesToBadgeStrings(r.Attributes)}
                ragLabel={ru =>
                    `${LookupService.getLookupName(lookupData.RiskImpactLevels, ru.RiskImpactLevelID)}/${LookupService.getLookupName(lookupData.RiskProbabilities, ru.RiskProbabilityID)}`}
                renderFormFields={(
                    { changeCheckbox, changeChoiceGroup, changeColor, changeDatePicker, changeDropdown, changeMultiDropdownStringArray, changeJson, changeNumberField, changeTextField, clearField },
                    { FormData: ru, ParentEntity: r, LastSignedOffUpdate: so, ValidationErrors: errors, FormIsDirty }
                ) => {
                    const currentDueDate = r.RiskProximity;
                    const options: IDropdownOption[] = [
                        { key: 'Risk is now an issue', text: 'Risk is now an issue' },
                        { key: 'Risk no longer exists', text: 'Risk no longer exists' }];
                    return (
                        <div className={styles.cr}>
                            <div className={styles.formField}>
                                <RiskKeyInfo
                                    risk={r}
                                    riskImpactLevels={lookupData.RiskImpactLevels}
                                    riskProbabilities={lookupData.RiskProbabilities}
                                    riskTypes={lookupData.RiskTypes}
                                />
                            </div>
                            <div>
                                {RiskAppetiteService.riskWithinBoundary(lookupData.RiskTypes, ru, r) ||
                                    <div className={`${styles.formField} ${styles.gridRow}`}>
                                        <MessageBar messageBarType={MessageBarType.warning}>
                                            The risk is outside of the departmental risk appetite threshold.
                                            It is recommended that you note this in the narrative update and discuss any implications at your next SMT or Programme Board.
                                        </MessageBar>
                                    </div>
                                }
                                <div className={`${styles.formField} ${styles.gridRow}`}>
                                    <div className={`${styles.gridCol} ${styles.sm12} ${styles.md12} ${styles.lg12} ${styles.xl4}`}>
                                        <CrChoiceGroup
                                            label="Impact level"
                                            className={styles.formField}
                                            history={so.RiskImpactLevel?.Title}
                                            options={LookupService.entitiesToChoiceGroupOptionsFilteredByDate(reportDates?.Next, lookupData.RiskImpactLevels)}
                                            selectedKey={ru.RiskImpactLevelID?.toString()}
                                            onChange={(_, v) => changeChoiceGroup(v, 'RiskImpactLevelID', updatedRu => this.setRag(changeColor, updatedRu))}
                                        />
                                    </div>
                                    <div className={`${styles.gridCol} ${styles.sm12} ${styles.md12} ${styles.lg12} ${styles.xl4}`}>
                                        <CrChoiceGroup
                                            label="Probability"
                                            className={styles.formField}
                                            history={so.RiskProbability?.Title}
                                            options={LookupService.entitiesToChoiceGroupOptionsFilteredByDate(reportDates?.Next, lookupData.RiskProbabilities)}
                                            selectedKey={ru.RiskProbabilityID?.toString()}
                                            onChange={(_, v) => changeChoiceGroup(v, 'RiskProbabilityID', updatedRu => this.setRag(changeColor, updatedRu))}
                                        />
                                    </div>
                                    <div className={`${styles.gridCol} ${styles.sm12} ${styles.md12} ${styles.lg12} ${styles.xl4}`}>
                                        {ru.ToBeClosed ||
                                            <>
                                                <CrLabel text="Risk proximity" />
                                                <CrCheckbox
                                                    label="Is the risk ongoing?"
                                                    className={styles.formField}
                                                    checked={ru.RiskIsOngoing}
                                                    onChange={(_, isChecked) => isChecked ?
                                                        changeCheckbox(isChecked, 'RiskIsOngoing', () => changeDatePicker(null, 'RiskProximity'))
                                                        :
                                                        changeCheckbox(isChecked, 'RiskIsOngoing')
                                                    }
                                                />
                                                <CrDatePicker
                                                    label='What is the proximity of this risk?'
                                                    required={!ru.ToBeClosed && !ru.RiskIsOngoing && (currentDueDate === null || currentDueDate < new Date())}
                                                    className={styles.formField}
                                                    disabled={ru.RiskIsOngoing}
                                                    minDate={new Date()}
                                                    value={ru.RiskProximity}
                                                    onSelectDate={d => changeDatePicker(d, 'RiskProximity')}
                                                    history={so.RiskProximity}
                                                    errorMessage={errors.RiskProximity}
                                                />
                                            </>
                                        }
                                    </div>
                                </div>
                            </div>
                            {r?.RiskRegisterID !== RiskRegister.Departmental &&
                                <>
                                    <CrCheckbox
                                        className={styles.formField}
                                        label="Request that this risk be escalated"
                                        checked={ru.Escalate}
                                        onChange={(_, v) => {
                                            const deescVal = ru.DeEscalate;
                                            changeCheckbox(v, 'Escalate', () =>
                                                changeCheckbox(deescVal ? false : deescVal, 'DeEscalate', () =>
                                                    changeCheckbox(false, 'ToBeClosed', () => v ?
                                                        changeNumberField(this.setDefaultRegister(r), 'EscalateToRiskRegisterID') :
                                                        clearField('EscalateToRiskRegisterID')
                                                    )
                                                )
                                            );
                                        }}
                                        errorMessage={errors.Escalate}
                                    />
                                    {ru.Escalate &&
                                        <>
                                            <CrDropdown
                                                className={styles.formField}
                                                label="Which register you would like the risk to be escalated to?"
                                                required={true}
                                                options={r?.RiskRegisterID === RiskRegister.Directorate || r?.RiskRegisterID === RiskRegister.Project
                                                    ? [
                                                        { key: RiskRegister.Departmental, text: 'Departmental' },
                                                        { key: RiskRegister.Group, text: 'Group' }
                                                    ]
                                                    : [
                                                        { key: RiskRegister.Departmental, text: 'Departmental' }
                                                    ]}
                                                selectedKey={ru.EscalateToRiskRegisterID}
                                                onChange={(_, o) => changeDropdown(o, 'EscalateToRiskRegisterID')}
                                            />
                                            <CrTextField
                                                className={styles.formField}
                                                label="Why should this risk be escalated?"
                                                required={true}
                                                multiline
                                                value={ru.Comment}
                                                maxLength={500}
                                                onChange={v => changeTextField(v, 'Comment')}
                                                errorMessage={errors.Comment}
                                            />
                                        </>
                                    }
                                </>
                            }
                            <CrCheckbox
                                className={styles.formField}
                                label="Request that this risk be discussed"
                                checked={ru.ToBeDiscussed}
                                onChange={(_, v) => changeCheckbox(v, 'ToBeDiscussed')}
                                errorMessage={errors.Escalate}
                            />
                            {ru.ToBeDiscussed &&
                                <CrDropdown
                                    multiSelect
                                    className={styles.formField}
                                    label="Where would you like the risk to be discussed?"
                                    options={LookupService.arrayToDropdownOptions([...new Set([
                                        ...lookupData.RiskDiscussionForums?.map(f => f.Title),
                                        ...ru.DiscussionForum
                                    ])])}
                                    selectedKeys={ru.DiscussionForum}
                                    onChange={(_, o) => changeMultiDropdownStringArray(o, 'DiscussionForum')}
                                />
                            }
                            {r?.RiskRegisterID !== RiskRegister.Directorate &&
                                <CrCheckbox
                                    className={styles.formField}
                                    label="Request that this risk be de-escalated"
                                    checked={ru.DeEscalate}
                                    onChange={(_, v) => {
                                        const escVal = ru.Escalate;
                                        changeCheckbox(v, 'DeEscalate', () =>
                                            changeCheckbox(escVal ? false : escVal, 'Escalate', () =>
                                                clearField('EscalateToRiskRegisterID', () =>
                                                    changeCheckbox(false, 'ToBeClosed')
                                                )
                                            )
                                        );
                                    }}
                                    errorMessage={errors.DeEscalate}
                                />
                            }
                            {ru.DeEscalate &&
                                <CrTextField
                                    className={styles.formField}
                                    label="Why should this risk be de-escalated?"
                                    required={true}
                                    multiline
                                    value={ru.Comment}
                                    maxLength={500}
                                    onChange={v => changeTextField(v, 'Comment')}
                                    errorMessage={errors.Comment}
                                />
                            }
                            <CrCheckbox
                                className={styles.formField}
                                label="Mark this risk for closure"
                                checked={ru.ToBeClosed}
                                onChange={(_, v) =>
                                    changeCheckbox(v, 'ToBeClosed', () =>
                                        changeCheckbox(false, 'Escalate', () =>
                                            clearField('EscalateToRiskRegisterID', () =>
                                                changeCheckbox(false, 'DeEscalate')
                                            )
                                        )
                                    )
                                }
                            />
                            {ru.ToBeClosed &&
                                <CrDropdown label="Select reason for closure"
                                    className={styles.formField}
                                    required={true}
                                    options={options}
                                    selectedKey={ru.ClosureReason}
                                    onChange={(_, v) => changeDropdown(v, 'ClosureReason')}
                                />
                            }
                            {ru.ToBeClosed &&
                                <CrTextField className={styles.formField}
                                    label="Why has this risk been closed?"
                                    required={true}
                                    multiline
                                    value={ru.Comment}
                                    maxLength={500}
                                    placeholder={`Please provide a reason the risk can no longer happen.` +
                                        ` For example has it become an issue or the activity that created the risk has been terminated (e.g project closure)`}
                                    onChange={v => changeTextField(v, 'Comment')}
                                    errorMessage={errors.Comment}
                                />
                            }
                            <br />
                            <CrTextField
                                label="Narrative"
                                className={styles.formField}
                                placeholder="Please describe how you have come to the overall rating for this risk?"
                                multiline
                                rows={2}
                                maxLength={750}
                                charCounter={true}
                                value={ru.Narrative}
                                onChange={v => changeTextField(v, 'Narrative')}
                                history={so.Narrative}
                            />
                            <HyperlinksField
                                label="Attachments"
                                description="Add links to any supporting documents or files"
                                className={styles.formField}
                                addEditLinkHelpText="Please ensure access to the linked file is possible for those who will need to review it."
                                links={ru.Attachments}
                                onChange={attachments => changeJson(attachments, 'Attachments')}
                            />
                            <AddNewEntityCommandBar
                                className={styles.crCommandBarFloating}
                                onAdd={() => this.setState({ ShowChildForm: true })}
                            />
                            {this.state.ShowChildForm &&
                                <RiskMitigationActionForm
                                    {...this.props}
                                    maxDependentRisks={1}
                                    entityId={null}
                                    showForm={this.state.ShowChildForm}
                                    onSaved={this.childEntitySaved}
                                    onCancelled={this.closeChildPanel}
                                    defaultValues={[{ field: 'RiskID', value: r.ID }]}
                                />
                            }
                            <RiskMitigationActionProgressUpdateReviewList
                                {...this.props}
                                entities={this.state.RiskMitigationActions.map(a => ({ ...a, RiskMitigationActionUpdates: this.state.RiskMitigationActionUpdates.filter(u => u.RiskMitigationActionID === a.ID) }))}
                                previousEntities={[]}
                                reportDates={reportDates}
                                risk={entity}
                                hideClosedNoUpdates={true}
                                onChange={() => {
                                    changeCheckbox(ru.RiskIsOngoing, 'RiskIsOngoing'); // Force FormIsDirty
                                    this.loadRiskMitigationActionUpdates(this.state.RiskMitigationActions, reportDates?.Next);
                                }}
                                riskService={dataServices.corporateRiskService}
                                riskActionService={dataServices.corporateRiskMitigationActionService}
                                riskActionUpdateService={dataServices.corporateRiskMitigationActionUpdateService}
                            />
                            {(ru?.Escalate || ru?.DeEscalate || ru?.ToBeClosed) &&
                                <div>
                                    <div style={{ display: 'flex' }}>
                                        <div style={{ display: 'flex', alignItems: 'center', marginRight: '20px' }}>
                                            <div>
                                                <CrCheckbox
                                                    label="Send&nbsp;notifications?"
                                                    className={styles.formField}
                                                    checked={ru.SendNotifications}
                                                    onChange={(_, checked) => changeCheckbox(checked, 'SendNotifications')}
                                                />
                                                {NotificationsSent &&
                                                    <div className={styles.checkbox}>
                                                        <Text>Notifications&nbsp;sent:&nbsp;{DateService.dateToUkDate(NotificationsSent)}</Text>
                                                    </div>
                                                }
                                            </div>
                                        </div>
                                        <div>
                                            <p>This will notify colleagues that you have marked the risk for escalation, de-escalation or closure.</p>
                                            <p>When your updates are complete, your risk will only be actioned once you have notified colleagues.</p>
                                            <p>You can save your update without notifying other colleagues by leaving this checkbox unticked.</p>
                                        </div>
                                    </div>
                                </div>
                            }
                            {!FormIsDirty && this.state.SignOff &&
                                <CrApprovalDetails
                                    approverName={this.state.SignOff.SignOffUser?.Title}
                                    approvalDate={this.state.SignOff.SignOffDate}
                                />
                            }
                        </div>
                    );
                }}
                loadEntity={rId => dataServices.corporateRiskService.read(rId, true, true)}
                loadEntityUpdate={ruId =>
                    dataServices.corporateRiskUpdateService
                        .read(ruId)
                        .then(ru => {
                            if (ru) {
                                if (ru.SendNotifications) this.setState({ NotificationsSent: ru.UpdateDate });
                                ru.SendNotifications = false;
                            }
                            return ru;
                        })}
                loadNewEntityUpdate={() => new RiskUpdate(entityId)}
                loadLastSavedProgressUpdate={() => reportDates?.Next &&
                    dataServices.corporateRiskUpdateService
                        .readLatestUpdateForPeriod(entityId, reportDates.Next)
                        .then(ru => {
                            if (ru) {
                                if (ru.SendNotifications) this.setState({ NotificationsSent: ru.UpdateDate });
                                ru.SendNotifications = false;
                            }
                            return ru;
                        })}
                loadLastSignedOffEntityUpdate={() => reportDates?.Previous &&
                    dataServices.corporateRiskUpdateService.readLastSignedOffUpdateForPeriod(entityId, reportDates.Previous)}
                onFormOpened={() => this.loadActionsAndUpdates(entityId, reportDates?.Next)}
                onValidateUpdate={this.validateRiskProgressUpdate}
                onBeforeSave={(ru, r) => {
                    ru.Title = r.Title;
                    ru.RiskRegisterID = r.RiskRegisterID;
                    ru.RiskMitigationActionUpdates = JSON.stringify(this.state.RiskMitigationActionUpdates.map(u => u.ID));
                    ru.RiskCode = r.RiskCode;

                    delete ru.RiskImpactLevel;
                    delete ru.RiskProbability;
                }}
                onSaveUpdate={ru => dataServices.corporateRiskUpdateService.create(ru)}
                onAfterSave={ru => {
                    if (ru.SendNotifications) this.setState({ NotificationsSent: ru.UpdateDate });
                }}
                onClearForm={(r, showForm) => {
                    this.loadRiskMitigationActionUpdates(this.state.RiskMitigationActions, reportDates?.Next);
                    return new RiskProgressUpdateFormState(entityId, reportDates?.Next, r, showForm);
                }}
                entityId={entityId}
                entityUpdateId={entityUpdateId}
                reportDates={reportDates}
                entity={entity}
                defaultShowForm={defaultShowForm}
                onSaved={onSaved}
                onCancelled={onCancelled}
                reportingFrequencies={lookupData?.ReportingFrequencies}
            />
        );
    }

    public componentDidMount(): void {
        const { loadLookupData: lld } = this.context;
        lld?.corporateRisks();
        lld?.reportingFrequencies();
        lld?.riskDiscussionForums();
        lld?.riskImpactLevels();
        lld?.riskProbabilities();
        lld?.riskTypes();
    }

    private loadActionsAndUpdates = async (riskId: number, signOffPeriod: Date): Promise<void> => {
        const actions = await this.loadRiskMitigationActions(riskId);
        this.loadRiskMitigationActionUpdates(actions, signOffPeriod);
    }

    private loadRiskMitigationActions = async (riskId: number): Promise<IRiskMitigationAction[]> => {
        try {
            const riskMitigationActions = await this.context.dataServices.corporateRiskMitigationActionService.readMitigationActionsForRisk(riskId);
            if (riskMitigationActions) {
                this.setState({ RiskMitigationActions: riskMitigationActions });
                return riskMitigationActions;
            }
        } catch (err) {
            this.props.errorHandling?.onError(`Error loading risk mitigation actions`, err.message);
        }
    }

    private loadRiskMitigationActionUpdates = (riskMitigationActions: IRiskMitigationAction[], period: Date): Promise<IRiskMitigationActionUpdate[]> => {
        const rmaus = [];
        try {
            this.setState({ RiskMitigationActionUpdates: [] },
                () => riskMitigationActions.forEach(rma => rmaus.push(this.loadRiskMitigationActionUpdate(rma, period))));
            return Promise.all(rmaus);
        } catch (err) {
            this.props.errorHandling?.onError(`Error loading risk mitigation action updates`, err.message);
        }
    }

    private loadRiskMitigationActionUpdate = async (riskMitigationAction: IRiskMitigationAction, period: Date): Promise<IRiskMitigationActionUpdate> => {
        const rmau = await this.context.dataServices.corporateRiskMitigationActionUpdateService.readLatestUpdateForPeriod(riskMitigationAction.ID, period);
        if (rmau) {
            this.setState(state => ({ RiskMitigationActionUpdates: [...state.RiskMitigationActionUpdates, rmau] }));
            return rmau;
        }
    }

    private setRag = (changeColor: (colorId: number, fieldName: string) => void, ru: IRiskUpdate): void => {
        if (ru.RiskImpactLevelID && ru.RiskProbabilityID) {
            changeColor(RiskRagService.calculateRiskRag(ru.RiskImpactLevelID, ru.RiskProbabilityID), 'RagOptionID');
        }
    }

    private setDefaultRegister = (risk: IRisk): RiskRegister => {
        return risk?.RiskRegisterID === RiskRegister.Directorate || risk?.RiskRegisterID === RiskRegister.Project ? RiskRegister.Group : RiskRegister.Departmental;
    }

    private childEntitySaved = (): void => {
        this.closeChildPanel();
        this.loadRiskMitigationActions(this.props.entityId);
    }

    private closeChildPanel = (): void => {
        this.setState({ ShowChildForm: false });
    }

    private validateRiskProgressUpdate = (ru: IRiskUpdate, r: IRisk): Promise<RiskUpdateFormValidations> => {
        const errors = new RiskUpdateFormValidations();
        const currentDueDate = r.RiskProximity;

        if (ru.Escalate && ru.DeEscalate) {
            errors.DeEscalate = 'Select only Escalate, De-escalate or neither';
            errors.Valid = false;
        }
        else
            errors.DeEscalate = null;

        if (ru.Comment === null || ru.Comment === '') {
            if (ru.Escalate || ru.DeEscalate) {
                errors.Comment = 'Escalation/de-escalation narrative is required';
                errors.Valid = false;
            }
            else if (ru.ToBeClosed) {
                errors.Comment = 'Closure narrative is required';
                errors.Valid = false;
            } else
                errors.Comment = null;
        }
        else
            errors.Comment = null;

        if (ru.Escalate && r.RiskOwnerUserID === null) {
            errors.Escalate = 'Only a risk with a risk owner can be escalated/de-escalated. Please select a risk owner and try again';
            errors.Valid = false;
        }

        if (ru.DeEscalate && r.RiskOwnerUserID === null) {
            errors.DeEscalate = 'Only a risk with a risk owner can be escalated/de-escalated. Please select a risk owner and try again';
            errors.Valid = false;
        }

        if (!ru.ToBeClosed && !ru.RiskIsOngoing && (currentDueDate === null || currentDueDate !== null && currentDueDate < new Date()) && ru.RiskProximity === null) {
            errors.RiskProximity = 'Risk proximity is required';
            errors.Valid = false;
        } else if (!ru.ToBeClosed && ru.RiskProximity !== null && ru.RiskProximity < new Date()) {
            errors.RiskProximity = 'Risk proximity date cannot be in the past';
            errors.Valid = false;
        } else errors.RiskProximity = null;

        return Promise.resolve(errors);
    }
}
