import React, { useContext, useMemo, useState } from 'react';
import {
    CrUpdateFormState, IRiskUpdate,
    ProgressUpdateValidations, IEntityProgressUpdateFormProps,
    IFinancialRiskUpdate, IFinancialRisk, FinancialRisk,
    FinancialRiskUpdate, IFinancialRiskMitigationAction
} from '../../types';
import styles from '../../styles/cr.module.scss';
import { CrTextField } from '../cr/CrTextField';
import { ProgressUpdateForm, IProgressUpdateFormChangeHandlers } from '../ProgressUpdateForm';
import { CrDropdown } from '../cr/CrDropdown';
import { RiskRagService, LookupService, DateService, EntityPeopleService, RiskAppetiteService, AttributeService, NumberService } from '../../services';
import { MessageBar, MessageBarType } from 'office-ui-fabric-react/lib/MessageBar';
import { CrChoiceGroup } from '../cr/CrChoiceGroup';
import { CrCheckbox } from '../cr/CrCheckbox';
import { CrDatePicker } from '../cr/CrDatePicker';
import { Text } from 'office-ui-fabric-react/lib/Text';
import { IDropdownOption } from 'office-ui-fabric-react/lib/Dropdown';
import { RiskKeyInfo } from '../risk/RiskKeyInfo';
import { HyperlinksField } from '../cr/HyperlinksField';
import { CrLabel } from '../cr/CrLabel';
import { SpendProfileField } from './SpendProfileField';
import { FinancialRiskMitigationActionProgressUpdateReviewList } from './FinancialRiskMitigationActionProgressUpdateReviewList';
import { DataContext } from '../DataContext';

export class FinancialRiskUpdateFormValidations extends ProgressUpdateValidations {
    public Title: string = null;
    public RiskProximity: string = null;
    public Measurements: string = null;
}

export interface IParentFinancialRiskProgressUpdateFormProps extends IEntityProgressUpdateFormProps<IFinancialRisk> {
    disabled?: boolean;
    riskActions?: IFinancialRiskMitigationAction[];
}

export class FinancialRiskProgressUpdateFormState extends CrUpdateFormState<IFinancialRiskUpdate, FinancialRiskUpdateFormValidations, IFinancialRisk> {
    constructor(riskId: number, period: Date, parentEntity?: IFinancialRisk, showForm?: boolean) {
        super(
            new FinancialRiskUpdate(riskId, period),
            parentEntity || new FinancialRisk(),
            new FinancialRiskUpdate(),
            new FinancialRiskUpdateFormValidations(),
            showForm
        );
    }
}

export const FinancialRiskProgressUpdateForm = (props: IParentFinancialRiskProgressUpdateFormProps): React.ReactElement => {
    const { entityId, entity, reportDates, entityUpdateId, defaultShowForm, onSaved, onCancelled,
        disabled, riskActions } = props;
    const {
        dataServices, lookupData, loadLookupData: { directorates, groups, reportingFrequencies, riskImpactLevels, riskProbabilities }
    } = useContext(DataContext);
    const [notificationsSent, setNotificationsSent] = useState<Date>(null);

    useMemo(() => directorates(), [directorates]);
    useMemo(() => groups(), [groups]);
    useMemo(() => reportingFrequencies(), [reportingFrequencies]);
    useMemo(() => riskImpactLevels(), [riskImpactLevels]);
    useMemo(() => riskProbabilities(), [riskProbabilities]);

    const validateRiskProgressUpdate = (ru: IFinancialRiskUpdate, r: IFinancialRisk): Promise<FinancialRiskUpdateFormValidations> => {
        const errors = new FinancialRiskUpdateFormValidations();
        const currentDueDate = r.RiskProximity;
        const isNullOrEmpty = (value: string): boolean => value == null || value === '';

        if ((ru.Comment === null || ru.Comment === '') && ru.ToBeClosed) {
            errors.Comment = 'Closure narrative is required';
            errors.Valid = false;
        } else
            errors.Comment = null;

        if (!ru.ToBeClosed && !ru.RiskIsOngoing && (currentDueDate === null || currentDueDate !== null && currentDueDate < new Date()) && ru.RiskProximity === null) {
            errors.RiskProximity = 'Risk proximity is required';
            errors.Valid = false;
        } else if (!ru.ToBeClosed && ru.RiskProximity !== null && ru.RiskProximity < new Date()) {
            errors.RiskProximity = 'Risk proximity date cannot be in the past';
            errors.Valid = false;
        } else errors.RiskProximity = null;

        if (
            (ru.Measurements?.SpendProfile?.FinancialYear0 != null && isNaN(Number(ru.Measurements?.SpendProfile?.FinancialYear0)))
            || (ru.Measurements?.SpendProfile?.FinancialYear1 != null && isNaN(Number(ru.Measurements?.SpendProfile?.FinancialYear1)))
            || (ru.Measurements?.SpendProfile?.FinancialYear2 != null && isNaN(Number(ru.Measurements?.SpendProfile?.FinancialYear2)))
            || (ru.Measurements?.SpendProfile?.FinancialYear3 != null && isNaN(Number(ru.Measurements?.SpendProfile?.FinancialYear3)))
            || (ru.Measurements?.SpendProfile?.FinancialYear4 != null && isNaN(Number(ru.Measurements?.SpendProfile?.FinancialYear4)))
        ) {
            errors.Measurements = 'Spend/income profile must only be numbers';
            errors.Valid = false;
        } else errors.Measurements = null;

        if (!ru.Measurements?.SpendProfileNotApplicable
            && (isNullOrEmpty(ru.Measurements?.SpendProfile?.FinancialYear0?.toString())
                || isNullOrEmpty(ru.Measurements?.SpendProfile?.FinancialYear1?.toString())
                || isNullOrEmpty(ru.Measurements?.SpendProfile?.FinancialYear2?.toString())
                || isNullOrEmpty(ru.Measurements?.SpendProfile?.FinancialYear3?.toString())
                || isNullOrEmpty(ru.Measurements?.SpendProfile?.FinancialYear4?.toString()))
        ) {
            errors.Measurements = `Spend/income profile is required`;
            errors.Valid = false;
        } else
            errors.Measurements = null;

        return Promise.resolve(errors);
    };

    const setRag = (changeHandlers: IProgressUpdateFormChangeHandlers<IRiskUpdate>, ru: IRiskUpdate): void => {
        if (ru.RiskImpactLevelID && ru.RiskProbabilityID) {
            changeHandlers.changeColor(RiskRagService.calculateRiskRag(ru.RiskImpactLevelID, ru.RiskProbabilityID), 'RagOptionID');
        }
    };

    return (
        <ProgressUpdateForm<IFinancialRiskUpdate, FinancialRiskUpdateFormValidations, IFinancialRisk>
            {...props}
            parents={r => {
                if (r) {
                    const p = [];
                    if (r.GroupID)
                        p.push(lookupData.Groups.find(g => g.ID === r.GroupID)?.Title);
                    if (r.OwnedByMultipleGroups)
                        p.push(`Central`);
                    else if (r.OwnedByDgOffice)
                        p.push(`DG Office`);
                    else if (r.DirectorateID)
                        p.push(lookupData.Directorates.find(d => d.ID === r.DirectorateID)?.Title);
                    return p;
                }
                return [];
            }}
            dueDate={() => reportDates?.Next}
            loadPeople={async r => {
                const people = [];
                if (r) {
                    people.push(...await EntityPeopleService.GetRiskEntityPeople({
                        riskService: dataServices.financialRiskService,
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
            ragLabel={ru => ru.RiskImpactLevelID && ru.RiskProbabilityID &&
                `${LookupService.getLookupName(lookupData.RiskImpactLevels, ru.RiskImpactLevelID)}/${LookupService.getLookupName(lookupData.RiskProbabilities, ru.RiskProbabilityID)}`
                || `To be completed`
            }
            renderFormFields={(
                changeHandlers,
                { FormData: ru, ParentEntity: r, LastSignedOffUpdate: so, ValidationErrors: errors }
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
                                <div className={`${styles.gridCol} ${styles.sm12} ${styles.md12} ${styles.lg4}`}>
                                    <CrChoiceGroup
                                        label="Impact level"
                                        history={so.RiskImpactLevel?.Title}
                                        options={LookupService.entitiesToChoiceGroupOptionsFilteredByDate(reportDates?.Next, lookupData.RiskImpactLevels)}
                                        selectedKey={ru.RiskImpactLevelID?.toString()}
                                        onChange={(_, v) => changeHandlers.changeChoiceGroup(v, 'RiskImpactLevelID', updatedRu => setRag(changeHandlers, updatedRu))}
                                        disabled={disabled}
                                    />
                                </div>
                                <div className={`${styles.gridCol} ${styles.sm12} ${styles.md12} ${styles.lg4}`}>
                                    <CrChoiceGroup
                                        label="Probability"
                                        history={so.RiskProbability?.Title}
                                        options={LookupService.entitiesToChoiceGroupOptionsFilteredByDate(reportDates?.Next, lookupData.RiskProbabilities)}
                                        selectedKey={ru.RiskProbabilityID?.toString()}
                                        onChange={(_, v) => changeHandlers.changeChoiceGroup(v, 'RiskProbabilityID', updatedRu => setRag(changeHandlers, updatedRu))}
                                        disabled={disabled}
                                    />
                                </div>
                                <div className={`${styles.gridCol} ${styles.sm12} ${styles.md12} ${styles.lg4}`}>
                                    <>
                                        <CrLabel text="Risk proximity" />
                                        <CrCheckbox
                                            label="Is the risk ongoing?"
                                            className={styles.formField}
                                            disabled={ru.ToBeClosed || disabled}
                                            checked={ru.RiskIsOngoing}
                                            onChange={(_, isChecked) => isChecked ?
                                                changeHandlers.changeCheckbox(isChecked, 'RiskIsOngoing', () => changeHandlers.changeDatePicker(null, 'RiskProximity'))
                                                :
                                                changeHandlers.changeCheckbox(isChecked, 'RiskIsOngoing')
                                            }
                                        />
                                    </>
                                    <CrDatePicker
                                        label='What is the proximity of this risk?'
                                        required={!ru.ToBeClosed && !ru.RiskIsOngoing && (currentDueDate === null || currentDueDate < new Date())}
                                        className={styles.formField}
                                        disabled={ru.ToBeClosed || ru.RiskIsOngoing || disabled}
                                        minDate={new Date()}
                                        value={ru.RiskProximity}
                                        onSelectDate={d => changeHandlers.changeDatePicker(d, 'RiskProximity')}
                                        history={so.RiskProximity}
                                        errorMessage={errors.RiskProximity}
                                    />
                                </div>
                            </div>
                        </div>
                        <CrCheckbox
                            className={styles.formField}
                            label="Mark this risk for closure"
                            checked={ru.ToBeClosed}
                            onChange={(_, v) =>
                                changeHandlers.changeCheckbox(v, 'ToBeClosed', () =>
                                    changeHandlers.clearField('RiskIsOngoing', () =>
                                        changeHandlers.clearField('RiskProximity')
                                    )
                                )
                            }
                            disabled={disabled}
                        />
                        {ru.ToBeClosed &&
                            <CrDropdown label="Select reason for closure"
                                className={styles.formField}
                                required={true}
                                options={options}
                                selectedKey={ru.ClosureReason}
                                onChange={(_, v) => changeHandlers.changeDropdown(v, 'ClosureReason')}
                                disabled={disabled}
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
                                onChange={v => changeHandlers.changeTextField(v, 'Comment')}
                                errorMessage={errors.Comment}
                                disabled={disabled}
                            />
                        }
                        <br />
                        <CrTextField
                            label="Narrative"
                            className={styles.formField}
                            placeholder="Please describe how you have come to the overall rating for this risk?"
                            multiline
                            rows={2}
                            maxLength={500}
                            charCounter={true}
                            value={ru.Narrative}
                            onChange={v => changeHandlers.changeTextField(v, 'Narrative')}
                            history={so.Narrative}
                            disabled={disabled}
                        />
                        <CrCheckbox
                            label="Spend/income profile not applicable?"
                            className={styles.formField}
                            checked={ru.Measurements?.SpendProfileNotApplicable}
                            onChange={(_, checked) => changeHandlers.changeJson({ SpendProfileNotApplicable: checked, SpendProfile: ru.Measurements?.SpendProfile }, 'Measurements')}
                            disabled={disabled}
                        />
                        <SpendProfileField
                            className={styles.formField}
                            disabled={ru.Measurements?.SpendProfileNotApplicable || disabled}
                            reportDate={ru.UpdatePeriod}
                            value={ru.Measurements?.SpendProfile}
                            onChange={sp => changeHandlers.changeJson({ SpendProfileNotApplicable: ru.Measurements?.SpendProfileNotApplicable, SpendProfile: sp }, 'Measurements')}
                            errorMessage={errors.Measurements}
                        />
                        <HyperlinksField
                            label="Attachments"
                            description="Add links to any supporting documents or files"
                            className={styles.formField}
                            addEditLinkHelpText="Please ensure access to the linked file is possible for those who will need to review it."
                            links={ru.Attachments}
                            onChange={attachments => changeHandlers.changeJson(attachments, 'Attachments')}
                            disabled={disabled}
                        />
                        {riskActions?.length > 0 &&
                            <FinancialRiskMitigationActionProgressUpdateReviewList
                                {...props}
                                entities={riskActions}
                                previousEntities={[]}
                                reportDates={reportDates}
                                risk={entity}
                                hideClosedNoUpdates={true}
                                riskService={dataServices.financialRiskService}
                                riskActionService={dataServices.financialRiskMitigationActionService}
                                riskActionUpdateService={dataServices.financialRiskMitigationActionUpdateService}
                            />
                        }
                        {(ru?.Escalate || ru?.DeEscalate || ru?.ToBeClosed) &&
                            <div>
                                <div style={{ display: 'flex' }}>
                                    <div style={{ display: 'flex', alignItems: 'center', marginRight: '20px' }}>
                                        <div>
                                            <CrCheckbox
                                                label="Send&nbsp;notifications?"
                                                className={styles.formField}
                                                checked={ru.SendNotifications}
                                                onChange={(_, checked) => changeHandlers.changeCheckbox(checked, 'SendNotifications')}
                                            />
                                            {notificationsSent &&
                                                <div className={styles.checkbox}>
                                                    <Text>Notifications&nbsp;sent:&nbsp;{DateService.dateToUkDate(notificationsSent)}</Text>
                                                </div>
                                            }
                                        </div>
                                    </div>
                                    <div>
                                        <p>This will notify colleagues that you have marked the risk for closure.</p>
                                        <p>When your updates are complete, your risk will only be actioned once you have notified colleagues.</p>
                                        <p>You can save your update without notifying other colleagues by leaving this checkbox unticked.</p>
                                    </div>
                                </div>
                            </div>
                        }
                    </div>
                );
            }}
            loadEntity={rId => dataServices.financialRiskService.read(rId, true, true)}
            loadEntityUpdate={ruId =>
                dataServices.financialRiskUpdateService
                    .read(ruId)
                    .then(ru => {
                        if (ru) {
                            if (ru.SendNotifications) setNotificationsSent(ru.UpdateDate);
                            ru.SendNotifications = false;
                        }
                        return ru;
                    })}
            loadNewEntityUpdate={() => new FinancialRiskUpdate(entityId)}
            loadLastSavedProgressUpdate={async () => {
                if (reportDates?.Next) {
                    const lastUpdate = await dataServices.financialRiskUpdateService.readLatestUpdateForPeriod(entityId, reportDates.Next);

                    if (lastUpdate) {
                        if (lastUpdate.SendNotifications) setNotificationsSent(lastUpdate.UpdateDate);
                        lastUpdate.SendNotifications = false;
                        return lastUpdate;
                    } else { // Load new update with spend profile numbers from last
                        const newUpdateWithLastSpendProfile = new FinancialRiskUpdate(entityId, reportDates.Next);
                        const lastSpendProfile = await dataServices.financialRiskUpdateService.readLatestUpdate(entityId);
                        if (lastSpendProfile) {
                            newUpdateWithLastSpendProfile.Measurements.SpendProfile.FinancialYear0 = lastSpendProfile.Measurements.SpendProfile?.FinancialYear0?.toString();
                            newUpdateWithLastSpendProfile.Measurements.SpendProfile.FinancialYear1 = lastSpendProfile.Measurements.SpendProfile?.FinancialYear1?.toString();
                            newUpdateWithLastSpendProfile.Measurements.SpendProfile.FinancialYear2 = lastSpendProfile.Measurements.SpendProfile?.FinancialYear2?.toString();
                            newUpdateWithLastSpendProfile.Measurements.SpendProfile.FinancialYear3 = lastSpendProfile.Measurements.SpendProfile?.FinancialYear3?.toString();
                            newUpdateWithLastSpendProfile.Measurements.SpendProfile.FinancialYear4 = lastSpendProfile.Measurements.SpendProfile?.FinancialYear4?.toString();
                            newUpdateWithLastSpendProfile.Measurements.SpendProfileNotApplicable = lastSpendProfile.Measurements.SpendProfileNotApplicable;
                        }
                        return newUpdateWithLastSpendProfile;
                    }
                }
            }}
            loadLastSignedOffEntityUpdate={() => reportDates?.Previous &&
                dataServices.financialRiskUpdateService.readLastSignedOffUpdateForPeriod(entityId, reportDates.Previous)}
            onValidateUpdate={validateRiskProgressUpdate}
            onBeforeSave={(ru, r) => {
                ru.Title = r.Title;
                ru.RiskRegisterID = r.RiskRegisterID;
                ru.RiskCode = r.RiskCode;

                ru.Measurements.SpendProfile.FinancialYear0 = NumberService.ToNumberOrNull(ru.Measurements?.SpendProfile?.FinancialYear0);
                ru.Measurements.SpendProfile.FinancialYear1 = NumberService.ToNumberOrNull(ru.Measurements?.SpendProfile?.FinancialYear1);
                ru.Measurements.SpendProfile.FinancialYear2 = NumberService.ToNumberOrNull(ru.Measurements?.SpendProfile?.FinancialYear2);
                ru.Measurements.SpendProfile.FinancialYear3 = NumberService.ToNumberOrNull(ru.Measurements?.SpendProfile?.FinancialYear3);
                ru.Measurements.SpendProfile.FinancialYear4 = NumberService.ToNumberOrNull(ru.Measurements?.SpendProfile?.FinancialYear4);

                delete ru.RiskImpactLevel;
                delete ru.RiskProbability;
            }}
            onSaveUpdate={ru => dataServices.financialRiskUpdateService.create(ru)}
            onAfterSave={ru => {
                if (ru.SendNotifications) setNotificationsSent(ru.UpdateDate);
            }}
            onClearForm={(r, showForm) => new FinancialRiskProgressUpdateFormState(entityId, reportDates?.Next, r, showForm)}
            entityId={entityId}
            entityUpdateId={entityUpdateId}
            reportDates={reportDates}
            entity={entity}
            defaultShowForm={defaultShowForm}
            onSaved={onSaved}
            onCancelled={onCancelled}
            disableSave={() => disabled}
            disableLoadLastSavedProgressUpdate={disabled}
            disableLoadLastSignedOff={disabled}
            reportingFrequencies={lookupData?.ReportingFrequencies}
        />
    );
};
