import React, { useContext, useMemo } from 'react';
import styles from '../../styles/cr.module.scss';
import { ProgressUpdateForm } from "../ProgressUpdateForm";
import {
    ICommitment, ICommitmentUpdate, CommitmentUpdate, Commitment, CrUpdateFormState,
    IProgressUpdateWithDeliveryDatesValidations, ProgressUpdateWithDeliveryDatesValidations, IEntityProgressUpdateFormProps
} from "../../types";
import { RagPicker } from '../cr/RagPicker';
import { CrTextField } from '../cr/CrTextField';
import { CrCheckbox } from '../cr/CrCheckbox';
import { CrDatePicker } from '../cr/CrDatePicker';
import { ContributorService, EntityPeopleService } from '../../services';
import { DeliveryDatesField } from '../cr/DeliveryDatesField';
import { currentDeliveryDate } from '../../services/DeliveryDateHelpers';
import { DataContext } from '../DataContext';
import { OrbUserContext } from '../OrbUserContext';

export class CommitmentProgressUpdateFormState extends CrUpdateFormState<ICommitmentUpdate, IProgressUpdateWithDeliveryDatesValidations, ICommitment> {
    constructor(commitmentId: number, period: Date, parentEntity?: ICommitment, showForm?: boolean) {
        super(
            new CommitmentUpdate(commitmentId, period),
            parentEntity || new Commitment(),
            new CommitmentUpdate(commitmentId),
            new ProgressUpdateWithDeliveryDatesValidations(),
            showForm || false
        );
    }
}

export const CommitmentProgressUpdateForm = ({ entityId, entity, reportDates, ...otherProps }: IEntityProgressUpdateFormProps<ICommitment>): React.ReactElement => {
    const { userContext } = useContext(OrbUserContext);
    const { dataServices, lookupData, loadLookupData: { reportingFrequencies } } = useContext(DataContext);
    useMemo(() => reportingFrequencies(), [reportingFrequencies]);

    const validateCommitmentProgressUpdate = (cu: ICommitmentUpdate, c: ICommitment): Promise<IProgressUpdateWithDeliveryDatesValidations> => {
        const errors = new ProgressUpdateWithDeliveryDatesValidations();

        if (cu.Comment === null || cu.Comment === '') {
            errors.Comment = 'Progress update is required';
            errors.Valid = false;
        } else { errors.Comment = null; }

        if (!cu.ToBeClosed && currentDeliveryDate(c) < new Date() && cu.ForecastDate === null) {
            errors.ForecastDate = 'Forecast delivery date is required';
            errors.Valid = false;
        } else if (!cu.ToBeClosed && cu.ForecastDate !== null && cu.ForecastDate < new Date()) {
            errors.ForecastDate = 'Forecast delivery date cannot be in the past';
            errors.Valid = false;
        } else { errors.ForecastDate = null; }

        if (cu.ToBeClosed && cu.ActualDate === null) {
            errors.ActualDate = 'Actual delivery date is required if the commitment is complete';
            errors.Valid = false;
        } else if (cu.ToBeClosed && cu.ActualDate !== null && cu.ActualDate > reportDates.Next) {
            errors.ActualDate = 'Actual delivery date cannot be in the future';
            errors.Valid = false;
        } else { errors.ActualDate = null; }

        if (cu.RagOptionID === null) {
            errors.RagOptionID = 'RAG rating is required';
            errors.Valid = false;
        } else { errors.RagOptionID = null; }

        return Promise.resolve(errors);
    };
    return (
        <ProgressUpdateForm<ICommitmentUpdate, IProgressUpdateWithDeliveryDatesValidations, ICommitment>
            {...otherProps}
            entityId={entityId}
            dueDate={() => reportDates?.Next}
            loadPeople={async c => {
                const people = [];
                if (c) {
                    if (c.LeadUser)
                        people.push({ role: 'Lead', names: [c.LeadUser.Title] });
                    if (c.Contributors && c.Contributors.length > 0)
                        people.push({ role: 'Contributors', names: c.Contributors.map(co => co.ContributorUser && co.ContributorUser.Title) });
                    people.push(...await EntityPeopleService.GetDirectorateEntityPeople({
                        directorateService: dataServices.directorateService,
                        userDirectorateService: dataServices.userDirectorateService,
                        directorateId: c.DirectorateID
                    }));
                }
                return people;
            }}
            renderFormFields={(
                { changeColor, changeTextField, changeCheckbox, changeDatePicker },
                { ParentEntity: e, FormData: update, LastSignedOffUpdate: so, ValidationErrors: errors }
            ) => {
                const readOnly = ContributorService.UserIsReadOnlyContributor(userContext.Username, e);
                return (
                    <>
                        <RagPicker
                            label='RAG rating'
                            required={true}
                            className={styles.formField}
                            selectedRAG={update.RagOptionID}
                            onColorChanged={v => changeColor(v, 'RagOptionID')}
                            history={so.RagOptionID}
                            errorMessage={errors.RagOptionID}
                            disabled={readOnly}
                        />
                        <CrTextField
                            label="This period's update"
                            className={styles.formField}
                            required={true}
                            multiline
                            placeholder='Why have you chosen this RAG rating? What are the implications of this?'
                            rows={4}
                            maxLength={500}
                            charCounter={true}
                            value={update.Comment}
                            onChange={v => changeTextField(v, 'Comment')}
                            history={so.Comment}
                            errorMessage={errors.Comment}
                            disabled={readOnly}
                        />
                        <CrCheckbox
                            className={styles.formField}
                            label="Tick this box to mark the activity as closed. Only do this if delivery is complete and there are no more actions to take."
                            disabled={readOnly}
                            checked={update.ToBeClosed}
                            onChange={(_, checked) =>
                                changeCheckbox(checked, 'ToBeClosed', () =>
                                    changeDatePicker(null, 'ForecastDate', () =>
                                        changeDatePicker(null, 'ActualDate')
                                    )
                                )
                            }
                        />
                        {update.ToBeClosed ||
                            <CrDatePicker
                                label='Forecast delivery date'
                                disabled={readOnly}
                                required={!update.ToBeClosed}
                                helpText="Most recent predicted delivery date"
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
                                label='Actual delivery date'
                                disabled={readOnly}
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
                );
            }}
            loadEntity={id => dataServices.commitmentService.read(id, true, true)}
            loadEntityUpdate={id => dataServices.commitmentUpdateService.read(id)}
            loadNewEntityUpdate={() => new CommitmentUpdate(entityId)}
            loadLastSavedProgressUpdate={() => reportDates &&
                dataServices.commitmentUpdateService.readLatestUpdateForPeriod(entityId, reportDates.Next)}
            loadDefaultValues={(update, commitment) => {
                const newUpdate = { ...update };
                newUpdate.ForecastDate = currentDeliveryDate(commitment);
                return newUpdate;
            }}
            loadLastSignedOffEntityUpdate={() => reportDates &&
                dataServices.commitmentUpdateService.readLastSignedOffUpdateForPeriod(entityId, reportDates.Previous)}
            onValidateUpdate={validateCommitmentProgressUpdate}
            onSaveUpdate={cu => dataServices.commitmentUpdateService.create(cu)}
            onClearForm={(c, showForm) => new CommitmentProgressUpdateFormState(entityId, reportDates?.Next, c, showForm)}
            reportDates={reportDates}
            entity={entity}
            reportingFrequencies={lookupData?.ReportingFrequencies}
        />
    );
};
