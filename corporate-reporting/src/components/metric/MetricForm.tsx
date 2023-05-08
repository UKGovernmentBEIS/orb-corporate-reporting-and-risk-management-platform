import React, { useContext, useMemo } from 'react';
import { EntityValidations, IMetric, Contributor, Attribute, ISpecificEntityFormProps, Metric } from '../../types';
import { LookupService, ValidationService } from '../../services';
import styles from '../../styles/cr.module.scss';
import { CrUserPicker } from '../cr/CrUserPicker';
import { CrNumberTextField } from '../cr/CrNumberTextField';
import { CrDropdown } from '../cr/CrDropdown';
import { EntityStatus } from '../../refData/EntityStatus';
import { CrTextField } from '../cr/CrTextField';
import { CrMultiDropdownWithText } from '../cr/CrMultiDropdownWithText';
import { CrReportingCyclePicker } from '../cr/CrReportingCyclePicker';
import { EntityForm } from '../EntityForm';
import { ReportingCycleService } from '../../services/ReportingCycleService';
import { DataContext } from '../DataContext';

export class MetricValidations extends EntityValidations {
    public DirectorateID: string = null;
    public TargetPerformanceLowerLimit: string = null;
    public TargetPerformanceUpperLimit: string = null;
    public NormalContributors: string = null;
    public ReportingCycle: string = null;
}

export const MetricForm = (props: ISpecificEntityFormProps): React.ReactElement => {
    const { dataServices, lookupData, loadLookupData: {
        attributeTypes, directorates, entityStatuses, measurementUnits, userDirectorates, users: { all: allUsers } }
    } = useContext(DataContext);

    useMemo(() => attributeTypes(), [attributeTypes]);
    useMemo(() => directorates(), [directorates]);
    useMemo(() => entityStatuses(), [entityStatuses]);
    useMemo(() => measurementUnits(), [measurementUnits]);
    useMemo(() => userDirectorates(), [userDirectorates]);
    useMemo(() => allUsers(), [allUsers]);

    const validateEntity = (metric: IMetric): Promise<MetricValidations> => {
        const errors = new MetricValidations();

        if (metric.Title === null || metric.Title === '') {
            errors.Title = 'Metric name is required';
            errors.Valid = false;
        }
        else
            errors.Title = null;

        if (metric.DirectorateID === null) {
            errors.DirectorateID = 'Directorate is required';
            errors.Valid = false;
        }
        else
            errors.DirectorateID = null;

        if (metric.TargetPerformanceLowerLimit !== null && isNaN(Number(metric.TargetPerformanceLowerLimit))) {
            errors.TargetPerformanceLowerLimit = 'Target performance lower limit must be a number';
            errors.Valid = false;
        } else if (metric.TargetPerformanceLowerLimit !== null && !ValidationService.validSqlDecimal(Number(metric.TargetPerformanceLowerLimit))) {
            errors.TargetPerformanceLowerLimit = 'Target performance lower limit is too big';
            errors.Valid = false;
        }
        else
            errors.TargetPerformanceLowerLimit = null;

        if (metric.TargetPerformanceUpperLimit !== null && isNaN(Number(metric.TargetPerformanceUpperLimit))) {
            errors.TargetPerformanceUpperLimit = 'Target performance upper limit must be a number';
            errors.Valid = false;
        } else if (metric.TargetPerformanceUpperLimit !== null && !ValidationService.validSqlDecimal(Number(metric.TargetPerformanceUpperLimit))) {
            errors.TargetPerformanceUpperLimit = 'Target performance upper limit is too big';
            errors.Valid = false;
        }
        else
            errors.TargetPerformanceUpperLimit = null;

        if (metric.Contributors.some(ct => ct.ContributorUserID === metric.LeadUserID)) {
            errors.NormalContributors = 'A user cannot be both the lead and a contributor';
            errors.Valid = false;
        }
        else
            errors.NormalContributors = null;

        if (!ReportingCycleService.reportingCycleIsValid(metric)) {
            errors.ReportingCycle = 'Please select all values for the reporting cycle';
            errors.Valid = false;
        }
        else
            errors.ReportingCycle = null;

        return Promise.resolve(errors);
    };
    return (
        <EntityForm<IMetric, MetricValidations>
            {...props}
            entityName="Metric"
            renderFormFields={(changeHandlers, formState) => {
                const { FormData: metric, ValidationErrors: errors } = formState;
                const mappedUsers = LookupService.directorateUsers(lookupData, metric.DirectorateID, metric);
                const suggestions = {
                    initialSuggestionsHeaderText: `Directorate users`,
                    initialSuggestions: mappedUsers,
                    noResultsFoundText: mappedUsers.length === 0 ? `No users are mapped to this metric's directorate` : null
                };
                return (
                    <div>
                        <CrDropdown
                            label="Directorate"
                            required={true}
                            className={styles.formField}
                            options={LookupService.entitiesToSelectableOptions(lookupData.Directorates)}
                            selectedKey={metric.DirectorateID}
                            onChange={(_, option, index) => changeHandlers.changeComboBox(option, 'DirectorateID', index)}
                            errorMessage={errors.DirectorateID}
                        />
                        <CrTextField
                            label="Metric ID"
                            maxLength={255}
                            className={styles.formField}
                            value={metric.MetricCode}
                            onChange={v => changeHandlers.changeTextField(v, 'MetricCode')}
                        />
                        <CrTextField
                            label="Name"
                            maxLength={255}
                            required={true}
                            className={styles.formField}
                            value={metric.Title}
                            onChange={v => changeHandlers.changeTextField(v, 'Title')}
                            errorMessage={errors.Title}
                        />
                        <CrTextField
                            label="Description"
                            multiline
                            rows={4}
                            className={styles.formField}
                            value={metric.Description}
                            onChange={v => changeHandlers.changeTextField(v, 'Description')}
                        />
                        <CrReportingCyclePicker
                            label="Reports due:"
                            required={true}
                            className={styles.formField}
                            cycle={{ frequency: metric.ReportingFrequency, dueDay: metric.ReportingDueDay, startDate: metric.ReportingStartDate }}
                            onChange={cycle => changeHandlers.changeReportingCycle(cycle)}
                            errorMessage={errors.ReportingCycle}
                        />
                        <CrDropdown
                            label="Target performance unit"
                            className={styles.formField}
                            options={LookupService.entitiesToSelectableOptions(lookupData.MeasurementUnits)}
                            selectedKey={metric.MeasurementUnitID}
                            onChange={(_, v) => changeHandlers.changeDropdown(v, 'MeasurementUnitID')}
                        />
                        <CrNumberTextField
                            label="Target performance lower limit"
                            maxLength={19}
                            className={styles.formField}
                            value={metric.TargetPerformanceLowerLimit}
                            onChange={v => changeHandlers.changeTextField(v, 'TargetPerformanceLowerLimit')}
                            errorMessage={errors.TargetPerformanceLowerLimit}
                        />
                        <CrNumberTextField
                            label="Target performance upper limit"
                            maxLength={19}
                            className={styles.formField}
                            value={metric.TargetPerformanceUpperLimit}
                            onChange={v => changeHandlers.changeTextField(v, 'TargetPerformanceUpperLimit')}
                            errorMessage={errors.TargetPerformanceUpperLimit}
                        />
                        <CrUserPicker
                            label="Lead"
                            className={styles.formField}
                            disabled={!metric.DirectorateID}
                            users={mappedUsers}
                            selectedUsers={metric.LeadUserID && [metric.LeadUserID]}
                            onChange={v => changeHandlers.changeUserPicker(v, 'LeadUserID')}
                            {...suggestions}
                        />
                        <CrUserPicker
                            label="Contributors"
                            className={styles.formField}
                            disabled={!metric.DirectorateID}
                            users={mappedUsers}
                            itemLimit={3}
                            selectedUsers={metric.Contributors?.map(c => c.ContributorUserID)}
                            onChange={v => changeHandlers.changeMultiUserPicker(v, 'Contributors', new Contributor(), 'ContributorUserID')}
                            errorMessage={errors.NormalContributors}
                            {...suggestions}
                        />
                        <CrMultiDropdownWithText
                            label="Attributes"
                            className={styles.formField}
                            textMaxLength={255}
                            options={LookupService.attributeTypesToMultiDropdownWithTextOptions(lookupData.AttributeTypes)}
                            selectedItems={LookupService.attributesToDropdownWithText(metric.Attributes)}
                            onChange={v => changeHandlers.changeMultiDropdownWithText(v, 'Attributes', new Attribute(), 'AttributeTypeID', 'AttributeValue')}
                        />
                        {formState.FormDataBeforeChanges.EntityStatusID === EntityStatus.Closed &&
                            <CrDropdown
                                label="Status"
                                className={styles.formField}
                                options={LookupService.entitiesToSelectableOptions(lookupData.EntityStatuses)}
                                selectedKey={metric.EntityStatusID}
                                onChange={(_, o) => changeHandlers.changeDropdown(o, 'EntityStatusID')}
                            />
                        }
                    </div>
                );
            }}
            loadEntity={id => dataServices.metricService.read(id, true, true)}
            loadNewEntity={() => new Metric()}
            loadEntityValidations={() => new MetricValidations()}
            onValidateEntity={validateEntity}
            onCreate={m => dataServices.metricService.create(m)}
            onUpdate={m => dataServices.metricService.update(m.ID, m)}
            onBeforeSave={m => {
                m.TargetPerformanceLowerLimit = m.TargetPerformanceLowerLimit || m.TargetPerformanceLowerLimit === 0 ? Number(m.TargetPerformanceLowerLimit) : null;
                m.TargetPerformanceUpperLimit = m.TargetPerformanceUpperLimit || m.TargetPerformanceUpperLimit === 0 ? Number(m.TargetPerformanceUpperLimit) : null;
            }}
            parentEntities={dataServices.metricService.parentEntities}
            childEntities={[
                { ObjectParentProperty: 'Contributors', ParentIdProperty: 'MetricID', ChildIdProperty: 'ContributorUserID', ChildService: dataServices.contributorService },
                { ObjectParentProperty: 'Attributes', ParentIdProperty: 'MetricID', ChildIdProperty: 'AttributeTypeID', ChildService: dataServices.attributeService }
            ]}
        />
    );
};
