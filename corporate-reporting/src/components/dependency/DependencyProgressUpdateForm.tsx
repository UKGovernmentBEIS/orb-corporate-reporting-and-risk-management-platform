import React, { useContext, useMemo } from 'react';
import styles from '../../styles/cr.module.scss';
import { ProgressUpdateForm } from "../ProgressUpdateForm";
import {
    IDependency, IDependencyUpdate, DependencyUpdate, Dependency, CrUpdateFormState, IEntityProgressUpdateFormProps,
    IProgressUpdateWithDeliveryDatesValidations, ProgressUpdateWithDeliveryDatesValidations
} from "../../types";
import { EntityPeopleService } from '../../services';
import { RagPicker } from '../cr/RagPicker';
import { CrTextField } from '../cr/CrTextField';
import { CrCheckbox } from '../cr/CrCheckbox';
import { CrDatePicker } from '../cr/CrDatePicker';
import { DeliveryDatesField } from '../cr/DeliveryDatesField';
import { currentDeliveryDate } from '../../services/DeliveryDateHelpers';
import { DataContext } from '../DataContext';

export class DependencyProgressUpdateFormState extends CrUpdateFormState<IDependencyUpdate, IProgressUpdateWithDeliveryDatesValidations, IDependency> {
    constructor(dependencyId: number, period: Date, parentEntity?: IDependency, showForm?: boolean) {
        super(
            new DependencyUpdate(dependencyId, period),
            parentEntity || new Dependency(),
            new DependencyUpdate(dependencyId),
            new ProgressUpdateWithDeliveryDatesValidations(),
            showForm || false
        );
    }
}

export const DependencyProgressUpdateForm = (
    { entityId, entity, reportDates, ...otherProps }: IEntityProgressUpdateFormProps<IDependency>
): React.ReactElement => {
    const { dataServices, lookupData, loadLookupData: { reportingFrequencies } } = useContext(DataContext);
    useMemo(() => reportingFrequencies(), [reportingFrequencies]);

    const validateDependencyProgressUpdate = (du: IDependencyUpdate): Promise<IProgressUpdateWithDeliveryDatesValidations> => {
        const errors = new ProgressUpdateWithDeliveryDatesValidations();

        if (du.Comment === null || du.Comment === '') {
            errors.Comment = 'Progress update is required';
            errors.Valid = false;
        } else {
            errors.Comment = null;
        }

        if (!du.ToBeClosed && du.ForecastDate !== null && du.ForecastDate < new Date()) {
            errors.ForecastDate = 'Forecast end date cannot be in the past';
            errors.Valid = false;
        } else {
            errors.ForecastDate = null;
        }

        if (du.ToBeClosed && du.ActualDate !== null && du.ActualDate > reportDates.Next) {
            errors.ActualDate = 'Actual end date cannot be in the future';
            errors.Valid = false;
        } else {
            errors.ActualDate = null;
        }

        if (du.RagOptionID === null) {
            errors.RagOptionID = 'RAG rating is required';
            errors.Valid = false;
        } else {
            errors.RagOptionID = null;
        }

        return Promise.resolve(errors);
    };

    return (
        <ProgressUpdateForm<IDependencyUpdate, IProgressUpdateWithDeliveryDatesValidations, IDependency>
            {...otherProps}
            entityId={entityId}
            dueDate={() => reportDates?.Next}
            loadPeople={async d => {
                const people = [];
                if (d) {
                    if (d.LeadUser)
                        people.push({ role: 'Lead', names: [d.LeadUser.Title] });
                    if (d.Contributors && d.Contributors.length > 0)
                        people.push({ role: 'Contributors', names: d.Contributors.map(c => c.ContributorUser?.Title) });
                    people.push(...await EntityPeopleService.GetProjectEntityPeople({
                        projectService: dataServices.projectService,
                        userProjectService: dataServices.userProjectService,
                        projectId: d.ProjectID
                    }));
                }
                return people;
            }}
            renderFormFields={(
                { changeColor, changeTextField, changeCheckbox, clearField, changeDatePicker },
                { FormData: update, ParentEntity: e, ValidationErrors: errors, LastSignedOffUpdate: so }
            ) =>
                <>
                    <RagPicker
                        label='RAG rating'
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
                    <CrCheckbox
                        className={styles.formField}
                        label="Tick this box to mark the activity as closed. Only do this if delivery is complete and there are no more actions to take."
                        checked={update.ToBeClosed}
                        onChange={(_, checked) =>
                            changeCheckbox(checked, 'ToBeClosed', () => clearField('ForecastDate', () => clearField('ActualDate')))
                        }
                    />
                    {update.ToBeClosed ||
                        <CrDatePicker
                            label="Forecast end date"
                            helpText="Most recent predicted end date"
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
                            label="Actual end date"
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
                </>
            }
            loadEntity={id => dataServices.dependencyService.read(id, true, true)}
            loadEntityUpdate={id => dataServices.dependencyUpdateService.read(id)}
            loadNewEntityUpdate={() => new DependencyUpdate(entityId)}
            loadLastSavedProgressUpdate={() => reportDates?.Next &&
                dataServices.dependencyUpdateService.readLatestUpdateForPeriod(entityId, reportDates.Next)}
            loadDefaultValues={(update, dependency) => {
                const newUpdate = { ...update };
                newUpdate.ForecastDate = currentDeliveryDate(dependency);
                return newUpdate;
            }}
            loadLastSignedOffEntityUpdate={() => reportDates?.Previous &&
                dataServices.dependencyUpdateService.readLastSignedOffUpdateForPeriod(entityId, reportDates.Previous)}
            onValidateUpdate={validateDependencyProgressUpdate}
            onSaveUpdate={du => dataServices.dependencyUpdateService.create(du)}
            onClearForm={(d, showForm) => new DependencyProgressUpdateFormState(entityId, reportDates?.Next, d, showForm)}
            reportDates={reportDates}
            entity={entity}
            reportingFrequencies={lookupData?.ReportingFrequencies}
        />
    );
};
