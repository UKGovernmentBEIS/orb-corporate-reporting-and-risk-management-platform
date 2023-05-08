import React, { useCallback, useContext, useEffect, useMemo, useState } from 'react';
import { IFinancialRisk, FinancialRisk, Attribute, Contributor, EntityValidations, ISpecificEntityFormProps, IFinancialRiskUpdate } from '../../types';
import { LookupService } from '../../services';
import styles from '../../styles/cr.module.scss';
import { CrDropdown } from '../cr/CrDropdown';
import { CrUserPicker } from '../cr/CrUserPicker';
import { CrTextField } from '../cr/CrTextField';
import { CrMultiDropdownWithText } from '../cr/CrMultiDropdownWithText';
import { CrReportingCyclePicker } from '../cr/CrReportingCyclePicker';
import { EntityForm } from '../EntityForm';
import { CrDatePicker } from '../cr/CrDatePicker';
import { ReportingCycleService } from '../../services/ReportingCycleService';
import { CrCheckbox } from '../cr/CrCheckbox';
import { DropdownMenuItemType, IDropdownOption } from 'office-ui-fabric-react';
import { EntityStatus } from '../../refData/EntityStatus';
import { CrComboBox } from '../cr/CrComboBox';
import { DataContext } from '../DataContext';
import { OrbUserContext } from '../OrbUserContext';

export class FinancialRiskValidations extends EntityValidations {
    public GroupID: string = null;
    public DirectorateID: string = null;
    public TargetPerformanceLowerLimit: string = null;
    public TargetPerformanceUpperLimit: string = null;
    public NormalContributors: string = null;
    public ReportingCycle: string = null;
    public RiskProximity: string = null;
    public RiskOwnerUserID: string = null;
    public StaffNonStaffSpend: string = null;
    public FundingClassification: string = null;
    public EconomicRingfence: string = null;
    public PolicyRingfence: string = null;
    public UniformChartOfAccountsID: string = null;
}

export const FinancialRiskForm = (props: ISpecificEntityFormProps): React.ReactElement => {
    const { errorHandling: { onError }, entityId } = props;
    const { userContext } = useContext(OrbUserContext);
    const [lastSignedOffRiskUpdate, setLastSignedOffRiskUpdate] = useState<IFinancialRiskUpdate>(null);
    const { dataServices: { attributeService, contributorService, financialRiskService,
        financialRiskUpdateService, riskPermissionsService },
        lookupData, loadLookupData: { attributeTypes, directorates, economicRingfences, entityStatuses, financialRisks,
            fundingClassifications, groups, policyRingfences, riskAppetites, riskImpactLevels, riskProbabilities, riskRegisters,
            budgetingEntities, userDirectorates, userGroups, users: { all: allUsers } } } = useContext(DataContext);
    const logError = useCallback(onError, [onError]);

    useMemo(() => attributeTypes(), [attributeTypes]);
    useMemo(() => budgetingEntities(), [budgetingEntities]);
    useMemo(() => directorates(), [directorates]);
    useMemo(() => economicRingfences(), [economicRingfences]);
    useMemo(() => entityStatuses(), [entityStatuses]);
    useMemo(() => financialRisks(), [financialRisks]);
    useMemo(() => fundingClassifications(), [fundingClassifications]);
    useMemo(() => groups(), [groups]);
    useMemo(() => policyRingfences(), [policyRingfences]);
    useMemo(() => riskAppetites(), [riskAppetites]);
    useMemo(() => riskImpactLevels(), [riskImpactLevels]);
    useMemo(() => riskProbabilities(), [riskProbabilities]);
    useMemo(() => riskRegisters(), [riskRegisters]);
    useMemo(() => userDirectorates(), [userDirectorates]);
    useMemo(() => userGroups(), [userGroups]);
    useMemo(() => allUsers(), [allUsers]);

    useEffect(() => {
        const loadLastSignedOffRiskUpdate = async (riskId: number): Promise<void> => {
            try {
                setLastSignedOffRiskUpdate(await financialRiskUpdateService.readLatestSignedOffUpdate(riskId));
            } catch (err) {
                logError(`Error loading latest risk update`, err.message);
            }
        };

        loadLastSignedOffRiskUpdate(entityId);
    }, [entityId, financialRiskUpdateService, logError]);

    const validateEntity = (financialRisk: IFinancialRisk): Promise<FinancialRiskValidations> => {
        const errors = new FinancialRiskValidations();

        if (financialRisk.Title === null || financialRisk.Title === '') {
            errors.Title = 'Financial risk name is required';
            errors.Valid = false;
        }
        else
            errors.Title = null;

        if (financialRisk.GroupID === null && !financialRisk.OwnedByMultipleGroups) {
            errors.GroupID = 'Group is required';
            errors.Valid = false;
        }
        else
            errors.GroupID = null;

        if (financialRisk.DirectorateID === null && !financialRisk.OwnedByDgOffice) {
            errors.DirectorateID = 'Directorate is required';
            errors.Valid = false;
        }
        else
            errors.DirectorateID = null;

        if (!ReportingCycleService.reportingCycleIsValid(financialRisk)) {
            errors.ReportingCycle = 'Please select all values for the reporting cycle';
            errors.Valid = false;
        }
        else
            errors.ReportingCycle = null;

        if (financialRisk.RiskOwnerUserID === null) {
            errors.RiskOwnerUserID = 'Risk owner is required';
            errors.Valid = false;
        }
        else
            errors.RiskOwnerUserID = null;

        if (financialRisk.StaffNonStaffSpend == null) {
            errors.StaffNonStaffSpend = 'You must set whether the risk concerns staff/non-staff spend';
            errors.Valid = false;
        } else
            errors.StaffNonStaffSpend = null;

        if (financialRisk.FundingClassification == null || financialRisk.FundingClassification?.length < 1) {
            errors.FundingClassification = 'You must pick at least one funding classification';
            errors.Valid = false;
        } else
            errors.FundingClassification = null;

        if (financialRisk.EconomicRingfence == null || financialRisk.EconomicRingfence?.length < 1) {
            errors.EconomicRingfence = 'You must pick at least one economic ring-fence';
            errors.Valid = false;
        } else
            errors.EconomicRingfence = null;

        if (financialRisk.PolicyRingfence == null || financialRisk.PolicyRingfence?.length < 1) {
            errors.PolicyRingfence = 'You must pick at least one policy ring-fence';
            errors.Valid = false;
        } else
            errors.PolicyRingfence = null;

        if (financialRisk.UniformChartOfAccountsID == null) {
            errors.UniformChartOfAccountsID = 'You must specify the Budgeting entity to which the risk belongs';
            errors.Valid = false;
        } else
            errors.UniformChartOfAccountsID = null;


        return Promise.resolve(errors);
    };

    return (
        <EntityForm<IFinancialRisk, FinancialRiskValidations>
            {...props}
            entityName="Financial risk"
            renderFormFields={(changeHandlers, formState) => {
                const { FormData: risk, ValidationErrors: errors } = formState;
                const today = new Date();
                const nowPlusOneMonth = new Date(Date.UTC(today.getFullYear(), today.getMonth() + 1, 0)); // AL: Not sure why this was implemented like this

                const changeGroup = (_, o: IDropdownOption) => {
                    if (o.key === 0) {
                        changeHandlers.changeCheckbox(true, 'OwnedByMultipleGroups',
                            () => changeHandlers.clearField('GroupID',
                                () => changeHandlers.changeCheckbox(true, 'OwnedByDgOffice')
                            )
                        );
                    } else {
                        changeHandlers.changeDropdown(o, 'GroupID', null,
                            () => changeHandlers.clearField('DirectorateID',
                                () => changeHandlers.clearField('OwnedByDgOffice',
                                    () => changeHandlers.clearField('OwnedByMultipleGroups')
                                )
                            )
                        );
                    }
                };
                const changeDirectorate = (_, o: IDropdownOption) => {
                    if (o.key === 0) {
                        changeHandlers.changeCheckbox(true, 'OwnedByDgOffice', () => changeHandlers.clearField('DirectorateID'));
                    } else {
                        if (o.key > 0) {
                            changeHandlers.changeDropdown(o, 'DirectorateID', null, () => changeHandlers.clearField('OwnedByDgOffice'));
                        }
                    }
                };

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
                        />
                        <CrDatePicker
                            label="Date risk created"
                            className={styles.formField}
                            value={risk.RiskRegisteredDate}
                            onSelectDate={date => changeHandlers.changeDatePicker(date, 'RiskRegisteredDate')}
                        />
                        <CrDropdown
                            label="Group"
                            className={styles.formField}
                            required={true}
                            options={[
                                { key: 0, text: 'Central' },
                                { key: 'divider_1', text: '-', itemType: DropdownMenuItemType.Divider },
                                ...LookupService.entitiesToSelectableOptions(lookupData.Groups)
                            ]}
                            selectedKey={risk.OwnedByMultipleGroups ? 0 : risk.GroupID}
                            onChange={changeGroup}
                            errorMessage={errors.GroupID}
                        />
                        <CrDropdown
                            label="Directorate"
                            className={styles.formField}
                            required={true}
                            options={
                                risk.OwnedByMultipleGroups ? [{ key: 0, text: `Central` }]
                                    : risk.GroupID !== null ? [
                                        { key: 0, text: `DG Office` },
                                        { key: 'divider_1', text: '-', itemType: DropdownMenuItemType.Divider },
                                        ...LookupService.entitiesToSelectableOptions(lookupData.Directorates.filter(d => d.GroupID === risk.GroupID))
                                    ] : [{ key: -1, text: 'Select a group' }]}
                            selectedKey={risk.OwnedByDgOffice ? 0 : risk.DirectorateID}
                            onChange={changeDirectorate}
                            errorMessage={errors.DirectorateID}
                        />
                        <CrReportingCyclePicker
                            label="Reports due:"
                            required={true}
                            className={styles.formField}
                            cycle={{ frequency: risk.ReportingFrequency, dueDay: risk.ReportingDueDay, startDate: risk.ReportingStartDate }}
                            onChange={cycle => changeHandlers.changeReportingCycle(cycle)}
                            errorMessage={errors.ReportingCycle}
                        />
                        <CrUserPicker
                            label="Risk owner (approver)"
                            required={true}
                            className={styles.formField}
                            users={lookupData.Users?.All}
                            selectedUsers={risk.RiskOwnerUserID && [risk.RiskOwnerUserID]}
                            onChange={u => changeHandlers.changeUserPicker(u, 'RiskOwnerUserID')}
                            errorMessage={errors.RiskOwnerUserID}
                        />
                        <CrUserPicker
                            label="Alternative risk approver"
                            required={false}
                            className={styles.formField}
                            users={lookupData.Users?.All}
                            selectedUsers={risk.ReportApproverUserID && [risk.ReportApproverUserID]}
                            onChange={u => changeHandlers.changeUserPicker(u, 'ReportApproverUserID')}
                        />
                        <CrUserPicker
                            label="Contributors"
                            className={styles.formField}
                            users={lookupData.Users?.All}
                            itemLimit={6}
                            selectedUsers={risk.Contributors?.map(c => c.ContributorUserID)}
                            onChange={v => changeHandlers.changeMultiUserPicker(v, 'Contributors', new Contributor(), 'ContributorUserID')}
                            errorMessage={errors.NormalContributors}
                        />
                        <CrDropdown
                            label="Does the spend risk concern staff/non-staff spend?"
                            className={styles.formField}
                            required={true}
                            options={[{ key: 'Staff', text: 'Staff' }, { key: 'Non-staff', text: 'Non-staff' }, { key: 'Both', text: 'Both' }]}
                            selectedKey={risk.StaffNonStaffSpend}
                            onChange={(_, v) => changeHandlers.changeDropdown(v, 'StaffNonStaffSpend')}
                            errorMessage={errors.StaffNonStaffSpend}
                        />
                        <CrDropdown
                            label="Funding classification"
                            className={styles.formField}
                            required={true}
                            multiSelect
                            options={LookupService.arrayToDropdownOptions([...new Set([
                                ...lookupData.FundingClassifications?.map(fc => fc.Title),
                                ...risk.FundingClassification
                            ])])}
                            selectedKeys={risk.FundingClassification}
                            onChange={(_, v) => changeHandlers.changeMultiDropdownStringArray(v, 'FundingClassification')}
                            errorMessage={errors.FundingClassification}
                        />
                        <CrDropdown
                            label="Economic ring-fence"
                            className={styles.formField}
                            required={true}
                            multiSelect
                            options={LookupService.arrayToDropdownOptions([...new Set([
                                ...lookupData.EconomicRingfences?.map(erf => erf.Title),
                                ...risk.EconomicRingfence
                            ])])}
                            selectedKeys={risk.EconomicRingfence}
                            onChange={(_, v) => changeHandlers.changeMultiDropdownStringArray(v, 'EconomicRingfence')}
                            errorMessage={errors.EconomicRingfence}
                        />
                        <CrDropdown
                            label="Policy ring-fence"
                            className={styles.formField}
                            required={true}
                            multiSelect
                            options={LookupService.arrayToDropdownOptions([...new Set([
                                ...lookupData.PolicyRingfences?.map(prf => prf.Title),
                                ...risk.PolicyRingfence
                            ])])}
                            selectedKeys={risk.PolicyRingfence}
                            onChange={(_, v) => changeHandlers.changeMultiDropdownStringArray(v, 'PolicyRingfence')}
                            errorMessage={errors.PolicyRingfence}
                        />
                        <CrComboBox
                            label="Budgeting entity"
                            className={styles.formField}
                            autoComplete="on"
                            required={true}
                            options={LookupService.arrayToDropdownOptions([...new Set([
                                ...lookupData.BudgetingEntities?.map(ucoa => ucoa.Title),
                                risk.UniformChartOfAccountsID
                            ].filter(u => u))])}
                            selectedKey={risk.UniformChartOfAccountsID}
                            onChange={(_, v) => changeHandlers.changeDropdown(v, 'UniformChartOfAccountsID')}
                            errorMessage={errors.UniformChartOfAccountsID}
                        />
                        <CrTextField
                            label="Risk event description"
                            maxLength={750}
                            rows={6}
                            multiline
                            className={styles.formField}
                            value={risk.RiskEventDescription}
                            onChange={v => changeHandlers.changeTextField(v, 'RiskEventDescription')}
                        />
                        <CrTextField
                            label="Risk cause description"
                            maxLength={750}
                            rows={6}
                            multiline
                            className={styles.formField}
                            value={risk.RiskCauseDescription}
                            onChange={v => changeHandlers.changeTextField(v, 'RiskCauseDescription')}
                        />
                        <CrTextField
                            label="Risk impact description"
                            maxLength={750}
                            rows={6}
                            multiline
                            className={styles.formField}
                            value={risk.RiskImpactDescription}
                            onChange={v => changeHandlers.changeTextField(v, 'RiskImpactDescription')}
                        />
                        <CrDropdown
                            label="Unmitigated probability"
                            className={styles.formField}
                            options={LookupService.entitiesToSelectableOptionsFilteredByDate(nowPlusOneMonth, lookupData.RiskProbabilities)}
                            selectedKey={risk.UnmitigatedRiskProbabilityID}
                            onChange={(_, v) => changeHandlers.changeDropdown(v, 'UnmitigatedRiskProbabilityID')}
                        />
                        <CrDropdown
                            label="Unmitigated impact"
                            className={styles.formField}
                            options={LookupService.entitiesToSelectableOptionsFilteredByDate(nowPlusOneMonth, lookupData.RiskImpactLevels)}
                            selectedKey={risk.UnmitigatedRiskImpactLevelID}
                            onChange={(_, v) => changeHandlers.changeDropdown(v, 'UnmitigatedRiskImpactLevelID')}
                        />
                        <CrDropdown
                            label="Target probability"
                            className={styles.formField}
                            options={LookupService.entitiesToSelectableOptionsFilteredByDate(nowPlusOneMonth, lookupData.RiskProbabilities)}
                            selectedKey={risk.TargetRiskProbabilityID}
                            onChange={(_, v) => changeHandlers.changeDropdown(v, 'TargetRiskProbabilityID')}
                        />
                        <CrDropdown
                            label="Target impact"
                            className={styles.formField}
                            options={LookupService.entitiesToSelectableOptionsFilteredByDate(nowPlusOneMonth, lookupData.RiskImpactLevels)}
                            selectedKey={risk.TargetRiskImpactLevelID}
                            onChange={(_, v) => changeHandlers.changeDropdown(v, 'TargetRiskImpactLevelID')}
                        />
                        <CrCheckbox
                            label="Is the risk ongoing?"
                            className={styles.formField}
                            checked={risk.RiskIsOngoing}
                            onChange={(_, isChecked) => changeHandlers.changeCheckbox(isChecked, 'RiskIsOngoing')}
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
                        <CrMultiDropdownWithText
                            label="Attributes"
                            className={styles.formField}
                            textMaxLength={255}
                            options={LookupService.attributeTypesToMultiDropdownWithTextOptions(lookupData.AttributeTypes)}
                            selectedItems={LookupService.attributesToDropdownWithText(risk.Attributes)}
                            onChange={v => changeHandlers.changeMultiDropdownWithText(v, 'Attributes', new Attribute(), 'AttributeTypeID', 'AttributeValue')}
                        />
                        {(formState.FormDataBeforeChanges.EntityStatusID === EntityStatus.Closed
                            || riskPermissionsService.RiskCanBeClosed(userContext.UserEntities, risk, lastSignedOffRiskUpdate)) &&
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
            loadEntity={financialRiskId => financialRiskService.read(financialRiskId, true, true)}
            loadNewEntity={() => new FinancialRisk()}
            loadEntityValidations={() => new FinancialRiskValidations()}
            onValidateEntity={validateEntity}
            onBeforeSave={risk => { delete risk.Directorate; delete risk.Project; delete risk.Attributes; }}
            onCreate={r => financialRiskService.create(r)}
            onUpdate={r => financialRiskService.update(r.ID, r)}
            parentEntities={financialRiskService.parentEntities}
            childEntities={[
                { ObjectParentProperty: 'Contributors', ParentIdProperty: 'RiskID', ChildIdProperty: 'ContributorUserID', ChildService: contributorService },
                { ObjectParentProperty: 'Attributes', ParentIdProperty: 'RiskID', ChildIdProperty: 'AttributeTypeID', ChildService: attributeService }
            ]}
            includePropertiesOnSave={['FundingClassification', 'EconomicRingfence', 'PolicyRingfence']}
        />
    );
};
