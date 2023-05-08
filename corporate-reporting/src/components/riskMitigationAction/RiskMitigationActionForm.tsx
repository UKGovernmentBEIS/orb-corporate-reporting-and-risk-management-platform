import React, { useContext, useMemo } from 'react';
import { IRiskMitigationAction, Contributor, EntityValidations, ISpecificEntityFormProps, RiskRiskMitigationAction, ICorporateRiskMitigationAction, CorporateRiskMitigationAction } from '../../types';
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
import { CrEntityPicker } from '../cr/CrEntityPicker';

export class RiskMitigationActionValidations extends EntityValidations {
    public RiskID: string = null;
    public NormalContributors: string = null;
    public BaselineDate: string = null;
    public ReviewCycle: string = null;
}

export interface IRiskMitigationActionFormProps extends ISpecificEntityFormProps {
    maxDependentRisks?: number;
}

export const RiskMitigationActionForm = (props: IRiskMitigationActionFormProps): React.ReactElement => {
    const { maxDependentRisks } = props;
    const { dataServices: { contributorService, corporateRiskMitigationActionService, corporateRiskRiskMitigationActionService }, lookupData, loadLookupData: { corporateRisks, directorates,
        entityStatuses, financialRisks, userDirectorates, userGroups, userProjects, users: { all: allUsers } } } = useContext(DataContext);

    useMemo(() => corporateRisks(), [corporateRisks]);
    useMemo(() => directorates(), [directorates]);
    useMemo(() => entityStatuses(), [entityStatuses]);
    useMemo(() => financialRisks(), [financialRisks]);
    useMemo(() => userDirectorates(), [userDirectorates]);
    useMemo(() => userGroups(), [userGroups]);
    useMemo(() => userProjects(), [userProjects]);
    useMemo(() => allUsers(), [allUsers]);

    const validateEntity = (rma: IRiskMitigationAction): Promise<RiskMitigationActionValidations> => {
        const errors = new RiskMitigationActionValidations();

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
        <EntityForm<ICorporateRiskMitigationAction, RiskMitigationActionValidations>
            {...props}
            entityName="Risk mitigating action"
            renderFormFields={({ changeCheckbox, changeCycle, changeDatePicker, changeDropdown, changeEntityPicker, changeMultiUserPicker, changeTextField, changeUserPicker }, formState) => {
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
                            disabled={action?.Risk?.Attributes?.filter(x => x.AttributeTypeID===1000).length > 0}
                        />
                        <CrDropdown
                            label="Lead risk"
                            required={true}
                            className={styles.formField}
                            options={LookupService.entitiesToSelectableOptions(lookupData.CorporateRisks, { optionText: r => `${r.RiskCode} - ${r.Title}` })}
                            selectedKey={action.RiskID}
                            onChange={(_, option, index) => changeDropdown(option, 'RiskID', index)}
                            errorMessage={errors.RiskID}
                            disabled={action?.Risk?.Attributes?.filter(x => x.AttributeTypeID===1000).length > 0}
                        />
                        <CrEntityPicker
                            label={`Dependent risk${(maxDependentRisks || 1) > 1 ? 's' : ''}`}
                            className={styles.formField}
                            itemLimit={maxDependentRisks || 1}
                            entities={lookupData.CorporateRisks.map(r => ({ key: r.ID, ID: r.ID, Title: `${r.RiskCode} - ${r.Title}` }))}
                            selectedEntities={action.CorporateRiskRiskMitigationActions?.map(rrma => rrma.RiskID)}
                            onChange={risks => changeEntityPicker(risks, 'CorporateRiskRiskMitigationActions', new RiskRiskMitigationAction(), 'RiskID')}
                            errorMessage={errors.RiskID}
                            disabled={action?.Risk?.Attributes?.filter(x => x.AttributeTypeID===1000).length > 0}
                        />
                        <CrTextField
                            label="Description"
                            className={styles.formField}
                            value={action.Description}
                            onChange={v => changeTextField(v, 'Description')}
                            maxLength={750}
                            multiline
                            rows={6}
                            disabled={action?.Risk?.Attributes?.filter(x => x.AttributeTypeID===1000).length > 0}
                        />
                        <CrUserPicker
                            label="Mitigating action owner"
                            className={styles.formField}
                            disabled={(!action.RiskID) || (action?.Risk?.Attributes?.filter(x => x.AttributeTypeID===1000).length > 0)}
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
                            disabled={action?.Risk?.Attributes?.filter(x => x.AttributeTypeID===1000).length > 0}
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
                                disabled={action?.Risk?.Attributes?.filter(x => x.AttributeTypeID===1000).length > 0}
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
            loadEntity={id => corporateRiskMitigationActionService.read(id, true, true)}
            loadNewEntity={() => new CorporateRiskMitigationAction()}
            loadEntityValidations={() => new RiskMitigationActionValidations()}
            onValidateEntity={validateEntity}
            onCreate={rma => corporateRiskMitigationActionService.create(rma)}
            onUpdate={rma => corporateRiskMitigationActionService.update(rma.ID, rma)}
            parentEntities={corporateRiskMitigationActionService.parentEntities}
            childEntities={[
                {
                    ObjectParentProperty: 'CorporateRiskRiskMitigationActions',
                    ParentIdProperty: 'RiskMitigationActionID',
                    ChildIdProperty: 'RiskID',
                    ChildService: corporateRiskRiskMitigationActionService
                },
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
