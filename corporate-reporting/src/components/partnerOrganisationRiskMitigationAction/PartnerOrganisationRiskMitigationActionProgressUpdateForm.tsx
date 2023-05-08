import React, { useContext, useMemo } from 'react';
import styles from '../../styles/cr.module.scss';
import { ProgressUpdateForm } from "../ProgressUpdateForm";
import {
    CrUpdateFormState, IEntityProgressUpdateFormProps, IProgressUpdateWithDeliveryDatesValidations,
    ProgressUpdateWithDeliveryDatesValidations, IPartnerOrganisationRiskMitigationAction, PartnerOrganisationRiskMitigationActionUpdate,
    IPartnerOrganisationRiskMitigationActionUpdate, PartnerOrganisationRiskMitigationAction
} from "../../types";
import { RagPicker } from '../cr/RagPicker';
import { CrTextField } from '../cr/CrTextField';
import { CrCheckbox } from '../cr/CrCheckbox';
import { CrDatePicker } from '../cr/CrDatePicker';
import { ContributorService, EntityPeopleService } from '../../services';
import { DeliveryDatesField } from '../cr/DeliveryDatesField';
import { DataContext } from '../DataContext';
import { OrbUserContext } from '../OrbUserContext';

export class PartnerOrganisationRiskMitigationActionProgressUpdateFormState
    extends CrUpdateFormState<IPartnerOrganisationRiskMitigationActionUpdate, IProgressUpdateWithDeliveryDatesValidations, IPartnerOrganisationRiskMitigationAction> {
    constructor(riskMitigationActionId: number, period: Date, parentEntity?: IPartnerOrganisationRiskMitigationAction, showForm?: boolean) {
        super(
            new PartnerOrganisationRiskMitigationActionUpdate(riskMitigationActionId, period),
            parentEntity || new PartnerOrganisationRiskMitigationAction(),
            new PartnerOrganisationRiskMitigationActionUpdate(riskMitigationActionId),
            new ProgressUpdateWithDeliveryDatesValidations(),
            showForm || false
        );
    }
}

export const PartnerOrganisationRiskMitigationActionProgressUpdateForm = (
    { entityId, entity, reportDates, ...otherProps }: IEntityProgressUpdateFormProps<IPartnerOrganisationRiskMitigationAction>
): React.ReactElement => {
    const { userContext } = useContext(OrbUserContext);
    const { dataServices, lookupData, loadLookupData: { reportingFrequencies } } = useContext(DataContext);
    useMemo(() => reportingFrequencies(), [reportingFrequencies]);

    const validatePartnerOrganisationRiskMitigationActionProgressUpdate =
        (rmau: IPartnerOrganisationRiskMitigationActionUpdate): Promise<IProgressUpdateWithDeliveryDatesValidations> => {
            const errors = new ProgressUpdateWithDeliveryDatesValidations();

            if (rmau.Comment === null || rmau.Comment === '') {
                errors.Comment = 'Progress update is required';
                errors.Valid = false;
            } else errors.Comment = null;

            if (!rmau.ToBeClosed && rmau.ForecastDate !== null && rmau.ForecastDate < new Date()) {
                errors.ForecastDate = 'Forecast delivery date cannot be in the past';
                errors.Valid = false;
            } else errors.ForecastDate = null;

            if (rmau.ToBeClosed && rmau.ActualDate === null) {
                errors.ActualDate = 'Actual delivery date is required if the risk mitigating action is complete';
                errors.Valid = false;
            } else if (rmau.ToBeClosed && rmau.ActualDate !== null && rmau.ActualDate > reportDates.Next) {
                errors.ActualDate = 'Actual delivery date cannot be in the future';
                errors.Valid = false;
            } else errors.ActualDate = null;

            if (rmau.RagOptionID === null) {
                errors.RagOptionID = 'RAG rating is required';
                errors.Valid = false;
            } else errors.RagOptionID = null;

            return Promise.resolve(errors);
        };

    return (
        <ProgressUpdateForm<IPartnerOrganisationRiskMitigationActionUpdate, IProgressUpdateWithDeliveryDatesValidations, IPartnerOrganisationRiskMitigationAction>
            {...otherProps}
            parents={rma => rma && rma.PartnerOrganisationRisk ? [rma.PartnerOrganisationRisk.Title] : []}
            loadPeople={async rma => {
                const people = [];
                if (rma) {
                    if (rma.OwnerUser)
                        people.push({ role: 'Lead', names: [rma.OwnerUser.Title] });
                    if (rma.Contributors && rma.Contributors.length > 0)
                        people.push({ role: 'Contributors', names: rma.Contributors.map(c => c.ContributorUser && c.ContributorUser.Title) });
                    if (rma.PartnerOrganisationRisk)
                        people.push(...await EntityPeopleService.GetPartnerOrganisationEntityPeople({
                            partnerOrganisationService: dataServices.partnerOrganisationService,
                            userPartnerOrganisationService: dataServices.userPartnerOrganisationService,
                            partnerOrganisationId: rma.PartnerOrganisationRisk.PartnerOrganisationID
                        }));
                }
                return people;
            }}
            dueDate={() => reportDates?.Next}
            renderFormFields={(
                { changeColor, changeTextField, changeCheckbox, changeDatePicker, clearField },
                { FormData: update, ParentEntity: e, LastSignedOffUpdate: so, ValidationErrors: errors }
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
                                changeCheckbox(checked, 'ToBeClosed', () => clearField('ForecastDate', () => clearField('ActualDate')))
                            }
                        />
                        {update.ToBeClosed ||
                            <CrDatePicker
                                label='Forecast delivery date (optional)'
                                disabled={readOnly}
                                required={false}
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
            loadEntity={id => dataServices.partnerOrganisationRiskMitigationActionService.read(id, true, true)}
            loadEntityUpdate={id => dataServices.partnerOrganisationRiskMitigationActionUpdateService.read(id)}
            loadNewEntityUpdate={() => new PartnerOrganisationRiskMitigationActionUpdate(entityId)}
            loadLastSavedProgressUpdate={() => reportDates?.Next &&
                dataServices.partnerOrganisationRiskMitigationActionUpdateService.readLatestUpdateForPeriod(entityId, reportDates.Next)}
            loadLastSignedOffEntityUpdate={() => reportDates?.Previous &&
                dataServices.partnerOrganisationRiskMitigationActionUpdateService.readLastSignedOffUpdateForPeriod(entityId, reportDates.Previous)}
            onValidateUpdate={validatePartnerOrganisationRiskMitigationActionProgressUpdate}
            onSaveUpdate={rmau => dataServices.partnerOrganisationRiskMitigationActionUpdateService.create(rmau)}
            onClearForm={(rma, showForm) => new PartnerOrganisationRiskMitigationActionProgressUpdateFormState(entityId, reportDates?.Next, rma, showForm)}
            reportDates={reportDates}
            entityId={entityId}
            entity={entity}
            reportingFrequencies={lookupData?.ReportingFrequencies}
        />
    );
};
