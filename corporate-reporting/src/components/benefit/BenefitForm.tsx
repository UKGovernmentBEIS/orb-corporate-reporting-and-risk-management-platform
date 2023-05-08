import React, { useContext, useMemo } from 'react';
import { IBenefit, Benefit, Attribute, Contributor, EntityValidations, ISpecificEntityFormProps } from '../../types';
import { LookupService, ValidationService } from '../../services';
import styles from '../../styles/cr.module.scss';
import { CrDropdown } from '../cr/CrDropdown';
import { CrUserPicker } from '../cr/CrUserPicker';
import { CrNumberTextField } from '../cr/CrNumberTextField';
import { EntityStatus } from '../../refData/EntityStatus';
import { CrTextField } from '../cr/CrTextField';
import { CrMultiDropdownWithText } from '../cr/CrMultiDropdownWithText';
import { CrReportingCyclePicker } from '../cr/CrReportingCyclePicker';
import { CrComboBox } from '../cr/CrComboBox';
import { EntityForm } from '../EntityForm';
import { CrDatePicker } from '../cr/CrDatePicker';
import { ReportingCycleService } from '../../services/ReportingCycleService';
import { DataContext } from '../DataContext';

export class BenefitValidations extends EntityValidations {
    public ProjectID: string = null;
    public TargetPerformanceLowerLimit: string = null;
    public TargetPerformanceUpperLimit: string = null;
    public NormalContributors: string = null;
    public ReportingCycle: string = null;
}

export const BenefitForm = (props: ISpecificEntityFormProps): React.ReactElement => {
    const { dataServices: { attributeService, benefitService, contributorService } } = useContext(DataContext);
    const { lookupData, loadLookupData: { attributeTypes, benefitTypes, entityStatuses, measurementUnits, projects, userProjects, users: { all: allUsers } } } = useContext(DataContext);

    useMemo(() => attributeTypes(), [attributeTypes]);
    useMemo(() => benefitTypes(), [benefitTypes]);
    useMemo(() => entityStatuses(), [entityStatuses]);
    useMemo(() => measurementUnits(), [measurementUnits]);
    useMemo(() => projects(), [projects]);
    useMemo(() => userProjects(), [userProjects]);
    useMemo(() => allUsers(), [allUsers]);

    const validateEntity = (benefit: IBenefit): Promise<BenefitValidations> => {
        const errors = new BenefitValidations();

        if (benefit.Title === null || benefit.Title === '') {
            errors.Title = 'Benefit name is required';
            errors.Valid = false;
        }
        else
            errors.Title = null;

        if (benefit.ProjectID === null) {
            errors.ProjectID = 'Project is required';
            errors.Valid = false;
        }
        else
            errors.ProjectID = null;

        if (benefit.TargetPerformanceLowerLimit !== null && isNaN(Number(benefit.TargetPerformanceLowerLimit))) {
            errors.TargetPerformanceLowerLimit = 'Target performance lower limit must be a number';
            errors.Valid = false;
        } else if (benefit.TargetPerformanceLowerLimit !== null && !ValidationService.validSqlDecimal(Number(benefit.TargetPerformanceLowerLimit))) {
            errors.TargetPerformanceLowerLimit = 'Target performance lower limit is too big';
            errors.Valid = false;
        }
        else
            errors.TargetPerformanceLowerLimit = null;

        if (benefit.TargetPerformanceUpperLimit !== null && isNaN(Number(benefit.TargetPerformanceUpperLimit))) {
            errors.TargetPerformanceUpperLimit = 'Target performance upper limit must be a number';
            errors.Valid = false;
        } else if (benefit.TargetPerformanceUpperLimit !== null && !ValidationService.validSqlDecimal(Number(benefit.TargetPerformanceUpperLimit))) {
            errors.TargetPerformanceUpperLimit = 'Target performance upper limit is too big';
            errors.Valid = false;
        }
        else
            errors.TargetPerformanceUpperLimit = null;

        if (benefit.Contributors.some(ct => ct.ContributorUserID == benefit.LeadUserID)) {
            errors.NormalContributors = 'A user cannot be both the lead and a contributor';
            errors.Valid = false;
        }
        else
            errors.NormalContributors = null;

        if (!ReportingCycleService.reportingCycleIsValid(benefit)) {
            errors.ReportingCycle = 'Please select all values for the reporting cycle';
            errors.Valid = false;
        }
        else
            errors.ReportingCycle = null;

        return Promise.resolve(errors);
    };

    return (
        <EntityForm<IBenefit, BenefitValidations>
            {...props}
            entityName="Benefit"
            renderFormFields={(changeHandlers, formState) => {
                const { FormData: benefit, ValidationErrors: errors } = formState;
                const mappedUsers = LookupService.projectUsers(lookupData, benefit.ProjectID, benefit);
                const suggestions = {
                    initialSuggestionsHeaderText: `Project users`,
                    initialSuggestions: mappedUsers,
                    noResultsFoundText: mappedUsers.length === 0 ? `No users are mapped to this benefit's project` : null
                };
                return (
                    <div>
                        <CrComboBox
                            label="Project"
                            autoComplete="on"
                            className={styles.formField}
                            required={true}
                            options={LookupService.entitiesToSelectableOptions(lookupData.Projects)}
                            selectedKey={benefit.ProjectID}
                            onChange={(_, v) => changeHandlers.changeComboBox(v, 'ProjectID')}
                            errorMessage={errors.ProjectID}
                        />
                        <CrTextField
                            label="Name"
                            className={styles.formField}
                            required={true}
                            maxLength={255}
                            value={benefit.Title}
                            onChange={v => changeHandlers.changeTextField(v, 'Title')}
                            errorMessage={errors.Title}
                        />
                        <CrTextField
                            label="Description"
                            className={styles.formField}
                            value={benefit.Description}
                            maxLength={500}
                            onChange={v => changeHandlers.changeTextField(v, 'Description')}
                            multiline
                        />
                        <CrDatePicker
                            label="Baseline realisation date"
                            className={styles.formField}
                            value={benefit.BaselineDate}
                            onSelectDate={d => changeHandlers.changeDatePicker(d, 'BaselineDate')}
                        />
                        <CrReportingCyclePicker
                            label="Reports due:"
                            required={true}
                            className={styles.formField}
                            cycle={{ frequency: benefit.ReportingFrequency, dueDay: benefit.ReportingDueDay, startDate: benefit.ReportingStartDate }}
                            onChange={cycle => changeHandlers.changeReportingCycle(cycle)}
                            errorMessage={errors.ReportingCycle}
                        />
                        <CrDropdown
                            label="Type"
                            className={styles.formField}
                            options={LookupService.entitiesToSelectableOptions(lookupData.BenefitTypes)}
                            selectedKey={benefit.BenefitTypeID}
                            onChange={(_, v) => changeHandlers.changeDropdown(v, 'BenefitTypeID')}
                        />
                        <CrDropdown
                            label="Target performance unit"
                            className={styles.formField}
                            options={LookupService.entitiesToSelectableOptions(lookupData.MeasurementUnits)}
                            selectedKey={benefit.MeasurementUnitID}
                            onChange={(_, v) => changeHandlers.changeDropdown(v, 'MeasurementUnitID')}
                        />
                        <CrNumberTextField
                            label="Target performance lower limit"
                            className={styles.formField}
                            maxLength={19}
                            value={benefit.TargetPerformanceLowerLimit}
                            onChange={v => changeHandlers.changeTextField(v, 'TargetPerformanceLowerLimit')}
                            errorMessage={errors.TargetPerformanceLowerLimit}
                        />
                        <CrNumberTextField
                            label="Target performance upper limit"
                            className={styles.formField}
                            maxLength={19}
                            value={benefit.TargetPerformanceUpperLimit}
                            onChange={v => changeHandlers.changeTextField(v, 'TargetPerformanceUpperLimit')}
                            errorMessage={errors.TargetPerformanceUpperLimit}
                        />
                        <CrUserPicker
                            label="Lead"
                            className={styles.formField}
                            disabled={!benefit.ProjectID}
                            users={mappedUsers}
                            selectedUsers={benefit.LeadUserID && [benefit.LeadUserID]}
                            onChange={v => changeHandlers.changeUserPicker(v, 'LeadUserID')}
                            {...suggestions}
                        />
                        <CrUserPicker
                            label="Contributors"
                            className={styles.formField}
                            disabled={!benefit.ProjectID}
                            users={mappedUsers}
                            itemLimit={3}
                            selectedUsers={benefit.Contributors?.map(c => c.ContributorUserID)}
                            onChange={v => changeHandlers.changeMultiUserPicker(v, 'Contributors', new Contributor(), 'ContributorUserID')}
                            errorMessage={errors.NormalContributors}
                            {...suggestions}
                        />
                        <CrMultiDropdownWithText
                            label="Attributes"
                            className={styles.formField}
                            textMaxLength={255}
                            options={LookupService.attributeTypesToMultiDropdownWithTextOptions(lookupData.AttributeTypes)}
                            selectedItems={LookupService.attributesToDropdownWithText(benefit.Attributes)}
                            onChange={v => changeHandlers.changeMultiDropdownWithText(v, 'Attributes', new Attribute(), 'AttributeTypeID', 'AttributeValue')}
                        />
                        {formState.FormDataBeforeChanges.EntityStatusID === EntityStatus.Closed &&
                            <CrDropdown
                                label="Status"
                                className={styles.formField}
                                options={LookupService.entitiesToSelectableOptions(lookupData.EntityStatuses)}
                                selectedKey={benefit.EntityStatusID}
                                onChange={(_, o) => changeHandlers.changeDropdown(o, 'EntityStatusID')}
                            />
                        }
                    </div>
                );
            }}
            loadEntity={benefitId => benefitService.read(benefitId, true, true)}
            loadNewEntity={() => new Benefit()}
            loadEntityValidations={() => new BenefitValidations()}
            onValidateEntity={validateEntity}
            onBeforeSave={benefit => {
                benefit.TargetPerformanceLowerLimit = benefit.TargetPerformanceLowerLimit || benefit.TargetPerformanceLowerLimit === 0 ? Number(benefit.TargetPerformanceLowerLimit) : null;
                benefit.TargetPerformanceUpperLimit = benefit.TargetPerformanceUpperLimit || benefit.TargetPerformanceUpperLimit === 0 ? Number(benefit.TargetPerformanceUpperLimit) : null;
            }}
            onCreate={b => benefitService.create(b)}
            onUpdate={b => benefitService.update(b.ID, b)}
            parentEntities={benefitService.parentEntities}
            childEntities={[
                { ObjectParentProperty: 'Contributors', ParentIdProperty: 'BenefitID', ChildIdProperty: 'ContributorUserID', ChildService: contributorService },
                { ObjectParentProperty: 'Attributes', ParentIdProperty: 'BenefitID', ChildIdProperty: 'AttributeTypeID', ChildService: attributeService }
            ]}
        />
    );
};
