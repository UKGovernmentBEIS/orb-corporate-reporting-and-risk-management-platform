import React, { useContext, useEffect, useMemo, useState } from 'react';
import styles from '../../styles/cr.module.scss';
import { ProgressUpdateForm } from "../ProgressUpdateForm";
import {
    IMilestone, IMilestoneUpdate, MilestoneUpdate, Milestone,
    CrUpdateFormState, IProgressUpdateWithDeliveryDatesValidations,
    ProgressUpdateWithDeliveryDatesValidations, IEntityProgressUpdateFormProps, IKeyWorkArea, IWorkStream
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

export class MilestoneProgressUpdateFormState extends CrUpdateFormState<IMilestoneUpdate, IProgressUpdateWithDeliveryDatesValidations, IMilestone> {
    constructor(milestoneId: number, period: Date, parentEntity?: IMilestone, showForm?: boolean) {
        super(
            new MilestoneUpdate(milestoneId, period),
            parentEntity || new Milestone(),
            new MilestoneUpdate(milestoneId),
            new ProgressUpdateWithDeliveryDatesValidations(),
            showForm || false
        );
    }
}

export const MilestoneProgressUpdateForm = (
    { entityId, entity, reportDates, ...otherProps }: IEntityProgressUpdateFormProps<IMilestone>
): React.ReactElement => {
    const { userContext, userPermissions } = useContext(OrbUserContext);
    const [parentKeyWorkArea, setParentKeyWorkArea] = useState<IKeyWorkArea>(null);
    const [parentWorkStream, setParentWorkStream] = useState<IWorkStream>(null);
    const { dataServices, lookupData, loadLookupData: { reportingFrequencies } } = useContext(DataContext);
    useMemo(() => reportingFrequencies(), [reportingFrequencies]);

    useEffect(() => {
        const loadParent = async () => {
            if (entity?.KeyWorkAreaID) {
                setParentKeyWorkArea(await dataServices.keyWorkAreaService.read(entity.KeyWorkAreaID));
            }
            if (entity?.WorkStreamID) {
                setParentWorkStream(await dataServices.workStreamService.read(entity.WorkStreamID));
            }
        };

        loadParent();
    }, [entity?.KeyWorkAreaID, entity?.WorkStreamID, dataServices.keyWorkAreaService, dataServices.workStreamService]);

    const validateMilestoneProgressUpdate = (msu: IMilestoneUpdate, ms: IMilestone): Promise<IProgressUpdateWithDeliveryDatesValidations> => {
        const errors = new ProgressUpdateWithDeliveryDatesValidations();

        if (msu.Comment === null || msu.Comment === '') {
            errors.Comment = 'Progress update is required';
            errors.Valid = false;
        } else errors.Comment = null;

        if (!msu.ToBeClosed && currentDeliveryDate(ms) < new Date() && msu.ForecastDate === null) {
            errors.ForecastDate = 'Forecast delivery date is required';
            errors.Valid = false;
        } else if (!msu.ToBeClosed && msu.ForecastDate !== null && msu.ForecastDate < new Date()) {
            errors.ForecastDate = 'Forecast delivery date cannot be in the past';
            errors.Valid = false;
        } else errors.ForecastDate = null;

        if (msu.ToBeClosed && msu.ActualDate === null) {
            errors.ActualDate = 'Actual delivery date is required if the milestone is complete';
            errors.Valid = false;
        } else if (msu.ToBeClosed && msu.ActualDate !== null && msu.ActualDate > reportDates.Next) {
            errors.ActualDate = 'Actual delivery date cannot be in the future';
            errors.Valid = false;
        } else errors.ActualDate = null;

        if (msu.RagOptionID === null) {
            errors.RagOptionID = 'RAG rating is required';
            errors.Valid = false;
        } else errors.RagOptionID = null;

        return Promise.resolve(errors);
    };

    return (
        <ProgressUpdateForm<IMilestoneUpdate, IProgressUpdateWithDeliveryDatesValidations, IMilestone>
            {...otherProps}
            entityId={entityId}
            dueDate={() => reportDates?.Next}
            title={ms => {
                const title = [];
                if (ms.Title) {
                    if (ms.MilestoneCode) title.push(ms.MilestoneCode);
                    title.push(ms.Title);
                }
                return title.join(' - ');
            }}
            parents={ms => {
                if (ms.KeyWorkArea)
                    return [ms.KeyWorkArea.Title];
                if (ms.WorkStream)
                    return [ms.WorkStream.Title];
                return [];
            }}
            loadPeople={async ms => {
                const people = [];
                if (ms) {
                    if (ms.LeadUser)
                        people.push({ role: 'Lead', names: [ms.LeadUser.Title] });
                    if (ms.Contributors && ms.Contributors.length > 0)
                        people.push({ role: 'Contributors', names: ms.Contributors.map(c => c.ContributorUser && c.ContributorUser.Title) });

                    if (ms.KeyWorkArea) {
                        people.push(...await EntityPeopleService.GetDirectorateEntityPeople({
                            directorateService: dataServices.directorateService,
                            userDirectorateService: dataServices.userDirectorateService,
                            directorateId: ms.KeyWorkArea.DirectorateID
                        }));
                    }
                    if (ms.WorkStream) {
                        people.push(...await EntityPeopleService.GetProjectEntityPeople({
                            projectService: dataServices.projectService,
                            userProjectService: dataServices.userProjectService,
                            projectId: ms.WorkStream.ProjectID
                        }));
                    }
                    if (ms.PartnerOrganisation) {
                        people.push(...await EntityPeopleService.GetPartnerOrganisationEntityPeople({
                            partnerOrganisationService: dataServices.partnerOrganisationService,
                            userPartnerOrganisationService: dataServices.userPartnerOrganisationService,
                            partnerOrganisationId: ms.PartnerOrganisationID
                        }));
                    }
                }
                return people;
            }}
            renderFormFields={(
                { changeColor, changeTextField, changeCheckbox, clearField, changeDatePicker },
                { FormData: update, ParentEntity: e, ValidationErrors: errors, LastSignedOffUpdate: so }
            ) => {
                const readOnly = !userPermissions.UserCanSubmitMilestoneUpdates({ milestone: e, keyWorkArea: parentKeyWorkArea, workStream: parentWorkStream })
                    && ContributorService.UserIsReadOnlyContributor(userContext.Username, e);
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
                                changeCheckbox(checked, 'ToBeClosed', () => clearField('ForecastDate', () => clearField('ActualDate')))
                            }
                        />
                        {update.ToBeClosed ||
                            <CrDatePicker
                                label='Forecast delivery date'
                                disabled={readOnly}
                                required={!update.ToBeClosed}
                                helpText="Revised date of delivery if the initial delivery date has changed"
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
            loadEntity={id => dataServices.milestoneService.read(id, true, true)}
            loadEntityUpdate={id => dataServices.milestoneUpdateService.read(id)}
            loadNewEntityUpdate={() => new MilestoneUpdate(entityId)}
            loadLastSavedProgressUpdate={() => reportDates?.Next &&
                dataServices.milestoneUpdateService.readLatestUpdateForPeriod(entityId, reportDates.Next)}
            loadDefaultValues={(update, milestone) => {
                const newUpdate = { ...update };
                newUpdate.ForecastDate = currentDeliveryDate(milestone);
                return newUpdate;
            }}
            loadLastSignedOffEntityUpdate={() => reportDates?.Previous &&
                dataServices.milestoneUpdateService.readLastSignedOffUpdateForPeriod(entityId, reportDates.Previous)}
            onValidateUpdate={validateMilestoneProgressUpdate}
            onSaveUpdate={msu => dataServices.milestoneUpdateService.create(msu)}
            onClearForm={(ms, showForm) => new MilestoneProgressUpdateFormState(entityId, reportDates?.Next, ms, showForm)}
            reportDates={reportDates}
            entity={entity}
            disableSave={ms => (ms.MilestoneTypeID ===2 && ms.Attributes.filter(x => x.AttributeTypeID === 1000).length > 0) || (!userPermissions.UserCanSubmitMilestoneUpdates({ milestone: ms, keyWorkArea: parentKeyWorkArea, workStream: parentWorkStream })
                && ContributorService.UserIsReadOnlyContributor(userContext.Username, ms))}
            vertoMsg={ms => ms.MilestoneTypeID ===2 && ms.Attributes.filter(x => x.AttributeTypeID === 1000).length > 0 }                
            reportingFrequencies={lookupData?.ReportingFrequencies}
        />
    );
};
