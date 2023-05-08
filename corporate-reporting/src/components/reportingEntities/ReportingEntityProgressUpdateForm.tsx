import React, { useContext, useMemo } from 'react';
import styles from '../../styles/cr.module.scss';
import { ProgressUpdateForm } from "../ProgressUpdateForm";
import {
    ICustomReportingEntity, ICustomReportingEntityUpdate, CustomReportingEntityUpdate, CustomReportingEntity,
    CrUpdateFormState, ProgressUpdateWithDeliveryDatesValidations, IEntityProgressUpdateFormProps, ICustomReportingEntityType
} from "../../types";
import { RagPicker } from '../cr/RagPicker';
import { CrTextField } from '../cr/CrTextField';
import { CrCheckbox } from '../cr/CrCheckbox';
import { CrDatePicker } from '../cr/CrDatePicker';
import { ContributorService, NumberService, ValidationService } from '../../services';
import { DeliveryDatesField } from '../cr/DeliveryDatesField';
import { CrNumberTextField } from '../cr/CrNumberTextField';
import { CrLabel } from '../cr/CrLabel';
import { currentDeliveryDate } from '../../services/DeliveryDateHelpers';
import { DataContext } from '../DataContext';
import { OrbUserContext } from '../OrbUserContext';

interface IReportingEntityProgressUpdateFormProps extends IEntityProgressUpdateFormProps<ICustomReportingEntity> {
    entityType: ICustomReportingEntityType;
}

class ReportingEntityProgressUpdateValidations extends ProgressUpdateWithDeliveryDatesValidations {
    public CurrentPerformance: string = null;
}

export class ReportingEntityProgressUpdateFormState extends CrUpdateFormState<ICustomReportingEntityUpdate, ReportingEntityProgressUpdateValidations, ICustomReportingEntity> {
    constructor(reportingEntityId: number, period: Date, parentEntity?: ICustomReportingEntity, showForm?: boolean) {
        super(
            new CustomReportingEntityUpdate(reportingEntityId, period),
            parentEntity || new CustomReportingEntity(1),
            new CustomReportingEntityUpdate(reportingEntityId),
            new ReportingEntityProgressUpdateValidations(),
            showForm || false
        );
    }
}

export const ReportingEntityProgressUpdateForm = (
    { entityId, entity, reportDates, entityType, ...otherProps }: IReportingEntityProgressUpdateFormProps
): React.ReactElement => {
    const { userContext } = useContext(OrbUserContext);
    const { dataServices: { reportingEntityService, reportingEntityUpdateService }, lookupData, loadLookupData: { reportingFrequencies } } = useContext(DataContext);
    useMemo(() => reportingFrequencies(), [reportingFrequencies]);

    const validateReportingEntityProgressUpdate = (reu: ICustomReportingEntityUpdate, re: ICustomReportingEntity): Promise<ReportingEntityProgressUpdateValidations> => {
        const errors = new ReportingEntityProgressUpdateValidations();

        if (entityType.UpdateNarrativeIsRequired && (reu.Comment == null || reu.Comment === '')) {
            errors.Comment = 'Progress update is required';
            errors.Valid = false;
        } else {
            errors.Comment = null;
        }

        if (entityType.UpdateDeliveryDatesIsRequired && !reu.ToBeClosed && currentDeliveryDate(re) < new Date() && reu.ForecastDate == null) {
            errors.ForecastDate = 'Forecast delivery date is required';
            errors.Valid = false;
        } else if (entityType.UpdateDeliveryDatesIsRequired && !reu.ToBeClosed && reu.ForecastDate !== null && reu.ForecastDate < new Date()) {
            errors.ForecastDate = 'Forecast delivery date cannot be in the past';
            errors.Valid = false;
        } else {
            errors.ForecastDate = null;
        }

        if (entityType.UpdateDeliveryDatesIsRequired && reu.ToBeClosed && reu.ActualDate == null) {
            errors.ActualDate = 'Actual delivery date is required if the activity is complete';
            errors.Valid = false;
        } else if (entityType.UpdateDeliveryDatesIsRequired && reu.ToBeClosed && reu.ActualDate !== null && reu.ActualDate > reportDates.Next) {
            errors.ActualDate = 'Actual delivery date cannot be in the future';
            errors.Valid = false;
        } else {
            errors.ActualDate = null;
        }

        if (entityType.UpdateRagIsRequired && reu.RagOptionID === null) {
            errors.RagOptionID = 'RAG rating is required';
            errors.Valid = false;
        } else {
            errors.RagOptionID = null;
        }

        if (entityType.UpdateMeasurementIsRequired && (reu.CurrentPerformance == null || reu.CurrentPerformance === '' || isNaN(Number(reu.CurrentPerformance)))) {
            errors.CurrentPerformance = 'Current performance is required and must be a number';
            errors.Valid = false;
        } else if (entityType.UpdateMeasurementIsRequired && !ValidationService.validSqlDecimal(Number(reu.CurrentPerformance))) {
            errors.CurrentPerformance = 'Current performance is too big';
            errors.Valid = false;
        } else {
            errors.CurrentPerformance = null;
        }

        return Promise.resolve(errors);
    };

    const ragLabel = (entityUpdate: ICustomReportingEntityUpdate) => {
        let isComplete = true;
        if (entityType.UpdateNarrativeIsRequired && !entityUpdate.Comment) {
            isComplete = false;
        }
        if (entityType.UpdateDeliveryDatesIsRequired && !entityUpdate.ForecastDate) {
            isComplete = false;
        }
        if (entityType.UpdateMeasurementIsRequired && NumberService.IsNullOrUndefined(entityUpdate.CurrentPerformance)) {
            isComplete = false;
        }
        return isComplete ? `Completed` : `To be completed`;
    };
    const rag = entityType.UpdateHasRag ? {} : { rag: null, ragLabel: ragLabel };

    return (
        <ProgressUpdateForm<ICustomReportingEntityUpdate, ReportingEntityProgressUpdateValidations, ICustomReportingEntity>
            {...otherProps}
            entityId={entityId}
            dueDate={() => reportDates?.Next}
            {...rag}
            renderFormFields={(
                { changeColor, changeTextField, changeCheckbox, clearField, changeDatePicker },
                { FormData: update, ParentEntity: e, ValidationErrors: errors, LastSignedOffUpdate: so }
            ) => {
                const targets = [];
                if (e.TargetPerformanceLowerLimit || e.TargetPerformanceLowerLimit == 0)
                    targets.push(Number(e.TargetPerformanceLowerLimit).toLocaleString('en-GB'));
                if (e.TargetPerformanceUpperLimit || e.TargetPerformanceUpperLimit == 0)
                    targets.push(Number(e.TargetPerformanceUpperLimit).toLocaleString('en-GB'));
                return (
                    <>
                        {entityType.UpdateHasRag &&
                            <RagPicker
                                label="RAG rating"
                                required={entityType.UpdateRagIsRequired}
                                className={styles.formField}
                                selectedRAG={update.RagOptionID}
                                onColorChanged={v => changeColor(v, 'RagOptionID')}
                                history={so.RagOptionID}
                                errorMessage={errors.RagOptionID}
                            />
                        }
                        {entityType.UpdateHasNarrative &&
                            <CrTextField
                                label="This period's update"
                                className={styles.formField}
                                required={entityType.UpdateNarrativeIsRequired}
                                multiline
                                rows={4}
                                maxLength={entityType.UpdateNarrativeMaxChars}
                                charCounter={true}
                                value={update.Comment}
                                onChange={v => changeTextField(v, 'Comment')}
                                history={so.Comment}
                                errorMessage={errors.Comment}
                            />
                        }
                        {entityType.UpdateHasMeasurement &&
                            <div className={styles.grid}>
                                <div className={styles.gridRow}>
                                    <div className={`${styles.gridCol} ${styles.sm6}`}>
                                        <CrNumberTextField
                                            label="Current performance"
                                            required={entityType.UpdateMeasurementIsRequired}
                                            className={styles.formField}
                                            maxLength={19}
                                            value={update.CurrentPerformance}
                                            onChange={v => changeTextField(v, 'CurrentPerformance')}
                                            history={NumberService.IsNullOrUndefined(so?.CurrentPerformance) ? null : Number(so?.CurrentPerformance)}
                                            errorMessage={errors.CurrentPerformance}
                                            suffix={e.MeasurementUnit?.Title} />
                                    </div>
                                    {entityType.HasUpperAndLowerTargets &&
                                        <div className={`${styles.gridCol} ${styles.sm6}`}>
                                            <CrLabel>Target performance</CrLabel>
                                            <p className={styles.formText}>
                                                {targets.length > 0 ?
                                                    targets.join(' - ')
                                                    :
                                                    "[Missing]"} {(targets.length > 0) && e.MeasurementUnit?.Title}
                                            </p>
                                        </div>
                                    }
                                </div>
                            </div>
                        }
                        {!update.ToBeClosed && entityType.UpdateHasDeliveryDates &&
                            <CrDatePicker
                                label="Forecast delivery date"
                                required={!update.ToBeClosed && entityType.UpdateDeliveryDatesIsRequired && currentDeliveryDate(e) < new Date()}
                                helpText="Revised date of delivery if the initial delivery date has changed"
                                className={styles.formField}
                                minDate={new Date()}
                                value={update.ForecastDate}
                                onSelectDate={d => changeDatePicker(d, 'ForecastDate')}
                                history={so.ForecastDate}
                                errorMessage={errors.ForecastDate}
                            />
                        }
                        <CrCheckbox
                            className={`${styles.formField} ${styles.checkbox}`}
                            label="Activity complete"
                            description="Tick this box to mark the activity as closed. Only do this if delivery is complete and there are no more actions to take."
                            checked={update.ToBeClosed}
                            onChange={(_, checked) =>
                                changeCheckbox(checked, 'ToBeClosed', () => clearField('ForecastDate', () => clearField('ActualDate')))
                            }
                        />
                        {update.ToBeClosed && entityType.UpdateHasDeliveryDates &&
                            <CrDatePicker
                                label="Actual delivery date"
                                required={update.ToBeClosed}
                                maxDate={reportDates?.Next}
                                className={styles.formField}
                                value={update.ActualDate}
                                onSelectDate={d => changeDatePicker(d, 'ActualDate')}
                                errorMessage={errors.ActualDate}
                            />
                        }
                        {entityType.UpdateHasDeliveryDates &&
                            <DeliveryDatesField
                                baseline={e.BaselineDate}
                                forecast={e.ForecastDate}
                            />
                        }
                    </>
                );
            }}
            loadEntity={id => reportingEntityService.read(id, true, true)}
            loadEntityUpdate={id => reportingEntityUpdateService.read(id)}
            loadNewEntityUpdate={() => new CustomReportingEntityUpdate(entityId, reportDates?.Next)}
            loadLastSavedProgressUpdate={() => reportDates?.Next &&
                reportingEntityUpdateService.readLatestUpdateForPeriod(entityId, reportDates.Next)}
            loadDefaultValues={(update, reportingEntity) => {
                const newUpdate = { ...update };
                if (entityType.UpdateHasDeliveryDates) {
                    newUpdate.ForecastDate = currentDeliveryDate(reportingEntity);
                }
                return newUpdate;
            }}
            loadLastSignedOffEntityUpdate={() => reportDates?.Previous &&
                reportingEntityUpdateService.readLastSignedOffUpdateForPeriod(entityId, reportDates.Previous)}
            onValidateUpdate={validateReportingEntityProgressUpdate}
            onBeforeSave={reu => reu.CurrentPerformance = NumberService.ToNumberOrNull(reu.CurrentPerformance)}
            onSaveUpdate={reu => reportingEntityUpdateService.create(reu)}
            onClearForm={(re, showForm) => new ReportingEntityProgressUpdateFormState(entityId, reportDates?.Next, re, showForm)}
            reportDates={reportDates}
            entity={entity}
            disableSave={re => ContributorService.UserIsReadOnlyContributor(userContext.Username, re)}
            reportingFrequencies={lookupData?.ReportingFrequencies}
        />
    );
};
