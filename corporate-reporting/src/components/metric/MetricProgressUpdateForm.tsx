import React, { useContext, useEffect, useMemo, useState } from 'react';
import styles from '../../styles/cr.module.scss';
import { ProgressUpdateForm } from "../ProgressUpdateForm";
import {
    CrUpdateFormState, IEntityProgressUpdateFormProps,
    IMetric, IMetricUpdate, MetricUpdate, Metric, ProgressUpdateValidations, IReportDueDates
} from "../../types";
import { RagPicker } from '../cr/RagPicker';
import { CrTextField } from '../cr/CrTextField';
import { CrNumberTextField } from '../cr/CrNumberTextField';
import { Label } from 'office-ui-fabric-react/lib/Label';
import { CrCheckbox } from '../cr/CrCheckbox';
import { EntityPeopleService, NumberService, ValidationService } from '../../services';
import { DataContext } from '../DataContext';

export class MetricUpdateFormValidations extends ProgressUpdateValidations {
    public CurrentPerformance: string = null;
}

export class MetricProgressUpdateFormState extends CrUpdateFormState<IMetricUpdate, MetricUpdateFormValidations, IMetric> {
    constructor(metricId: number, period: Date, parentEntity?: IMetric, showForm?: boolean) {
        super(
            new MetricUpdate(metricId, period),
            parentEntity || new Metric(),
            new MetricUpdate(metricId),
            new MetricUpdateFormValidations(),
            showForm || false
        );
    }
}

export const MetricProgressUpdateForm = (
    { entityId, entity, reportPeriod, filters, ...otherProps }: IEntityProgressUpdateFormProps<IMetric>
): React.ReactElement => {
    const [reportDates, setReportDates] = useState<IReportDueDates>();
    const { dataServices, lookupData, loadLookupData: { reportingFrequencies } } = useContext(DataContext);

    useMemo(() => reportingFrequencies(), [reportingFrequencies]);

    const validateMetricProgressUpdate = (mu: IMetricUpdate): Promise<MetricUpdateFormValidations> => {
        const errors = new MetricUpdateFormValidations();

        if (mu.Comment === null || mu.Comment === '') {
            errors.Comment = 'Progress update is required';
            errors.Valid = false;
        }
        else
            errors.Comment = null;

        if (mu.CurrentPerformance == null || mu.CurrentPerformance === '' || isNaN(Number(mu.CurrentPerformance))) {
            errors.CurrentPerformance = 'Current performance is required and must be a number';
            errors.Valid = false;
        } else if (!ValidationService.validSqlDecimal(Number(mu.CurrentPerformance))) {
            errors.CurrentPerformance = 'Current performance is too big';
            errors.Valid = false;
        } else
            errors.CurrentPerformance = null;

        if (mu.RagOptionID === null) {
            errors.RagOptionID = 'RAG rating is required';
            errors.Valid = false;
        }
        else
            errors.RagOptionID = null;

        return Promise.resolve(errors);
    };

    useEffect(() => {
        const loadReportDates = async (): Promise<void> => {
            setReportDates(await dataServices.reportDueDatesService.getMetricReportDueDates(entityId, new Date(), reportPeriod));
        };

        loadReportDates();
    }, [dataServices.reportDueDatesService, entityId, reportPeriod]);

    if (filters?.dueBy != null && reportDates?.Next > filters.dueBy) {
        return null;
    }

    return (
        <ProgressUpdateForm<IMetricUpdate, MetricUpdateFormValidations, IMetric>
            {...otherProps}
            reportDates={reportDates}
            entityId={entityId}
            dueDate={() => reportDates?.Next}
            loadPeople={async m => {
                const people = [];
                if (m) {
                    if (m.LeadUser)
                        people.push({ role: 'Lead', names: [m.LeadUser.Title] });
                    if (m.Contributors?.length > 0)
                        people.push({ role: 'Contributors', names: m.Contributors.map(c => c.ContributorUser?.Title) });
                    people.push(...await EntityPeopleService.GetDirectorateEntityPeople({
                        directorateService: dataServices.directorateService,
                        userDirectorateService: dataServices.userDirectorateService,
                        directorateId: m.DirectorateID
                    }));
                }
                return people;
            }}
            renderFormFields={(
                { changeColor, changeTextField, changeCheckbox },
                { FormData: update, ParentEntity: e, LastSignedOffUpdate: so, ValidationErrors: errors }
            ) => {
                const targets = [];
                if (e.TargetPerformanceLowerLimit || e.TargetPerformanceLowerLimit == 0)
                    targets.push(Number(e.TargetPerformanceLowerLimit).toLocaleString('en-GB'));
                if (e.TargetPerformanceUpperLimit || e.TargetPerformanceUpperLimit == 0)
                    targets.push(Number(e.TargetPerformanceUpperLimit).toLocaleString('en-GB'));

                return (
                    <>
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
                        <div className={styles.grid}>
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
                                        suffix={e.MeasurementUnit?.Title} />
                                </div>
                                <div className={`${styles.gridCol} ${styles.sm6}`}>
                                    <Label>Target performance</Label>
                                    <p className={styles.formText}>
                                        {targets.length > 0 ?
                                            targets.join(' - ')
                                            :
                                            "[Missing]"} {(targets.length > 0) && e.MeasurementUnit?.Title}
                                    </p>
                                </div>
                            </div>
                        </div>
                        <CrCheckbox
                            label="Tick this box to mark the activity as closed. Only do this if delivery is complete and there are no more actions to take."
                            className={styles.formField}
                            checked={update.ToBeClosed}
                            onChange={(_, isChecked) => changeCheckbox(isChecked, 'ToBeClosed')}
                        />
                    </>
                );
            }}
            loadEntity={id => dataServices.metricService.read(id, true, true)}
            loadEntityUpdate={id => dataServices.metricUpdateService.read(id)}
            loadNewEntityUpdate={() => new MetricUpdate(entityId)}
            loadLastSavedProgressUpdate={() => reportDates?.Next &&
                dataServices.metricUpdateService.readLatestUpdateForPeriod(entityId, reportDates.Next)}
            loadLastSignedOffEntityUpdate={() => reportDates?.Previous &&
                dataServices.metricUpdateService.readLastSignedOffUpdateForPeriod(entityId, reportDates.Previous)}
            onAfterLoad={mu => mu.CurrentPerformance = NumberService.FromNumberOrNull(mu.CurrentPerformance)} // Prevent TextField warnings about controlled/uncontrolled
            onValidateUpdate={validateMetricProgressUpdate}
            onBeforeSave={mu => mu.CurrentPerformance = NumberService.ToNumberOrNull(mu.CurrentPerformance)}
            onSaveUpdate={mu => dataServices.metricUpdateService.create(mu)}
            onClearForm={(m, showForm) => new MetricProgressUpdateFormState(entityId, reportDates?.Next, m, showForm)}
            entity={entity}
            reportingFrequencies={lookupData?.ReportingFrequencies}
        />
    );
};
