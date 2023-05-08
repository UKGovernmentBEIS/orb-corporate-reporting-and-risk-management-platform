import React from 'react';
import {
    CrUpdateFormState, IPartnerOrganisationRiskUpdate, IPartnerOrganisationRisk,
    PartnerOrganisationRiskUpdate, PartnerOrganisationRisk, ProgressUpdateValidations,
    IEntityProgressUpdateFormProps, IPartnerOrganisationRiskMitigationAction,
    IPartnerOrganisationRiskMitigationActionUpdate, ISignOff
} from '../../types';
import styles from '../../styles/cr.module.scss';
import { CrTextField } from '../cr/CrTextField';
import { ProgressUpdateForm, IProgressUpdateFormChangeHandlers } from '../ProgressUpdateForm';
import { RiskRagService, LookupService, EntityPeopleService, ContributorService } from '../../services';
import { CrChoiceGroup } from '../cr/CrChoiceGroup';
import { CrCheckbox } from '../cr/CrCheckbox';
import { CrDatePicker } from '../cr/CrDatePicker';
import {
    PartnerOrganisationRiskMitigationActionProgressUpdateReviewList
} from '../partnerOrganisationRiskMitigationAction/PartnerOrganisationRiskMitigationActionProgressUpdateReviewList';
import { CrApprovalDetails } from '../cr/CrApprovalDetails';
import { PartnerOrganisationRiskKeyInfo } from './PartnerOrganisationRiskKeyInfo';
import { DataContext } from '../DataContext';
import { OrbUserContext } from '../OrbUserContext';
import { IUseUserContextProps } from '../useUserContext';
import { IUseDataContextProps } from '../useDataContext';

// Add wrapper to enable use of multiple contexts in class component
export const PartnerOrganisationRiskProgressUpdateForm = (props: IEntityProgressUpdateFormProps<IPartnerOrganisationRisk>): React.ReactElement =>
    <OrbUserContext.Consumer>
        {orbUserContext =>
            <DataContext.Consumer>
                {dataContext =>
                    <PartnerOrganisationRiskProgressUpdateFormInner orbUserContext={orbUserContext} dataContext={dataContext} {...props} />
                }
            </DataContext.Consumer>
        }
    </OrbUserContext.Consumer>

export class PartnerOrganisationRiskUpdateFormValidations extends ProgressUpdateValidations {
    public Title: string = null;
    public RiskProximity: string = null;
}

export interface IParentPartnerOrganisationRiskProgressUpdateFormState {
    PartnerOrganisationRiskMitigationActions: IPartnerOrganisationRiskMitigationAction[];
    PartnerOrganisationRiskMitigationActionUpdates: IPartnerOrganisationRiskMitigationActionUpdate[];
    SignOff: ISignOff;
    ShowChildForm: boolean;
}

export class PartnerOrganisationRiskProgressUpdateFormState
    extends CrUpdateFormState<IPartnerOrganisationRiskUpdate, PartnerOrganisationRiskUpdateFormValidations, IPartnerOrganisationRisk> {
    constructor(partnerOrganisationRiskId: number, period: Date, parentEntity?: IPartnerOrganisationRisk, showForm?: boolean) {
        super(
            new PartnerOrganisationRiskUpdate(partnerOrganisationRiskId, period),
            parentEntity || new PartnerOrganisationRisk(),
            new PartnerOrganisationRiskUpdate(),
            new PartnerOrganisationRiskUpdateFormValidations(),
            showForm
        );
    }
}

export interface IPartnerOrganisationRiskProgressUpdateFormInnerProps extends IEntityProgressUpdateFormProps<IPartnerOrganisationRisk> {
    orbUserContext: IUseUserContextProps;
    dataContext: IUseDataContextProps;
}

export class PartnerOrganisationRiskProgressUpdateFormInner
    extends React.Component<IPartnerOrganisationRiskProgressUpdateFormInnerProps, IParentPartnerOrganisationRiskProgressUpdateFormState>  {

    constructor(props: IPartnerOrganisationRiskProgressUpdateFormInnerProps) {
        super(props);
        this.state = {
            PartnerOrganisationRiskMitigationActions: [],
            PartnerOrganisationRiskMitigationActionUpdates: [],
            SignOff: null,
            ShowChildForm: false
        };
    }
    

    public render(): React.ReactElement {
        const { dataContext: { dataServices, lookupData }, entityId, entity, reportDates,
            entityUpdateId, defaultShowForm, onSaved, onCancelled } = this.props;

        return (
            <ProgressUpdateForm<IPartnerOrganisationRiskUpdate, PartnerOrganisationRiskUpdateFormValidations, IPartnerOrganisationRisk>
                {...this.props}
                dueDate={() => reportDates?.Next}
                loadPeople={async r => {
                    const people = [];
                    if (r) {
                        if (r.RiskOwnerUser)
                            people.push({ role: 'Lead', names: [r.RiskOwnerUser.Title] });
                        if (r.Contributors && r.Contributors.length > 0)
                            people.push({ role: 'Contributors', names: r.Contributors.map(c => c.ContributorUser?.Title) });
                        people.push(...await EntityPeopleService.GetPartnerOrganisationEntityPeople({
                            partnerOrganisationService: dataServices.partnerOrganisationService,
                            userPartnerOrganisationService: dataServices.userPartnerOrganisationService,
                            partnerOrganisationId: r.PartnerOrganisationID
                        }));
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
                rag={ru => ru.BeisRagOptionID}
                ragLabel={ru =>
                    `${LookupService.getLookupName(lookupData.RiskImpactLevels, ru.BeisRiskImpactLevelID)
                    }/${LookupService.getLookupName(lookupData.RiskProbabilities, ru.BeisRiskProbabilityID)}`}
                renderFormFields={(
                    changeHandlers,
                    { FormData: ru, ParentEntity: r, LastSignedOffUpdate: so, ValidationErrors: errors, FormIsDirty }
                ) => {
                    const currentDueDate = r.RiskProximity;
                    const showReadOnly = ContributorService.UserIsReadOnlyContributor(this.props.orbUserContext.userContext.Username, r);

                    return (
                        <div className={styles.cr}>
                            <div className={styles.formField}>
                                <PartnerOrganisationRiskKeyInfo
                                    risk={r}
                                    riskAppetites={lookupData.RiskAppetites}
                                    riskImpactLevels={lookupData.RiskImpactLevels}
                                    riskProbabilities={lookupData.RiskProbabilities}
                                    riskTypes={lookupData.RiskTypes} />
                            </div>
                            <div className={styles.grid}>
                                <div className={`${styles.formField} ${styles.gridRow}`}>
                                    <div className={`${styles.gridCol} ${styles.sm12} ${styles.md12} ${styles.lg6}`}>
                                        <CrChoiceGroup
                                            disabled={showReadOnly}
                                            label="Partner organisation current perspective of impact"
                                            history={so.RiskImpactLevel?.Title}
                                            options={LookupService.entitiesToChoiceGroupOptionsFilteredByDate(reportDates?.Next, lookupData.RiskImpactLevels)}
                                            selectedKey={ru.RiskImpactLevelID?.toString()}
                                            onChange={(_e, v) => changeHandlers.changeChoiceGroup(v, 'RiskImpactLevelID', updatedRu => this.setRag(changeHandlers, updatedRu))} />
                                    </div>
                                    <div className={`${styles.gridCol} ${styles.sm12} ${styles.md12} ${styles.lg6}`}>
                                        <CrChoiceGroup
                                            disabled={showReadOnly}
                                            label="Partner organisation current perspective of probability"
                                            history={so.RiskProbability?.Title}
                                            options={LookupService.entitiesToChoiceGroupOptionsFilteredByDate(reportDates?.Next, lookupData.RiskProbabilities)}
                                            selectedKey={ru.RiskProbabilityID?.toString()}
                                            onChange={(_e, v) => changeHandlers.changeChoiceGroup(v, 'RiskProbabilityID', updatedRu => this.setRag(changeHandlers, updatedRu))} />
                                    </div>
                                </div>
                                <div className={`${styles.formField} ${styles.gridRow}`}>
                                    <div className={`${styles.gridCol} ${styles.sm12} ${styles.md12} ${styles.lg6}`}>
                                        <CrChoiceGroup
                                            disabled={showReadOnly}
                                            label="BEIS current perspective of impact"
                                            history={so.BeisRiskImpactLevel?.Title}
                                            options={LookupService.entitiesToChoiceGroupOptionsFilteredByDate(reportDates?.Next, lookupData.RiskImpactLevels)}
                                            selectedKey={ru.BeisRiskImpactLevelID?.toString()}
                                            onChange={(_e, v) => changeHandlers.changeChoiceGroup(v, 'BeisRiskImpactLevelID', updatedRu => this.setRag(changeHandlers, updatedRu))} />
                                    </div>
                                    <div className={`${styles.gridCol} ${styles.sm12} ${styles.md12} ${styles.lg6}`}>
                                        <CrChoiceGroup
                                            disabled={showReadOnly}
                                            label="BEIS current perspective of probability"
                                            history={so.BeisRiskProbability?.Title}
                                            options={LookupService.entitiesToChoiceGroupOptionsFilteredByDate(reportDates?.Next, lookupData.RiskProbabilities)}
                                            selectedKey={ru.BeisRiskProbabilityID?.toString()}
                                            onChange={(_e, v) => changeHandlers.changeChoiceGroup(v, 'BeisRiskProbabilityID', updatedRu => this.setRag(changeHandlers, updatedRu))} />
                                    </div>
                                </div>
                            </div>
                            {ru.ToBeClosed ||
                                <>
                                    <CrCheckbox
                                        disabled={showReadOnly}
                                        label="Is the risk ongoing?"
                                        className={styles.formField}
                                        checked={ru.RiskIsOngoing}
                                        onChange={(_e, isChecked: boolean) => {
                                            if (isChecked)
                                                changeHandlers.changeCheckbox(isChecked, 'RiskIsOngoing', () => changeHandlers.changeDatePicker(null, 'RiskProximity'));
                                            else
                                                changeHandlers.changeCheckbox(isChecked, 'RiskIsOngoing');
                                        }} />
                                    <CrDatePicker
                                        disabled={showReadOnly || ru.RiskIsOngoing}
                                        label='What is the proximity of this risk?'
                                        required={!ru.ToBeClosed && !ru.RiskIsOngoing && (currentDueDate === null || currentDueDate < new Date())}
                                        className={styles.formField}
                                        minDate={new Date()}
                                        value={ru.RiskProximity}
                                        onSelectDate={d => changeHandlers.changeDatePicker(d, 'RiskProximity')}
                                        history={so.RiskProximity}
                                        errorMessage={errors.RiskProximity} />
                                </>
                            }
                            <CrCheckbox
                                className={styles.formField}
                                disabled={showReadOnly}
                                label="Mark for closure"
                                checked={ru.ToBeClosed}
                                onChange={(_e, v) => changeHandlers.changeCheckbox(v, 'ToBeClosed')} />
                            {ru.ToBeClosed &&
                                <CrTextField
                                    className={styles.formField}
                                    disabled={showReadOnly}
                                    label="Why has it been closed?"
                                    required={true}
                                    multiline
                                    value={ru.Comment}
                                    maxLength={500}
                                    onChange={v => changeHandlers.changeTextField(v, 'Comment')}
                                    errorMessage={errors.Comment} />
                            }
                            <br />
                            <PartnerOrganisationRiskMitigationActionProgressUpdateReviewList
                                {...this.props}
                                readOnly={showReadOnly}
                                entities={this.state.PartnerOrganisationRiskMitigationActions.map(a => (
                                    {
                                        ...a,
                                        PartnerOrganisationRiskMitigationActionUpdates: this.state.PartnerOrganisationRiskMitigationActionUpdates
                                            .filter(u => u.PartnerOrganisationRiskMitigationActionID === a.ID)
                                    }))}
                                previousEntities={[]}
                                reportDates={reportDates}
                                onChange={() => {
                                    changeHandlers.changeCheckbox(ru.RiskIsOngoing, 'RiskIsOngoing'); // Force FormIsDirty
                                    this.loadPartnerOrganisationRiskMitigationActionUpdates(
                                        this.state.PartnerOrganisationRiskMitigationActions, this.props.reportDates?.Next);
                                }} />
                            {!FormIsDirty && this.state.SignOff &&
                                <CrApprovalDetails
                                    approverName={this.state.SignOff.SignOffUser?.Title}
                                    approvalDate={this.state.SignOff.SignOffDate}
                                />
                            }
                        </div>
                    );
                }}
                loadEntity={rId => dataServices.partnerOrganisationRiskService.read(rId, true, true)}
                loadEntityUpdate={ruId => dataServices.partnerOrganisationRiskUpdateService.read(ruId)}
                loadNewEntityUpdate={() => new PartnerOrganisationRiskUpdate(entityId)}
                loadLastSavedProgressUpdate={() => reportDates?.Next &&
                    dataServices.partnerOrganisationRiskUpdateService.readLatestUpdateForPeriod(entityId, reportDates.Next)}
                loadLastSignedOffEntityUpdate={() => reportDates?.Previous &&
                    dataServices.partnerOrganisationRiskUpdateService.readLastSignedOffUpdateForPeriod(entityId, reportDates.Previous)}
                onFormOpened={() =>
                    this.loadPartnerOrganisationRiskMitigationActions(entityId)
                        .then(partnerOrganisationRiskMitigationActions =>
                            this.loadPartnerOrganisationRiskMitigationActionUpdates(partnerOrganisationRiskMitigationActions, reportDates?.Next))
                }
                onValidateUpdate={this.validatePartnerOrganisationRiskProgressUpdate}
                onBeforeSave={(ru, r) => {
                    ru.Title = r.Title;

                    delete ru.BeisRiskImpactLevel;
                    delete ru.BeisRiskProbability;
                    delete ru.RiskImpactLevel;
                    delete ru.RiskProbability;
                }}
                onSaveUpdate={ru => dataServices.partnerOrganisationRiskUpdateService.create(ru)}
                onClearForm={(r, showForm) => {
                    this.loadPartnerOrganisationRiskMitigationActionUpdates(this.state.PartnerOrganisationRiskMitigationActions, reportDates?.Next);
                    return new PartnerOrganisationRiskProgressUpdateFormState(entityId, reportDates?.Next, r, showForm);
                }}
                entityUpdateId={entityUpdateId}
                reportDates={reportDates}
                entityId={entityId}
                entity={entity}
                defaultShowForm={defaultShowForm}
                onSaved={onSaved}
                onCancelled={onCancelled}
                reportingFrequencies={lookupData?.ReportingFrequencies}
            />
        );
    }

    private loadPartnerOrganisationRiskMitigationActions =
        async (partnerOrganisationRiskId: number): Promise<IPartnerOrganisationRiskMitigationAction[]> => {
            try {
                const partnerOrganisationRiskMitigationActions = await this.props.dataContext.dataServices.partnerOrganisationRiskMitigationActionService
                    .readMitigationActionsForRisk(partnerOrganisationRiskId);
                if (partnerOrganisationRiskMitigationActions) {
                    this.setState({ PartnerOrganisationRiskMitigationActions: partnerOrganisationRiskMitigationActions });
                    return partnerOrganisationRiskMitigationActions;
                }
            } catch (err) {
                this.props.errorHandling?.onError(`Error loading partner organisation risk mitigation actions`, err.message);
            }
        }

    private loadPartnerOrganisationRiskMitigationActionUpdates = (
        partnerOrganisationRiskMitigationActions: IPartnerOrganisationRiskMitigationAction[], period: Date)
        : Promise<IPartnerOrganisationRiskMitigationActionUpdate[]> => {
        const rmaus = [];
        this.setState({ PartnerOrganisationRiskMitigationActionUpdates: [] },
            () => partnerOrganisationRiskMitigationActions.forEach(rma => rmaus.push(this.loadPartnerOrganisationRiskMitigationActionUpdate(rma, period)))
        );
        return Promise.all(rmaus);
    }

    private loadPartnerOrganisationRiskMitigationActionUpdate = async (
        partnerOrganisationRiskMitigationAction: IPartnerOrganisationRiskMitigationAction, period: Date)
        : Promise<IPartnerOrganisationRiskMitigationActionUpdate> => {
        try {
            const rmau = await this.props.dataContext.dataServices.partnerOrganisationRiskMitigationActionUpdateService.readLatestUpdateForPeriod(partnerOrganisationRiskMitigationAction.ID, period);
            if (rmau) {
                this.setState(s => ({ PartnerOrganisationRiskMitigationActionUpdates: [...s.PartnerOrganisationRiskMitigationActionUpdates, rmau] }));
                return rmau;
            }
        } catch (err) {
            this.props.errorHandling?.onError(`Error loading partnerOrganisationRisk mitigation action update`, err.message);
        }
    }

    private setRag = (changeHandlers: IProgressUpdateFormChangeHandlers<IPartnerOrganisationRiskUpdate>, ru: IPartnerOrganisationRiskUpdate): void => {
        if (ru.RiskImpactLevelID && ru.RiskProbabilityID)
            changeHandlers.changeColor(RiskRagService.calculateRiskRag(ru.RiskImpactLevelID, ru.RiskProbabilityID), 'RagOptionID');
        if (ru.BeisRiskImpactLevelID && ru.BeisRiskProbabilityID)
            changeHandlers.changeColor(RiskRagService.calculateRiskRag(ru.BeisRiskImpactLevelID, ru.BeisRiskProbabilityID), 'BeisRagOptionID');
    }

    private validatePartnerOrganisationRiskProgressUpdate = (ru: IPartnerOrganisationRiskUpdate, r: IPartnerOrganisationRisk): Promise<PartnerOrganisationRiskUpdateFormValidations> => {
        const errors = new PartnerOrganisationRiskUpdateFormValidations();
        const currentDueDate = r.RiskProximity;

        if ((ru.Comment === null || ru.Comment === '') && ru.ToBeClosed) {
            errors.Comment = 'Closure narrative is required';
            errors.Valid = false;
        }
        else
            errors.Comment = null;

        if (!ru.ToBeClosed && !ru.RiskIsOngoing && (currentDueDate === null || currentDueDate !== null && currentDueDate < new Date()) && ru.RiskProximity === null) {
            errors.RiskProximity = 'Risk proximity is required';
            errors.Valid = false;
        } else if (!ru.ToBeClosed && ru.RiskProximity !== null && ru.RiskProximity < new Date()) {
            errors.RiskProximity = 'Risk proximity date cannot be in the past';
            errors.Valid = false;
        } else
            errors.RiskProximity = null;

        return Promise.resolve(errors);
    }

    public componentDidMount(): void {
        const { loadLookupData: lld } = this.props.dataContext;
        lld?.riskImpactLevels();
        lld?.riskProbabilities();
        lld?.riskRegisters();
        lld?.riskTypes();

    }
}
