import React, { useContext, useMemo } from 'react';
import { IRiskMitigationAction, Contributor, EntityValidations, ISpecificEntityFormProps, FinancialRiskMitigationAction } from '../../types';
import { LookupService } from '../../services';
import styles from '../../styles/cr.module.scss';
import { CrUserPicker } from '../cr/CrUserPicker';
import { CrDatePicker } from '../cr/CrDatePicker';
import { CrTextField } from '../cr/CrTextField';
import { CrDropdown } from '../cr/CrDropdown';
import { EntityStatus } from '../../refData/EntityStatus';
import { CrCheckbox } from '../cr/CrCheckbox';
import { EntityForm } from '../EntityForm';
import { CrReportingCyclePicker } from '../cr/CrReportingCyclePicker';
import { ReportingCycleService } from '../../services/ReportingCycleService';
import { DataContext } from '../DataContext';

export class FinancialRiskMitigationActionValidations extends EntityValidations {
    public RiskID: string = null;
    public NormalContributors: string = null;
    public BaselineDate: string = null;
    public ReviewCycle: string = null;
}

export const FinancialRiskMitigationActionForm = (props: ISpecificEntityFormProps): React.ReactElement => {
    const { dataServices: { contributorService, financialRiskMitigationActionService }, lookupData, loadLookupData: { directorates,
        entityStatuses, financialRisks, userDirectorates, userGroups, userProjects, users: { all: allUsers } } } = useContext(DataContext);

    useMemo(() => directorates(), [directorates]);
    useMemo(() => entityStatuses(), [entityStatuses]);
    useMemo(() => financialRisks(), [financialRisks]);
    useMemo(() => userDirectorates(), [userDirectorates]);
    useMemo(() => userGroups(), [userGroups]);
    useMemo(() => userProjects(), [userProjects]);
    useMemo(() => allUsers(), [allUsers]);

    const validateEntity = (rma: IRiskMitigationAction): Promise<FinancialRiskMitigationActionValidations> => {
        const errors = new FinancialRiskMitigationActionValidations();

        if (rma.Title === null || rma.Title === '') {
            errors.Title = 'Risk mitigation action name is required';
            errors.Valid = false;
        }
        else {
            errors.Title = null;
        }

        if (rma.RiskID === null) {
            errors.RiskID = 'Risk is required';
            errors.Valid = false;
        }
        else {
            errors.RiskID = null;
        }

        if (rma.Contributors.some(ct => ct.ContributorUserID === rma.OwnerUserID)) {
            errors.NormalContributors = 'A user cannot be both the lead and a contributor';
            errors.Valid = false;
        }
        else {
            errors.NormalContributors = null;
        }

        if (rma.BaselineDate == null && !rma.ActionIsOngoing) {
            errors.BaselineDate = `Please estimate when this action will be delivered`;
            errors.Valid = false;
        } else {
            errors.BaselineDate = null;
        }

        if (rma.ActionIsOngoing && !ReportingCycleService.cycleIsValid({ frequency: rma.OngoingActionReviewFrequency, dueDay: rma.OngoingActionReviewDueDay, startDate: rma.OngoingActionReviewStartDate })) {
            errors.ReviewCycle = 'Please select all values for the review cycle';
            errors.Valid = false;
        }
        else {
            errors.ReviewCycle = null;
        }

        return Promise.resolve(errors);
    };

    return (
        <EntityForm<FinancialRiskMitigationAction, FinancialRiskMitigationActionValidations>
            {...props}
            entityName="Risk mitigating action"
            renderFormFields={({ changeCheckbox, changeCycle, changeDatePicker, changeDropdown, changeMultiUserPicker, changeTextField, changeUserPicker }, formState) => {
                const { FormData: action, ValidationErrors: errors } = formState;
                const risk = lookupData?.CorporateRisks.find(r => r.ID === action.RiskID);
                const mappedUsers = LookupService.riskMitigationActionUsers(lookupData, action);
                const suggestions = risk != null ? {
                    initialSuggestionsHeaderText:
                        risk?.IsProjectRisk && risk?.ProjectID ? `Project users` :
                            risk?.DirectorateID ? `Directorate and group users` : null,
                    initialSuggestions: mappedUsers,
                    noResultsFoundText:
                        mappedUsers.length === 0 ?
                            risk?.IsProjectRisk && risk?.ProjectID ? `No users are mapped to this risk mitigating action's project` :
                                risk?.DirectorateID ? `No users are mapped to this risk mitigating action's directorate or group` : null : null
                } : {};
                return (
                    <div>
                        <CrTextField
                            label="Name"
                            required={true}
                            className={styles.formField}
                            value={action.Title}
                            onChange={v => changeTextField(v, 'Title')}
                            maxLength={255}
                            errorMessage={errors.Title}
                        />
                        <CrDropdown
                            label="Lead risk"
                            required={true}
                            className={styles.formField}
                            options={LookupService.entitiesToSelectableOptions(lookupData.FinancialRisks, { optionText: r => `${r.RiskCode} - ${r.Title}` })}
                            selectedKey={action.RiskID}
                            onChange={(_, option, index) => changeDropdown(option, 'RiskID', index)}
                            errorMessage={errors.RiskID}
                        />
                        <CrTextField
                            label="Description"
                            className={styles.formField}
                            value={action.Description}
                            onChange={v => changeTextField(v, 'Description')}
                            maxLength={750}
                            multiline
                            rows={6}
                        />
                        <CrUserPicker
                            label="Mitigating action owner"
                            className={styles.formField}
                            disabled={!action.RiskID}
                            users={mappedUsers}
                            selectedUsers={action.OwnerUserID && [action.OwnerUserID]}
                            onChange={u => changeUserPicker(u, 'OwnerUserID')}
                            {...suggestions}
                        />
                        <CrUserPicker
                            label="Contributors"
                            className={styles.formField}
                            disabled={!action.RiskID}
                            users={mappedUsers}
                            itemLimit={6}
                            selectedUsers={action.Contributors?.map(c => c.ContributorUserID)}
                            onChange={v => changeMultiUserPicker(v, 'Contributors', new Contributor(), 'ContributorUserID')}
                            errorMessage={errors.NormalContributors}
                            {...suggestions}
                        />
                        <CrCheckbox
                            label="Is the action ongoing?"
                            className={styles.formField}
                            checked={action.ActionIsOngoing}
                            onChange={(_, isChecked) =>
                                isChecked ?
                                    changeCheckbox(isChecked, 'ActionIsOngoing', () => changeDatePicker(null, 'BaselineDate'))
                                    : changeCheckbox(isChecked, 'ActionIsOngoing')
                            }
                        />
                        {!action.ActionIsOngoing &&
                            <CrDatePicker
                                label="Baseline delivery date"
                                required={true}
                                className={styles.formField}
                                value={action.BaselineDate}
                                onSelectDate={d => changeDatePicker(d, 'BaselineDate')}
                                errorMessage={errors.BaselineDate}
                            />
                        }
                        {action.ActionIsOngoing &&
                            <CrReportingCyclePicker
                                label="Review cycle"
                                required={true}
                                cycle={{ frequency: action.OngoingActionReviewFrequency, dueDay: action.OngoingActionReviewDueDay, startDate: action.OngoingActionReviewStartDate }}
                                onChange={cycle => changeCycle(cycle, { frequency: 'OngoingActionReviewFrequency', dueDay: 'OngoingActionReviewDueDay', startDate: 'OngoingActionReviewStartDate' })}
                                errorMessage={errors.ReviewCycle}
                            />
                        }
                        {formState.FormDataBeforeChanges.EntityStatusID === EntityStatus.Closed &&
                            <CrDropdown
                                label="Status"
                                className={styles.formField}
                                options={LookupService.entitiesToSelectableOptions(lookupData.EntityStatuses)}
                                selectedKey={action.EntityStatusID}
                                onChange={(_, o) => changeDropdown(o, 'EntityStatusID')}
                            />
                        }
                    </div>
                );
            }}
            loadEntity={id => financialRiskMitigationActionService.read(id, true, true)}
            loadNewEntity={() => new FinancialRiskMitigationAction()}
            loadEntityValidations={() => new FinancialRiskMitigationActionValidations()}
            onValidateEntity={validateEntity}
            onCreate={rma => financialRiskMitigationActionService.create(rma)}
            onUpdate={rma => financialRiskMitigationActionService.update(rma.ID, rma)}
            parentEntities={financialRiskMitigationActionService.parentEntities}
            childEntities={[
                {
                    ObjectParentProperty: 'Contributors',
                    ParentIdProperty: 'RiskMitigationActionID',
                    ChildIdProperty: 'ContributorUserID',
                    ChildService: contributorService
                }
            ]}
        />
    );
};
