import React, { useContext, useMemo } from 'react';
import {
    CrUpdateFormState, IProjectUpdate, IProject,
    ProjectUpdate, Project, ProgressUpdateValidations, IEntityProgressUpdateFormProps
} from '../../types';
import styles from '../../styles/cr.module.scss';
import { RagPicker } from '../cr/RagPicker';
import { RagWithComments } from '../cr/RagWithComments';
import { CrTextField } from '../cr/CrTextField';
import { ProgressUpdateForm } from '../ProgressUpdateForm';
import { CrDropdown } from '../cr/CrDropdown';
import { LookupService, ValidationService, EntityPeopleService, AttributeService, NumberService } from '../../services';
import { CrNumberTextField } from '../cr/CrNumberTextField';
import { CrCheckbox } from '../cr/CrCheckbox';
import { CrLabel } from '../cr/CrLabel';
import { DataContext } from '../DataContext';

export class ProjectProgressUpdateFormValidations extends ProgressUpdateValidations {
    public WholeLifeCost: string = null;
    public WholeLifeBenefit: string = null;
    public NetPresentValue: string = null;
}

export class ProjectProgressUpdateFormState extends CrUpdateFormState<IProjectUpdate, ProjectProgressUpdateFormValidations, IProject> {
    constructor(projectId: number, period: Date, parentEntity?: IProject, showForm?: boolean) {
        super(
            new ProjectUpdate(projectId, period),
            parentEntity || new Project(),
            new ProjectUpdate(),
            new ProjectProgressUpdateFormValidations(),
            showForm
        );
    }
}

export const ProjectProgressUpdateForm = ({ entityId, entity, reportDates, ...other }: IEntityProgressUpdateFormProps<IProject>): React.ReactElement => {
    const { dataServices, lookupData, loadLookupData: { projectPhases, reportingFrequencies } } = useContext(DataContext);
    
    useMemo(() => projectPhases(), [projectPhases]);
    useMemo(() => reportingFrequencies(), [reportingFrequencies]);

    const validateProjectProgressUpdate = (pu: IProjectUpdate) => {
        const errors = new ProjectProgressUpdateFormValidations();

        if (pu.WholeLifeCost !== null && isNaN(Number(pu.WholeLifeCost))) {
            errors.WholeLifeCost = 'Whole life cost must be a number';
            errors.Valid = false;
        } else if (pu.WholeLifeCost !== null && !ValidationService.validSqlDecimal(Number(pu.WholeLifeCost))) {
            errors.WholeLifeCost = 'Whole life cost is too big';
            errors.Valid = false;
        } else errors.WholeLifeCost = null;

        if (pu.WholeLifeBenefit !== null && isNaN(Number(pu.WholeLifeBenefit))) {
            errors.WholeLifeBenefit = 'Whole life benefit must be a number';
            errors.Valid = false;
        } else if (pu.WholeLifeBenefit !== null && !ValidationService.validSqlDecimal(Number(pu.WholeLifeBenefit))) {
            errors.WholeLifeBenefit = 'Whole life benefit is too big';
            errors.Valid = false;
        } else errors.WholeLifeBenefit = null;

        if (pu.NetPresentValue !== null && isNaN(Number(pu.NetPresentValue))) {
            errors.NetPresentValue = 'Net present value must be a number';
            errors.Valid = false;
        } else if (pu.NetPresentValue !== null && !ValidationService.validSqlDecimal(Number(pu.NetPresentValue))) {
            errors.NetPresentValue = 'Net present value is too big';
            errors.Valid = false;
        } else errors.NetPresentValue = null;

        return Promise.resolve(errors);
    };

    return (
        <ProgressUpdateForm<IProjectUpdate, ProjectProgressUpdateFormValidations, IProject>
            {...other}
            disableSave={p => p.Attributes.filter(x => x.AttributeTypeID === 1000).length > 0 }
            vertoMsg={p => p.Attributes.filter(x => x.AttributeTypeID === 1000).length > 0 }
            entityId={entityId}
            entity={entity}
            dueDate={() => reportDates?.Next}
            tags={p => p?.Attributes?.length > 0 && AttributeService.attributesToBadgeStrings(p.Attributes)}
            parents={() => []}
            rag={pu => pu.OverallRagOptionID}
            loadPeople={async p => {
                const people = [];
                if (p) {
                    people.push(...await EntityPeopleService.GetProjectEntityPeople({
                        projectService: dataServices.projectService,
                        userProjectService: dataServices.userProjectService,
                        projectId: p.ID
                    }));
                }
                return people;
            }}
            renderFormFields={(changeHandlers, formState) => {
                const { FormData: pu, LastSignedOffUpdate: so, ValidationErrors: errors } = formState;
                return (
                    <div className={styles.grid}>
                        <div className={styles.gridRow}>
                            <div className={`${styles.gridCol} ${styles.sm12} ${styles.xl3}`}>
                                <CrLabel text="Current phase" singleLine={true} />
                                <CrDropdown
                                    className={styles.formField}
                                    options={LookupService.entitiesToSelectableOptions(lookupData.ProjectPhases)}
                                    selectedKey={pu.ProjectPhaseID}
                                    onChange={(_, o) => changeHandlers.changeDropdown(o, 'ProjectPhaseID')}
                                    history={so.ProjectPhase && so.ProjectPhase.Title}
                                />
                            </div>
                            <div className={`${styles.gridCol} ${styles.sm12} ${styles.xl3}`}>
                                <CrLabel text="Whole life cost" singleLine={true} />
                                <CrNumberTextField
                                    className={styles.formField}
                                    suffix="£m"
                                    maxLength={19}
                                    value={pu.WholeLifeCost}
                                    onChange={n => changeHandlers.changeTextField(n, 'WholeLifeCost')}
                                    history={NumberService.IsNullOrUndefined(so?.WholeLifeCost) ? null : Number(so?.WholeLifeCost)}
                                    errorMessage={errors.WholeLifeCost}
                                />
                            </div>
                            <div className={`${styles.gridCol} ${styles.sm12} ${styles.xl3}`}>
                                <CrLabel text="Whole life benefit" singleLine={true} />
                                <CrNumberTextField
                                    className={styles.formField}
                                    suffix="£m"
                                    maxLength={19}
                                    value={pu.WholeLifeBenefit}
                                    onChange={n => changeHandlers.changeTextField(n, 'WholeLifeBenefit')}
                                    history={NumberService.IsNullOrUndefined(so?.WholeLifeBenefit) ? null : Number(so?.WholeLifeBenefit)}
                                    errorMessage={errors.WholeLifeBenefit}
                                />
                            </div>
                            <div className={`${styles.gridCol} ${styles.sm12} ${styles.xl3}`}>
                                <CrLabel text="Net present value" singleLine={true} />
                                <CrNumberTextField
                                    className={styles.formField}
                                    suffix="£m"
                                    maxLength={19}
                                    value={pu.NetPresentValue}
                                    onChange={n => changeHandlers.changeTextField(n, 'NetPresentValue')}
                                    history={NumberService.IsNullOrUndefined(so?.NetPresentValue) ? null : Number(so?.NetPresentValue)}
                                    errorMessage={errors.NetPresentValue}
                                />
                            </div>
                        </div>
                        <div className={styles.gridRow}>
                            <div className={`${styles.gridCol} ${styles.sm12}`}>
                                <p className={styles.fontSize18}>Headlines</p>
                                <RagPicker
                                    label='Delivery confidence'
                                    className={styles.formField}
                                    selectedRAG={pu.OverallRagOptionID}
                                    onColorChanged={id => changeHandlers.changeColor(id, 'OverallRagOptionID')}
                                    history={so.OverallRagOptionID}
                                />
                                <CrTextField
                                    label="Delivery confidence description"
                                    className={styles.formField}
                                    placeholder='Why has the Senior Responsible Owner chosen the particular RAG rating? Summarise any major risks or issues (put detail in the individual work stream)'
                                    multiline
                                    rows={2}
                                    maxLength={500}
                                    charCounter={true}
                                    value={pu.ProgressUpdate}
                                    onChange={t => changeHandlers.changeTextField(t, 'ProgressUpdate')}
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
                                    value={pu.FutureActions}
                                    onChange={t => changeHandlers.changeTextField(t, 'FutureActions')}
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
                                    value={pu.Escalations}
                                    onChange={t => changeHandlers.changeTextField(t, 'Escalations')}
                                    history={so.Escalations}
                                />
                                <p className={styles.fontSize18}>Key Indicators</p>
                                <RagWithComments
                                    label='Finance'
                                    className={styles.formField}
                                    commentsPlaceholder='What is your net position as agreed with your business partner and how does this affect delivery?'
                                    commentsRows={1}
                                    commentsMaxLength={500}
                                    selectedColor={pu.FinanceRagOptionID}
                                    commentValue={pu.FinanceComment}
                                    onColorChanged={colorId => changeHandlers.changeColor(colorId, 'FinanceRagOptionID')}
                                    onCommentChanged={t => changeHandlers.changeTextField(t, 'FinanceComment')}
                                    history={{ color: so.FinanceRagOptionID, comment: so.FinanceComment }}
                                />
                                <RagWithComments
                                    label='People'
                                    className={styles.formField}
                                    commentsPlaceholder='Do you have enough staff or any skills concerns? How will this affect delivery?'
                                    commentsRows={1}
                                    commentsMaxLength={500}
                                    selectedColor={pu.PeopleRagOptionID}
                                    commentValue={pu.PeopleComment}
                                    onColorChanged={colorId => changeHandlers.changeColor(colorId, 'PeopleRagOptionID')}
                                    onCommentChanged={t => changeHandlers.changeTextField(t, 'PeopleComment')}
                                    history={{ color: so.PeopleRagOptionID, comment: so.PeopleComment }}
                                />
                                <RagWithComments
                                    label='Milestones'
                                    className={styles.formField}
                                    commentsPlaceholder='Are your key deliverables likely to happen on time and how does this affect delivery?'
                                    commentsRows={1}
                                    commentsMaxLength={500}
                                    selectedColor={pu.MilestonesRagOptionID}
                                    commentValue={pu.MilestonesComment}
                                    onColorChanged={colorId => changeHandlers.changeColor(colorId, 'MilestonesRagOptionID')}
                                    onCommentChanged={t => changeHandlers.changeTextField(t, 'MilestonesComment')}
                                    history={{ color: so.MilestonesRagOptionID, comment: so.MilestonesComment }}
                                />
                                <RagWithComments
                                    label='Benefits'
                                    className={styles.formField}
                                    commentsPlaceholder='Are the social or financial benefits in the business case likely to be met and how does this affect delivery?'
                                    commentsRows={1}
                                    commentsMaxLength={500}
                                    selectedColor={pu.BenefitsRagOptionID}
                                    commentValue={pu.BenefitsComment}
                                    onColorChanged={colorId => changeHandlers.changeColor(colorId, 'BenefitsRagOptionID')}
                                    onCommentChanged={t => changeHandlers.changeTextField(t, 'BenefitsComment')}
                                    history={{ color: so.BenefitsRagOptionID, comment: so.BenefitsComment }}
                                />
                                <CrCheckbox
                                    className={styles.formField}
                                    label="Mark this project for closure"
                                    checked={pu.ToBeClosed}
                                    onChange={(_e, v) => changeHandlers.changeCheckbox(v, 'ToBeClosed')} />
                                {pu.ToBeClosed &&
                                    <CrTextField className={styles.formField}
                                        label="Why has it been closed?"
                                        required={true} multiline
                                        value={pu.Comment}
                                        maxLength={500}
                                        placeholder='Please provide details of why the project is being closed.'
                                        onChange={v => changeHandlers.changeTextField(v, 'Comment')}
                                        errorMessage={errors.Comment} />}
                                <br />
                            </div>
                        </div>
                    </div>
                );
            }}
            loadEntity={pId => dataServices.projectService.read(pId, true, true)}
            loadEntityUpdate={puId => dataServices.projectUpdateService.read(puId)}
            loadNewEntityUpdate={() => new ProjectUpdate(entityId)}
            loadLastSavedProgressUpdate={() => reportDates?.Next &&
                dataServices.projectUpdateService.readLatestUpdateForPeriod(entityId, reportDates.Next)}
            loadLastSignedOffEntityUpdate={() => reportDates?.Previous &&
                dataServices.projectUpdateService.readLastSignedOffUpdateForPeriod(entityId, reportDates.Previous)}
            onValidateUpdate={validateProjectProgressUpdate}
            onBeforeSave={pu => {
                delete pu.Project;
                pu.WholeLifeCost = NumberService.ToNumberOrNull(pu.WholeLifeCost);
                pu.WholeLifeBenefit = NumberService.ToNumberOrNull(pu.WholeLifeBenefit);
                pu.NetPresentValue = NumberService.ToNumberOrNull(pu.NetPresentValue);
            }}
            onSaveUpdate={pu => dataServices.projectUpdateService.create(pu)}
            onClearForm={(p, showForm) => new ProjectProgressUpdateFormState(entityId, reportDates?.Next, p, showForm)}
            reportDates={reportDates}
            reportingFrequencies={lookupData?.ReportingFrequencies}
        />
    );
};
