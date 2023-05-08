import React, { useContext, useEffect, useMemo, useState } from 'react';
import styles from '../../styles/cr.module.scss';
import { ProgressUpdateForm } from "../ProgressUpdateForm";
import {
    CrUpdateFormState, IEntityProgressUpdateFormProps,
    IBenefit, IBenefitUpdate, BenefitUpdate, Benefit, ProgressUpdateWithDeliveryDatesValidations, IReportDueDates
} from "../../types";
import { RagPicker } from '../cr/RagPicker';
import { CrTextField } from '../cr/CrTextField';
import { CrNumberTextField } from '../cr/CrNumberTextField';
import { Label } from 'office-ui-fabric-react/lib/Label';
import { CrCheckbox } from '../cr/CrCheckbox';
import { EntityPeopleService, NumberService, ValidationService } from '../../services';
import { CrDatePicker } from '../cr/CrDatePicker';
import { DeliveryDatesField } from '../cr/DeliveryDatesField';
import { currentDeliveryDate } from '../../services/DeliveryDateHelpers';
import { DataContext } from '../DataContext';

export class BenefitUpdateFormValidations extends ProgressUpdateWithDeliveryDatesValidations {
    public CurrentPerformance: string = null;
}

export class BenefitProgressUpdateFormState extends CrUpdateFormState<IBenefitUpdate, BenefitUpdateFormValidations, IBenefit> {
    constructor(benefitId: number, period: Date, parentEntity?: IBenefit, showForm?: boolean) {
        super(
            new BenefitUpdate(benefitId, period),
            parentEntity || new Benefit(),
            new BenefitUpdate(benefitId),
            new BenefitUpdateFormValidations(),
            showForm || false
        );
    }
}

export const BenefitProgressUpdateForm = (
    { entityId, entity, reportPeriod, filters, ...otherProps }: IEntityProgressUpdateFormProps<IBenefit>
): React.ReactElement => {
    const [reportDates, setReportDates] = useState<IReportDueDates>();
    const { dataServices: { benefitService, benefitUpdateService, projectService,
        reportDueDatesService, userProjectService }, lookupData, loadLookupData: { reportingFrequencies } } = useContext(DataContext);
    useMemo(() => reportingFrequencies(), [reportingFrequencies]);

    const validateBenefitProgressUpdate = (bu: IBenefitUpdate, b: IBenefit): Promise<BenefitUpdateFormValidations> => {
        const errors = new BenefitUpdateFormValidations();

        if (bu.Comment === null || bu.Comment === '') {
            errors.Comment = 'Progress update is required';
            errors.Valid = false;
        }
        else
            errors.Comment = null;

        if (bu.CurrentPerformance == null || bu.CurrentPerformance === '' || isNaN(Number(bu.CurrentPerformance))) {
            errors.CurrentPerformance = 'Current performance is required and must be a number';
            errors.Valid = false;
        } else if (!ValidationService.validSqlDecimal(Number(bu.CurrentPerformance))) {
            errors.CurrentPerformance = 'Current performance is too big';
            errors.Valid = false;
        } else
            errors.CurrentPerformance = null;

        if (bu.RagOptionID === null) {
            errors.RagOptionID = 'RAG rating is required';
            errors.Valid = false;
        }
        else
            errors.RagOptionID = null;

        if (!bu.ToBeClosed && currentDeliveryDate(b) < new Date() && bu.ForecastDate === null) {
            errors.ForecastDate = 'Forecast benefit realisation date is required';
            errors.Valid = false;
        } else if (!bu.ToBeClosed && bu.ForecastDate !== null && bu.ForecastDate < new Date()) {
            errors.ForecastDate = 'Forecast benefit realisation date cannot be in the past';
            errors.Valid = false;
        } else errors.ForecastDate = null;

        if (bu.ToBeClosed && bu.ActualDate === null) {
            errors.ActualDate = 'Actual benefit realisation date is required if the benefit is complete';
            errors.Valid = false;
        } else if (bu.ToBeClosed && bu.ActualDate !== null && bu.ActualDate > reportDates.Next) {
            errors.ActualDate = 'Actual benefit realisation date cannot be in the future';
            errors.Valid = false;
        } else errors.ActualDate = null;

        return Promise.resolve(errors);
    };

    useEffect(() => {
        const loadReportDates = async (): Promise<void> => {
            setReportDates(await reportDueDatesService.getBenefitReportDueDates(entityId, new Date(), reportPeriod));
        };

        loadReportDates();
    }, [reportDueDatesService, entityId, reportPeriod]);

    if (filters?.dueBy != null && reportDates?.Next > filters.dueBy) {
        return null;
    }

    return (
        <ProgressUpdateForm<IBenefitUpdate, BenefitUpdateFormValidations, IBenefit>
            {...otherProps}
            reportDates={reportDates}
            entityId={entityId}
            entity={entity}
            dueDate={() => reportDates?.Next}
            loadPeople={async b => {
                const people = [];
                if (b) {
                    if (b.LeadUser)
                        people.push({ role: 'Lead', names: [b.LeadUser.Title] });
                    if (b.Contributors?.length > 0)
                        people.push({ role: 'Contributors', names: b.Contributors.map(c => c.ContributorUser?.Title) });
                    people.push(...await EntityPeopleService.GetProjectEntityPeople({
                        projectService: projectService,
                        userProjectService: userProjectService,
                        projectId: b.ProjectID
                    }));
                }
                return people;
            }}
            renderFormFields={(
                { changeCheckbox, changeColor, changeTextField, changeDatePicker },
                { ParentEntity: e, FormData: update, LastSignedOffUpdate: so, ValidationErrors: errors }
            ) => {
                const targets = [];
                if (e.TargetPerformanceLowerLimit || e.TargetPerformanceLowerLimit == 0)
                    targets.push(Number(e.TargetPerformanceLowerLimit).toLocaleString('en-GB'));
                if (e.TargetPerformanceUpperLimit || e.TargetPerformanceUpperLimit == 0)
                    targets.push(Number(e.TargetPerformanceUpperLimit).toLocaleString('en-GB'));

                return (
                    <div className={styles.grid}>
                        <div className={styles.gridRow}>
                            <div className={`${styles.gridCol} ${styles.sm12}`}>
                                <RagPicker
                                    label="RAG rating"
                                    required={true}
                                    className={styles.formField}
                                    selectedRAG={update.RagOptionID}
                                    onColorChanged={v => changeColor(v, 'RagOptionID')}
                                    history={so.RagOptionID}
                                    errorMessage={errors.RagOptionID}
                                />
                                <CrTextField
                                    label="This period's update"
                                    className={styles.formField}
                                    required={true}
                                    multiline
                                    placeholder="Why have you chosen this RAG rating? What are the implications of this?"
                                    rows={4}
                                    maxLength={500}
                                    charCounter={true}
                                    value={update.Comment}
                                    onChange={v => changeTextField(v, 'Comment')}
                                    history={so.Comment}
                                    errorMessage={errors.Comment}
                                />
                            </div>
                        </div>
                        <div className={styles.gridRow}>
                            <div className={`${styles.gridCol} ${styles.sm6}`}>
                                <CrNumberTextField
                                    label="Current performance"
                                    required={true}
                                    className={styles.formField}
                                    maxLength={19}
                                    value={update.CurrentPerformance}
                                    onChange={v => changeTextField(v, 'CurrentPerformance')}
                                    history={NumberService.IsNullOrUndefined(so?.CurrentPerformance) ? null : Number(so?.CurrentPerformance)}
                                    errorMessage={errors.CurrentPerformance}
                                    suffix={e?.MeasurementUnit?.Title}
                                />
                            </div>
                            <div className={`${styles.gridCol} ${styles.sm6}`}>
                                <Label>Target performance</Label>
                                <p className={styles.formText}>
                                    {targets.length > 0 ?
                                        targets.join(' - ')
                                        :
                                        "[Missing]"} {(targets.length > 0) && e?.MeasurementUnit?.Title}
                                </p>
                            </div>
                        </div>
                        <div className={styles.gridRow}>
                            <div className={`${styles.gridCol} ${styles.sm12}`}>
                                <CrCheckbox
                                    label="Tick this box to mark the activity as closed. Only do this if delivery is complete and there are no more actions to take."
                                    className={styles.formField}
                                    checked={update.ToBeClosed}
                                    onChange={(_, isChecked) => changeCheckbox(isChecked, 'ToBeClosed')}
                                />
                                {update.ToBeClosed ||
                                    <CrDatePicker
                                        label="Forecast realisation date"
                                        required={!update.ToBeClosed && currentDeliveryDate(e) < new Date()}
                                        helpText="Revised realisation date if the initial realisation date has changed"
                                        className={styles.formField}
                                        minDate={new Date()}
                                        value={update.ForecastDate}
                                        onSelectDate={d => changeDatePicker(d, 'ForecastDate')}
                                        history={so.ForecastDate}
                                        errorMessage={errors.ForecastDate}
                                    />
                                }
                                {update.ToBeClosed &&
                                    <CrDatePicker
                                        label="Actual benefit realisation date"
                                        required={update.ToBeClosed}
                                        maxDate={reportDates?.Next}
                                        className={styles.formField}
                                        value={update.ActualDate}
                                        onSelectDate={d => changeDatePicker(d, 'ActualDate')}
                                        errorMessage={errors.ActualDate}
                                    />
                                }
                                <DeliveryDatesField
                                    baseline={e.BaselineDate}
                                    forecast={e.ForecastDate}
                                />
                            </div>
                        </div>
                    </div>
                );
            }}
            loadEntity={bId => benefitService.read(bId, true, true)}
            loadEntityUpdate={buId => benefitUpdateService.read(buId)}
            loadNewEntityUpdate={() => new BenefitUpdate(entityId)}
            loadLastSavedProgressUpdate={() => reportDates?.Next &&
                benefitUpdateService.readLatestUpdateForPeriod(entityId, reportDates.Next)}
            loadLastSignedOffEntityUpdate={() => reportDates?.Previous &&
                benefitUpdateService.readLastSignedOffUpdateForPeriod(entityId, reportDates.Previous)}
            onAfterLoad={bu => bu.CurrentPerformance = NumberService.FromNumberOrNull(bu.CurrentPerformance)} // Prevent TextField warnings about controlled/uncontrolled
            onValidateUpdate={validateBenefitProgressUpdate}
            onBeforeSave={bu => bu.CurrentPerformance = NumberService.ToNumberOrNull(bu.CurrentPerformance)}
            onSaveUpdate={bu => benefitUpdateService.create(bu)}
            onClearForm={(b, showForm) => new BenefitProgressUpdateFormState(entityId, reportDates?.Next, b, showForm)}
            reportingFrequencies={lookupData?.ReportingFrequencies}
        />
    );
};
