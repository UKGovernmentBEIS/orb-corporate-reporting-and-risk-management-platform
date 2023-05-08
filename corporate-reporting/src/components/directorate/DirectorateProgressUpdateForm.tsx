import React, { useContext, useMemo } from 'react';
import {
    CrUpdateFormState, IDirectorateUpdate, IProgressUpdateValidations, IDirectorate,
    DirectorateUpdate, Directorate, ProgressUpdateValidations, IEntityProgressUpdateFormProps
} from '../../types';
import styles from '../../styles/cr.module.scss';
import { RagPicker } from '../cr/RagPicker';
import { RagWithComments } from '../cr/RagWithComments';
import { CrTextField } from '../cr/CrTextField';
import { ProgressUpdateForm } from '../ProgressUpdateForm';
import { EntityPeopleService } from '../../services';
import { DataContext } from '../DataContext';

export class DirectorateProgressUpdateFormState extends CrUpdateFormState<IDirectorateUpdate, IProgressUpdateValidations, IDirectorate> {
    constructor(directorateId: number, period: Date, parentEntity?: IDirectorate, showForm?: boolean) {
        super(
            new DirectorateUpdate(directorateId, period),
            parentEntity || new Directorate(),
            new DirectorateUpdate(),
            new ProgressUpdateValidations(),
            showForm
        );
    }
}

export const DirectorateProgressUpdateForm = (
    { entityId, entity, reportDates, ...otherProps }: IEntityProgressUpdateFormProps<IDirectorate>
): React.ReactElement => {
    const { dataServices, lookupData, loadLookupData: { reportingFrequencies } } = useContext(DataContext);
    useMemo(() => reportingFrequencies(), [reportingFrequencies]);

    return (
        <ProgressUpdateForm<IDirectorateUpdate, IProgressUpdateValidations, IDirectorate>
            {...otherProps}
            entityId={entityId}
            dueDate={() => reportDates?.Next}
            rag={du => du.OverallRagOptionID}
            loadPeople={async d => {
                const people = [];
                if (d) {
                    people.push(...await EntityPeopleService.GetDirectorateEntityPeople({
                        directorateService: dataServices.directorateService,
                        userDirectorateService: dataServices.userDirectorateService,
                        directorateId: d.ID
                    }));
                }
                return people;
            }}
            renderFormFields={({ changeColor, changeTextField }, { FormData: du, LastSignedOffUpdate: so }) => {
                return (
                    <div className={styles.cr}>
                        <p className={styles.fontSize18}>Headlines</p>
                        <RagPicker
                            label="Delivery confidence"
                            className={styles.formField}
                            selectedRAG={du.OverallRagOptionID}
                            onColorChanged={id => changeColor(id, 'OverallRagOptionID')}
                            history={so.OverallRagOptionID}
                        />
                        <CrTextField
                            label="Delivery confidence description"
                            className={styles.formField}
                            placeholder='Why has the director chosen the particular RAG rating? Summarise any major risks or issues (put detail in the individual key work area)'
                            multiline
                            rows={2}
                            maxLength={500}
                            charCounter={true}
                            value={du.ProgressUpdate}
                            onChange={v => changeTextField(v, 'ProgressUpdate')}
                            history={so.ProgressUpdate}
                        />
                        <CrTextField
                            label="Future actions"
                            className={styles.formField}
                            placeholder="What are you doing/expecting others to do? When is the RAG expected to change, and what would cause a change?"
                            multiline
                            rows={2}
                            maxLength={500}
                            charCounter={true}
                            value={du.FutureActions}
                            onChange={v => changeTextField(v, 'FutureActions')}
                            history={so.FutureActions}
                        />
                        <CrTextField
                            label="Escalations for senior leader action"
                            className={styles.formField}
                            placeholder="What support do you need from your Director General; the Performance, Finance and Risk Committee; the Executive Committee; or ministers?"
                            multiline
                            rows={1}
                            maxLength={500}
                            charCounter={true}
                            value={du.Escalations}
                            onChange={v => changeTextField(v, 'Escalations')}
                            history={so.Escalations}
                        />
                        <p className={styles.fontSize18}>Key Indicators</p>
                        <RagWithComments
                            label="Finance"
                            className={styles.formField}
                            commentsPlaceholder='What is your net position as agreed with your business partner and how does this affect delivery?'
                            commentsRows={1}
                            commentsMaxLength={500}
                            selectedColor={du.FinanceRagOptionID}
                            commentValue={du.FinanceComment}
                            onColorChanged={colorId => changeColor(colorId, 'FinanceRagOptionID')}
                            onCommentChanged={v => changeTextField(v, 'FinanceComment')}
                            history={{ color: so.FinanceRagOptionID, comment: so.FinanceComment }}
                        />
                        <RagWithComments
                            label="People"
                            className={styles.formField}
                            commentsPlaceholder='Do you have enough staff or any skills concerns? How will this affect delivery?'
                            commentsRows={1}
                            commentsMaxLength={500}
                            selectedColor={du.PeopleRagOptionID}
                            commentValue={du.PeopleComment}
                            onColorChanged={colorId => changeColor(colorId, 'PeopleRagOptionID')}
                            onCommentChanged={v => changeTextField(v, 'PeopleComment')}
                            history={{ color: so.PeopleRagOptionID, comment: so.PeopleComment }}
                        />
                        <RagWithComments
                            label="Milestones"
                            className={styles.formField}
                            commentsPlaceholder='Are your key deliverables likely to happen on time and how does this affect delivery?'
                            commentsRows={1}
                            commentsMaxLength={500}
                            selectedColor={du.MilestonesRagOptionID}
                            commentValue={du.MilestonesComment}
                            onColorChanged={colorId => changeColor(colorId, 'MilestonesRagOptionID')}
                            onCommentChanged={v => changeTextField(v, 'MilestonesComment')}
                            history={{ color: so.MilestonesRagOptionID, comment: so.MilestonesComment }}
                        />
                        <RagWithComments
                            label="Metrics"
                            className={styles.formField}
                            commentsPlaceholder='Are key outputs and outcomes of activities likely to be met and how does this affect delivery?'
                            commentsRows={1}
                            commentsMaxLength={500}
                            selectedColor={du.MetricsRagOptionID}
                            commentValue={du.MetricsComment}
                            onColorChanged={colorId => changeColor(colorId, 'MetricsRagOptionID')}
                            onCommentChanged={v => changeTextField(v, 'MetricsComment')}
                            history={{ color: so.MetricsRagOptionID, comment: so.MetricsComment }}
                        />
                    </div>
                );
            }}
            loadEntity={id => dataServices.directorateService.read(id, true, true)}
            loadEntityUpdate={id => dataServices.directorateUpdateService.read(id)}
            loadNewEntityUpdate={() => new DirectorateUpdate(entityId)}
            loadLastSavedProgressUpdate={() => reportDates?.Next &&
                dataServices.directorateUpdateService.readLatestUpdateForPeriod(entityId, reportDates.Next)}
            loadLastSignedOffEntityUpdate={() => reportDates?.Previous &&
                dataServices.directorateUpdateService.readLastSignedOffUpdateForPeriod(entityId, reportDates.Previous)}
            onValidateUpdate={() => Promise.resolve({ Valid: true, RagOptionID: null, Comment: null })}
            onBeforeSave={du => delete du.Directorate}
            onSaveUpdate={du => dataServices.directorateUpdateService.create(du)}
            onClearForm={(d, showForm) => new DirectorateProgressUpdateFormState(entityId, reportDates?.Next, d, showForm)}
            reportDates={reportDates}
            entity={entity}
            reportingFrequencies={lookupData?.ReportingFrequencies}
        />
    );
};
