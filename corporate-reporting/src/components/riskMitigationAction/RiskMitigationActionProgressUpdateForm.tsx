import React, { useContext, useMemo } from 'react';
import styles from '../../styles/cr.module.scss';
import { ProgressUpdateForm } from "../ProgressUpdateForm";
import {
    IRiskMitigationAction, IRiskMitigationActionUpdate, RiskMitigationActionUpdate, RiskMitigationAction,
    CrUpdateFormState, IEntityProgressUpdateFormProps, IProgressUpdateWithDeliveryDatesValidations,
    ProgressUpdateWithDeliveryDatesValidations
} from "../../types";
import { RagPicker } from '../cr/RagPicker';
import { CrTextField } from '../cr/CrTextField';
import { CrCheckbox } from '../cr/CrCheckbox';
import { CrDatePicker } from '../cr/CrDatePicker';
import {
    ContributorService, CorporateRiskService, EntityPeopleService,
    EntityUpdateService, FinancialRiskService, RiskMitigationActionService
} from '../../services';
import { DeliveryDatesField } from '../cr/DeliveryDatesField';
import { currentDeliveryDate } from '../../services/DeliveryDateHelpers';
import { DataContext } from '../DataContext';
import { OrbUserContext } from '../OrbUserContext';

export class RiskMitigationActionProgressUpdateFormState extends CrUpdateFormState<IRiskMitigationActionUpdate, IProgressUpdateWithDeliveryDatesValidations, IRiskMitigationAction> {
    constructor(riskMitigationActionId: number, period: Date, parentEntity?: IRiskMitigationAction, showForm?: boolean) {
        super(
            new RiskMitigationActionUpdate(riskMitigationActionId, period),
            parentEntity || new RiskMitigationAction(),
            new RiskMitigationActionUpdate(riskMitigationActionId),
            new ProgressUpdateWithDeliveryDatesValidations(),
            showForm || false
        );
    }
}

export interface IRiskMitigationActionProgressUpdateFormProps<T extends IRiskMitigationAction> extends IEntityProgressUpdateFormProps<IRiskMitigationAction> {
    title?: (entity: T) => string;
    parents?: (entity: T) => string[];
    riskService: CorporateRiskService | FinancialRiskService;
    riskActionService: RiskMitigationActionService<T>;
    riskActionUpdateService: EntityUpdateService<IRiskMitigationActionUpdate>;
    maxNarrativeLength?: number;
}

export const RiskMitigationActionProgressUpdateForm = <T extends IRiskMitigationAction>(
    { entityId, entity, reportDates, riskActionService, riskActionUpdateService, maxNarrativeLength, ...otherProps }: IRiskMitigationActionProgressUpdateFormProps<T>
): React.ReactElement => {
    const { userContext } = useContext(OrbUserContext);
    const { lookupData, loadLookupData: { reportingFrequencies } } = useContext(DataContext);
    useMemo(() => reportingFrequencies(), [reportingFrequencies]);

    const validateRiskMitigationActionProgressUpdate = (rmau: IRiskMitigationActionUpdate, action: IRiskMitigationAction): Promise<IProgressUpdateWithDeliveryDatesValidations> => {
        const errors = new ProgressUpdateWithDeliveryDatesValidations();

        if (rmau.Comment === null || rmau.Comment === '') {
            errors.Comment = 'Progress update is required';
            errors.Valid = false;
        } else {
            errors.Comment = null;
        }

        if (!action.ActionIsOngoing) {
            if (!rmau.ToBeClosed && currentDeliveryDate(action) < new Date() && rmau.ForecastDate === null) {
                errors.ForecastDate = 'Forecast delivery date is required';
                errors.Valid = false;
            } else if (!rmau.ToBeClosed && rmau.ForecastDate !== null && rmau.ForecastDate < new Date()) {
                errors.ForecastDate = 'Forecast delivery date cannot be in the past';
                errors.Valid = false;
            } else {
                errors.ForecastDate = null;
            }

            if (rmau.ToBeClosed && rmau.ActualDate === null) {
                errors.ActualDate = 'Actual delivery date is required if the risk mitigating action is complete';
                errors.Valid = false;
            } else if (rmau.ToBeClosed && rmau.ActualDate !== null && rmau.ActualDate > reportDates.Next) {
                errors.ActualDate = 'Actual delivery date cannot be in the future';
                errors.Valid = false;
            } else {
                errors.ActualDate = null;
            }
        }

        if (rmau.RagOptionID === null) {
            errors.RagOptionID = 'RAG rating is required';
            errors.Valid = false;
        } else {
            errors.RagOptionID = null;
        }

        return Promise.resolve(errors);
    };

    return (
        <ProgressUpdateForm<IRiskMitigationActionUpdate, IProgressUpdateWithDeliveryDatesValidations, IRiskMitigationAction>
        disableSave={action => action?.['Risk']?.Attributes?.filter(x => x.AttributeTypeID===1000).length > 0}
        vertoMsg={action => action?.['Risk']?.Attributes?.filter(x => x.AttributeTypeID===1000).length > 0} 
            {...otherProps}
            loadPeople={async rma => {
                const people = [];
                if (rma) {
                    if (rma.OwnerUser)
                        people.push({ role: 'Mitigating action owner', names: [rma.OwnerUser.Title] });
                    if (rma.Contributors?.length > 0)
                        people.push({ role: 'Contributors', names: rma.Contributors.map(c => c.ContributorUser?.Title) });
                    if (rma.RiskID)
                        people.push(...await EntityPeopleService.GetRiskEntityPeople({
                            riskService: otherProps.riskService,
                            riskId: rma.RiskID
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
                            label="RAG rating"
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
                            placeholder="Why have you chosen this RAG rating? What are the implications of this?"
                            rows={4}
                            maxLength={maxNarrativeLength || 750}
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
                        {!update.ToBeClosed && !e.ActionIsOngoing &&
                            <CrDatePicker
                                label="Forecast delivery date"
                                disabled={readOnly}
                                required={so.ForecastDate == null || so.ForecastDate < new Date()}
                                className={styles.formField}
                                minDate={new Date()}
                                value={update.ForecastDate}
                                onSelectDate={d => changeDatePicker(d, 'ForecastDate')}
                                history={so.ForecastDate}
                                errorMessage={errors.ForecastDate}
                            />
                        }
                        {update.ToBeClosed && !e.ActionIsOngoing &&
                            <CrDatePicker
                                label="Actual delivery date"
                                disabled={readOnly}
                                required={update.ToBeClosed}
                                maxDate={reportDates?.Next}
                                className={styles.formField}
                                value={update.ActualDate}
                                onSelectDate={d => changeDatePicker(d, 'ActualDate')}
                                errorMessage={errors.ActualDate}
                            />
                        }
                        {!e.ActionIsOngoing &&
                            <DeliveryDatesField
                                baseline={e.BaselineDate}
                                forecast={e.ForecastDate}
                            />
                        }
                    </>
                );
            }}
            loadEntity={id => riskActionService.read(id, true, true)}
            loadEntityUpdate={id => riskActionUpdateService.read(id)}
            loadNewEntityUpdate={() => new RiskMitigationActionUpdate(entityId)}
            loadLastSavedProgressUpdate={() => reportDates?.Next &&
                riskActionUpdateService.readLatestUpdateForPeriod(entityId, reportDates.Next)}
            loadLastSignedOffEntityUpdate={() => reportDates?.Previous &&
                riskActionUpdateService.readLastSignedOffUpdateForPeriod(entityId, reportDates.Previous)}
            onValidateUpdate={validateRiskMitigationActionProgressUpdate}
            onSaveUpdate={rmau => riskActionUpdateService.create(rmau)}
            onClearForm={(rma, showForm) => new RiskMitigationActionProgressUpdateFormState(entityId, reportDates?.Next, rma, showForm)}
            reportDates={reportDates}
            entityId={entityId}
            entity={entity}
            reportingFrequencies={lookupData?.ReportingFrequencies}
        />
    );
};
