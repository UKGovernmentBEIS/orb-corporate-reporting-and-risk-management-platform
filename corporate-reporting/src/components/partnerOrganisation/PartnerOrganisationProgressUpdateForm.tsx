import React, { useContext, useMemo } from 'react';
import {
    CrUpdateFormState, IPartnerOrganisationUpdate, IProgressUpdateValidations, IPartnerOrganisation,
    PartnerOrganisationUpdate, PartnerOrganisation, ProgressUpdateValidations, IEntityProgressUpdateFormProps
} from '../../types';
import styles from '../../styles/cr.module.scss';
import { RagPicker } from '../cr/RagPicker';
import { RagWithComments } from '../cr/RagWithComments';
import { CrTextField } from '../cr/CrTextField';
import { ProgressUpdateForm } from '../ProgressUpdateForm';
import { ContributorService, EntityPeopleService } from '../../services';
import { DataContext } from '../DataContext';
import { OrbUserContext } from '../OrbUserContext';

export class PartnerOrganisationProgressUpdateFormState extends CrUpdateFormState<IPartnerOrganisationUpdate, IProgressUpdateValidations, IPartnerOrganisation> {
    constructor(partnerOrganisationId: number, period: Date, parentEntity?: IPartnerOrganisation, showForm?: boolean) {
        super(
            new PartnerOrganisationUpdate(period, partnerOrganisationId, parentEntity),
            parentEntity || new PartnerOrganisation(),
            new PartnerOrganisationUpdate(period),
            new ProgressUpdateValidations(),
            showForm
        );
    }
}

export const PartnerOrganisationProgressUpdateForm = (
    { entityId, entity, reportDates, ...otherProps }: IEntityProgressUpdateFormProps<IPartnerOrganisation>
): React.ReactElement => {
    const { userContext } = useContext(OrbUserContext);
    const { dataServices, lookupData, loadLookupData: { reportingFrequencies } } = useContext(DataContext);
    useMemo(() => reportingFrequencies(), [reportingFrequencies]);

    return (
        <ProgressUpdateForm<IPartnerOrganisationUpdate, IProgressUpdateValidations, IPartnerOrganisation>
            {...otherProps}
            entityId={entityId}
            dueDate={() => reportDates?.Next}
            parents={po => po && po.Directorate ? [po.Directorate.Title] : []}
            rag={pou => pou.OverallRagOptionID}
            loadPeople={async po => {
                const people = [];
                if (po) {
                    people.push(...await EntityPeopleService.GetPartnerOrganisationEntityPeople({
                        partnerOrganisationService: dataServices.partnerOrganisationService,
                        userPartnerOrganisationService: dataServices.userPartnerOrganisationService,
                        partnerOrganisationId: po.ID
                    }));
                }
                return people;
            }}
            renderFormFields={({ changeColor, changeTextField }, { FormData: pou, ParentEntity: po, LastSignedOffUpdate: so }) => {
                const showReadOnly = ContributorService.UserIsReadOnlyContributor(userContext.Username, po);
                return (
                    <div className={styles.cr}>
                        <p className={styles.fontSize18}>Headlines</p>
                        <RagPicker
                            label="Delivery confidence"
                            className={styles.formField}
                            selectedRAG={pou.OverallRagOptionID}
                            onColorChanged={id => changeColor(id, 'OverallRagOptionID')}
                            history={so.OverallRagOptionID}
                            disabled={showReadOnly}
                        />
                        <CrTextField
                            label="Delivery confidence description"
                            className={styles.formField}
                            placeholder='Why has the particular RAG been chosen? Summarise any major risks or issues currently being faced.'
                            multiline
                            rows={6}
                            maxLength={1000}
                            charCounter={true}
                            value={pou.ProgressUpdate}
                            onChange={v => changeTextField(v, 'ProgressUpdate')}
                            history={so.ProgressUpdate}
                            disabled={showReadOnly}
                        />
                        <CrTextField
                            label="Future actions"
                            className={styles.formField}
                            placeholder="What are you doing/expecting others to do? When is the RAG expected to change and what would cause this change?"
                            multiline
                            rows={6}
                            maxLength={1000}
                            charCounter={true}
                            value={pou.FutureActions}
                            onChange={v => changeTextField(v, 'FutureActions')}
                            history={so.FutureActions}
                            disabled={showReadOnly}
                        />
                        <CrTextField
                            label="Escalations for senior leader action"
                            className={styles.formField}
                            placeholder="What support does the organisation need from BEIS?"
                            multiline
                            rows={6}
                            maxLength={1000}
                            charCounter={true}
                            value={pou.Escalations}
                            onChange={v => changeTextField(v, 'Escalations')}
                            history={so.Escalations}
                            disabled={showReadOnly}
                        />
                        <p className={styles.fontSize18}>Key Indicators</p>
                        <RagWithComments
                            label="Finance"
                            className={styles.formField}
                            commentsPlaceholder='What is your net position as agreed with your business partner and how does this affect delivery?'
                            commentsRows={1}
                            commentsMaxLength={500}
                            selectedColor={pou.FinanceRagOptionID}
                            commentValue={pou.FinanceComment}
                            onColorChanged={colorId => changeColor(colorId, 'FinanceRagOptionID')}
                            onCommentChanged={v => changeTextField(v, 'FinanceComment')}
                            history={{ color: so.FinanceRagOptionID, comment: so.FinanceComment }}
                            disabled={showReadOnly}
                        />
                        <RagWithComments
                            label="People"
                            className={styles.formField}
                            commentsPlaceholder='Do you have enough staff or any skills concerns? How will this affect delivery?'
                            commentsRows={1}
                            commentsMaxLength={500}
                            selectedColor={pou.PeopleRagOptionID}
                            commentValue={pou.PeopleComment}
                            onColorChanged={colorId => changeColor(colorId, 'PeopleRagOptionID')}
                            onCommentChanged={v => changeTextField(v, 'PeopleComment')}
                            history={{ color: so.PeopleRagOptionID, comment: so.PeopleComment }}
                            disabled={showReadOnly}
                        />
                        <RagWithComments
                            label="Milestones"
                            className={styles.formField}
                            commentsPlaceholder='Are your key deliverables likely to happen on time and how does this affect delivery?'
                            commentsRows={1}
                            commentsMaxLength={500}
                            selectedColor={pou.MilestonesRagOptionID}
                            commentValue={pou.MilestonesComment}
                            onColorChanged={colorId => changeColor(colorId, 'MilestonesRagOptionID')}
                            onCommentChanged={v => changeTextField(v, 'MilestonesComment')}
                            history={{ color: so.MilestonesRagOptionID, comment: so.MilestonesComment }}
                            disabled={showReadOnly}
                        />
                        <RagWithComments
                            label="Key performance indicators"
                            className={styles.formField}
                            commentsPlaceholder='Are the key performance indicators likely to be met and how does this affect delivery?'
                            commentsRows={1}
                            commentsMaxLength={500}
                            selectedColor={pou.KPIRagOptionID}
                            commentValue={pou.KPIComment}
                            onColorChanged={colorId => changeColor(colorId, 'KPIRagOptionID')}
                            onCommentChanged={v => changeTextField(v, 'KPIComment')}
                            history={{ color: so.KPIRagOptionID, comment: so.KPIComment }}
                            disabled={showReadOnly}
                        />
                    </div>
                );
            }}
            loadEntity={id => dataServices.partnerOrganisationService.read(id, true, true)}
            loadEntityUpdate={id => dataServices.partnerOrganisationUpdateService.read(id)}
            loadNewEntityUpdate={() => new PartnerOrganisationUpdate(reportDates?.Next, entityId)}
            loadLastSavedProgressUpdate={() => reportDates?.Next &&
                dataServices.partnerOrganisationUpdateService.readLatestUpdateForPeriod(entityId, reportDates.Next)}
            loadLastSignedOffEntityUpdate={() => reportDates?.Previous &&
                dataServices.partnerOrganisationUpdateService.readLastSignedOffUpdateForPeriod(entityId, reportDates.Previous)}
            onValidateUpdate={() => Promise.resolve({ Valid: true, RagOptionID: null, Comment: null })}
            onBeforeSave={pou => delete pou.PartnerOrganisation}
            onSaveUpdate={pou => dataServices.partnerOrganisationUpdateService.create(pou)}
            onClearForm={(po, showForm) => new PartnerOrganisationProgressUpdateFormState(entityId, reportDates?.Next, po, showForm)}
            reportDates={reportDates}
            entity={entity}
            reportingFrequencies={lookupData?.ReportingFrequencies}
        />
    );
};
