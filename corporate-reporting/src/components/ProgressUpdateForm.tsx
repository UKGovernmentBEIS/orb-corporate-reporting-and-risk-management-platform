import React from 'react';
import {
    SaveStatus, IEntity, ICrUpdateFormState, IProgressUpdateValidations, CrUpdateFormState,
    IProgressUpdate, ProgressUpdate, ProgressUpdateValidations, IReportingEntity,
    ReportingEntity, ICoreFormProps, IEntityRole, IEntityAttributes, IReportDueDates, IReportingFrequency
} from '../types';
import styles from '../styles/cr.module.scss';
import { FormButtons } from './cr/FormButtons';
import { UpdateHeader } from './cr/UpdateHeader';
import { IDropdownOption } from 'office-ui-fabric-react/lib/Dropdown';
import { ConfirmDialog } from './cr/ConfirmDialog';
import { FieldErrorMessage } from './cr/FieldDecorators';
import { DateService } from '../services/DateService';
import { RagPicker } from './cr/RagPicker';
import { CrTextField } from './cr/CrTextField';
import { CrCheckbox } from './cr/CrCheckbox';
import { IChoiceGroupOption } from 'office-ui-fabric-react/lib/ChoiceGroup';
import { AttributeService, SearchObjectService } from '../services';
import { MessageBar, MessageBarButton, MessageBarType } from 'office-ui-fabric-react';
import { subDays } from 'date-fns';

export const ValidateProgressUpdate = (progressUpdate: IProgressUpdate): Promise<IProgressUpdateValidations> => {
    const errors = new ProgressUpdateValidations();

    if (progressUpdate.Comment === null || progressUpdate.Comment === '') {
        errors.Comment = 'Progress update is required';
        errors.Valid = false;
    }
    else
        errors.Comment = null;

    if (progressUpdate.RagOptionID === null) {
        errors.RagOptionID = 'RAG rating is required';
        errors.Valid = false;
    }
    else
        errors.RagOptionID = null;

    return Promise.resolve(errors);
};

export interface IProgressUpdateFormChangeHandlers<T> {
    clearField: (fieldName: string, callback?: (entityUpdate: T) => void) => void;
    changeColor: (colorId: number, fieldName: string, callback?: (entityUpdate: T) => void) => void;
    changeTextField: (value: string, fieldName: string, callback?: (entityUpdate: T) => void) => void;
    changeDropdown: (option: IDropdownOption, fieldName: string, index?: number, callback?: (entityUpdate: T) => void) => void;
    changeNumberField: (value: number, fieldName: string, callback?: (entityUpdate: T) => void) => void;
    changeDatePicker: (value: Date, fieldName: string, callback?: (entityUpdate: T) => void) => void;
    changeCheckbox: (value: boolean, fieldName: string, callback?: (entityUpdate: T) => void) => void;
    changeChoiceGroup: (option: IChoiceGroupOption, fieldName: string, callback?: (entityUpdate: T) => void) => void;
    changeJson: (value: unknown, fieldName: string, callback?: (entityUpdate: T) => void) => void;
    changeMultiDropdownStringArray: (item: IDropdownOption, fieldName: string, callback?: (entityUpdate: T) => void) => void;
}

export interface IProgressUpdateFormProps<T extends IProgressUpdate, V extends IProgressUpdateValidations, E extends IReportingEntity | IReportingEntity & IEntityAttributes> extends ICoreFormProps {
    entity: E;
    title?: (entity: E) => string;
    tags?: (entity: E) => string[];
    parents?: (entity: E) => string[];
    loadPeople?: (entity: E) => Promise<IEntityRole[]>;
    dueDate?: (entityUpdate: T, entity: E) => Date;
    rag?: (entityUpdate: T) => number;
    ragLabel?: (entityUpdate: T) => string;
    renderFormFields?: (changeHandlers: IProgressUpdateFormChangeHandlers<T>, formState: ICrUpdateFormState<T, V, E>) => React.ReactElement;
    loadEntity: (entityId: number) => Promise<E>;
    loadEntityUpdate: (entityUpdateId: number) => Promise<T>;
    loadNewEntityUpdate: () => T;
    loadLastSavedProgressUpdate: () => Promise<T>;
    onLastSavedProgressUpdateLoaded?: (entityUpdate: T) => void;
    loadDefaultValues?: (entityUpdate: T, entity: E) => T;
    loadLastSignedOffEntityUpdate: (entity?: E, progressUpdate?: T) => Promise<T>;
    onFormOpened?: () => void;
    onAfterLoad?: (entityUpdate: T) => void; // After data is loaded from server, and before it is loaded to form
    onValidateUpdate: (entityUpdate: T, entity?: E) => Promise<V>;
    onBeforeSave?: (entityUpdate: T, entity?: E) => void;
    onSaveUpdate: (entityUpdate: T) => Promise<T>;
    onAfterSave?: (entityUpdate: T) => void;
    onClearForm: (entity?: E, showForm?: boolean) => ICrUpdateFormState<T, V, E>;
    entityUpdateId?: number;
    reportDates: IReportDueDates;
    defaultShowForm?: boolean;
    formSubmitButtonText?: string;
    hasReadOnlyItems?: boolean;
    maxCommentLength?: number;
    filters?: { text: string, dueBy: Date };
    disableSave?: (entity?: E) => boolean;
    vertoMsg?: (entity?: E) => boolean;
    disableLoadLastSavedProgressUpdate?: boolean;
    disableLoadLastSignedOff?: boolean;
    reportingFrequencies: IReportingFrequency[];
}

export class ProgressUpdateFormState extends CrUpdateFormState<ProgressUpdate, ProgressUpdateValidations, ReportingEntity>
    implements ICrUpdateFormState<IProgressUpdate, IProgressUpdateValidations, IReportingEntity> {
    constructor(entityId: number, period: Date, parentEntity?: IReportingEntity, showForm?: boolean) {
        super(new ProgressUpdate(period), parentEntity || new ReportingEntity(), new ProgressUpdate(period), new ProgressUpdateValidations(), showForm || false);
    }
}

export class ProgressUpdateForm<T extends IProgressUpdate, V extends IProgressUpdateValidations, E extends IReportingEntity>
    extends React.Component<IProgressUpdateFormProps<T, V, E>, ICrUpdateFormState<T, V, E>> {

    constructor(props: IProgressUpdateFormProps<T, V, E>) {
        super(props);
        this.state = props.onClearForm(null, props.defaultShowForm);
    }

    public render(): React.ReactElement<IProgressUpdateFormProps<T, V, E>> {
        const { entity, title, tags, parents, dueDate, rag,
            ragLabel, renderFormFields, filters, disableSave, vertoMsg, reportDates } = this.props;
        const { ShowForm, FormData, ParentEntity, FormIsDirty, FormSaveStatus, People, PeopleLoaded, ShowEarlyWarning } = this.state;
        const reportingEntity = { ...ParentEntity, ...entity };
        const errors = this.state.ValidationErrors;
        return (
            <>
                {this.matchesFilter(reportingEntity, filters?.text) &&
                    <div className={styles.cr}>
                        <UpdateHeader
                            title={title?.(reportingEntity) || reportingEntity?.Title}
                            tags={tags?.(reportingEntity) || this.entityAttributes(reportingEntity)}
                            parents={parents?.(reportingEntity)}
                            people={People}
                            onPeopleHover={() => this.loadPeople(PeopleLoaded, ParentEntity)}
                            dueDate={dueDate?.(FormData, reportingEntity)}
                            rag={rag?.(FormData) || FormData.RagOptionID}
                            ragLabel={ragLabel?.(FormData)}
                            isOpen={ShowForm}
                            onClick={this.toggleProgressUpdateForm}
                        />
                        {ShowForm &&
                            <div className={`${styles.grid} ${styles.progressUpdateFormContent}`}>
                                {ShowEarlyWarning &&
                                    <div className={styles.gridRow}>
                                        <div className={`${styles.gridCol} ${styles.sm12}`}>
                                            <MessageBar
                                                className={styles.formWarning}
                                                messageBarType={MessageBarType.warning}
                                                onDismiss={() => this.setState({ ShowEarlyWarning: false, EarlyWarningDismissed: true })}
                                                isMultiline={true}
                                                actions={
                                                    <MessageBarButton onClick={() => this.setState({ ShowEarlyWarning: false, EarlyWarningDismissed: true })}>
                                                        Update is for period ending {DateService.dateToUkLongDate(reportDates?.Next)}
                                                    </MessageBarButton>
                                                }>
                                                <div className={styles.fontSize16}>This update is for the period ending {DateService.dateToUkLongDate(reportDates?.Next)}. Are you sure you want to enter your update for this period?</div>
                                                <div><br />If your update is for the period ending {DateService.dateToUkLongDate(reportDates?.Previous)}, please select &apos;Last period&apos; from the menu above.</div>
                                            </MessageBar>
                                        </div>
                                    </div>
                                }
                                <div className={styles.gridRow}>
                                    <div className={`${styles.gridCol} ${styles.sm12}`}>
                                        {renderFormFields?.(this.changeHandlers, this.state)
                                            || FormData && this.progressUpdateFormFields(this.changeHandlers, this.state)}
                                        {disableSave?.(ParentEntity) ? '' :
                                            <FormButtons
                                                primaryText={this.props.formSubmitButtonText || `Save`}
                                                onPrimaryClick={this.saveUpdate}
                                                onSecondaryClick={this.cancelUpdate}
                                                primaryStatus={FormSaveStatus}
                                                primaryDisabled={!FormIsDirty || FormSaveStatus === SaveStatus.Pending}
                                                secondaryDisabled={!this.props.onCancelled && !FormIsDirty}
                                            />
                                        }
                                        {vertoMsg?.(ParentEntity) ?
                                            <div>NOTE: The Save button has been removed because this is a Verto project and updates must be supplied via Verto.<br/><br/></div>
                                            : ''
                                        }
                                        {!errors.Valid &&
                                            <div className={styles.updateFormErrors}>
                                                <FieldErrorMessage value="The values you have entered have the following errors:" />
                                                {Object.keys(errors).map(e => (e !== 'Valid' && errors[e] !== null) && <FieldErrorMessage value={errors[e]} />)}
                                            </div>
                                        }
                                        <ConfirmDialog
                                            hidden={this.state.HideClearFormDialog}
                                            title={`Are you sure you want to clear the update?`}
                                            content={`You have unsaved data in the form.`}
                                            confirmButtonText="Delete"
                                            handleConfirm={this.onConfirmClear}
                                            handleCancel={this.toggleClearFormDialog}
                                        />
                                    </div>
                                </div>
                            </div>
                        }
                    </div>
                }
            </>
        );
    }

    //#region Form initialisation

    public componentDidMount(): void {
        this.loadUpdates();
        this.loadUpdateIsEarly(this.props.entity, this.props.reportDates, this.props.reportingFrequencies);
        if (this.state.ShowForm && this.props.onFormOpened) {
            this.props.onFormOpened();
        }
    }

    public componentDidUpdate(prevProps: IProgressUpdateFormProps<T, V, E>): void {
        const { entity, entityId, entityUpdateId, reportDates, reportingFrequencies } = this.props;
        if (prevProps.entityId !== entityId || prevProps.reportDates?.Next?.getTime() !== reportDates?.Next?.getTime()) {
            this.loadUpdates();
        }

        if (prevProps.entityUpdateId !== entityUpdateId && entityUpdateId) {
            this.loadEntityUpdate(entityUpdateId);
        }

        if (prevProps.entity?.ID !== entity?.ID
            || prevProps.entity?.Title !== entity?.Title
            || prevProps.reportDates?.Previous?.getTime() !== reportDates?.Previous?.getTime()
            || prevProps.reportDates?.Next?.getTime() !== reportDates?.Next?.getTime()
            || prevProps.reportingFrequencies?.length !== reportingFrequencies?.length) {
            this.loadUpdateIsEarly(entity, reportDates, reportingFrequencies);
        }
    }

    private loadUpdates = async (): Promise<void> => {
        this.setState({ Loading: true });
        try {
            const loadingPromises = [];
            if (this.props.entityId) {
                loadingPromises.push(this.loadEntity(this.props.entityId));
            }

            if (this.props.entityUpdateId) {
                // If entityUpdateId is supplied, load specific update. E.g. When accessed via Draft reports
                loadingPromises.push(this.loadEntityUpdate(this.props.entityUpdateId));
            }
            else if (!this.props.disableLoadLastSavedProgressUpdate) {
                // Load last saved update for revision, unless disabled when form in read-only mode 
                loadingPromises.push(this.loadPreviousEntityUpdate());
            }

            const results = await Promise.all(loadingPromises);

            // If there is no saved update for the selected period, initialise the form with optionally specified defaults
            const [entity, entityUpdate] = results as [E, T];
            if (!entityUpdate) {
                if (this.props.loadDefaultValues) {
                    this.setState(s => ({ FormData: this.props.loadDefaultValues(s.FormData, entity) }));
                } else {
                    // If no defaults are specified, re-initialise the form to blank in case user entered data or data loaded for another period
                    this.setState(s => this.props.onClearForm(entity, s.ShowForm));
                }
            }

            this.onLoaded();
        } catch (err) {
            this.onErrorLoading();
        }
    }

    private onLoaded = (): void => {
        if (this.props.defaultShowForm || this.state.ShowForm) {
            this.loadLastSignedOffEntityUpdate();
        }
        this.setState({ Loading: false, FormIsDirty: true });
    }

    private onErrorLoading = (): void => {
        this.setState({ Loading: false });
    }

    private loadEntity = async (entityId: number): Promise<E> => {
        try {
            const entity = await this.props.loadEntity(entityId);
            if (entity !== null) {
                this.setState({ ParentEntity: entity });
            }
            return entity;
        } catch (err) {
            this.props.errorHandling?.onError(`Error loading item`, err.message);
        }
    }

    private loadEntityUpdate = async (entityUpdateId: number): Promise<T> => {
        try {
            const eu = await this.props.loadEntityUpdate(entityUpdateId);
            this.props.onAfterLoad?.(eu);
            if (eu !== null) this.setState({ FormData: eu });
            return eu;
        } catch (err) {
            this.props.errorHandling?.onError(`Error loading progress update`, err.message);
        }
    }

    private loadPreviousEntityUpdate = async (): Promise<IProgressUpdate> => {
        try {
            const eu = await this.props.loadLastSavedProgressUpdate();
            if (eu) {
                this.setState({ FormIsDirty: false, FormData: eu });
                this.props.onLastSavedProgressUpdateLoaded?.(eu);
            }
            return eu;
        } catch (err) {
            this.props.errorHandling?.onError(`Error loading previous progress update`, err.message);
        }
    }

    private loadLastSignedOffEntityUpdate = async (): Promise<T> => {
        if (!this.props.disableLoadLastSignedOff) {
            try {
                const eu = await this.props.loadLastSignedOffEntityUpdate();
                this.setState({ LastSignedOffUpdate: eu || this.props.loadNewEntityUpdate() });
                return eu;
            } catch (err) {
                this.props.errorHandling?.onError(`Error loading last signed off update`, err.message);
            }
        }
    }

    private loadPeople = async (alreadyLoaded: boolean, entity: E): Promise<void> => {
        if (this.props.loadPeople && !alreadyLoaded) {
            try {
                const p = await this.props.loadPeople(entity);
                this.setState({ People: p });
            } finally {
                this.setState({ PeopleLoaded: true });
            }
        }
    }

    private matchesFilter = (entity: IEntity, filterText: string): boolean => {
        return filterText === undefined || filterText === null || filterText === ''
            || (entity && SearchObjectService.search(entity, filterText));
    }

    private loadUpdateIsEarly = (entity: IReportingEntity, reportDates: IReportDueDates, reportingFrequencies: IReportingFrequency[]) => {
        if (entity && reportDates) {
            const warnUntil = reportingFrequencies?.find(rf => rf.ID === entity?.ReportingFrequency);
            if (warnUntil?.EarlyUpdateWarningDays && reportDates?.Previous > subDays(new Date(), warnUntil?.EarlyUpdateWarningDays)) {
                this.setState({ UpdateIsEarly: true });
            }
        }
    }

    //#endregion

    //#region Form defaults

    private entityAttributes = (rse: E): string[] => {
        if (rse?.Attributes?.length > 0) {
            return AttributeService.attributesToBadgeStrings(rse.Attributes);
        }
        return [];
    }

    private progressUpdateFormFields = (
        { changeColor, changeTextField, changeCheckbox }: IProgressUpdateFormChangeHandlers<T>,
        { FormData: update, LastSignedOffUpdate: so, ValidationErrors: errors }: ICrUpdateFormState<T, V, E>
    ) => {
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
                />
                <CrTextField
                    label="This month's update"
                    className={styles.formField}
                    required={true}
                    multiline
                    placeholder='Why have you chosen this RAG rating? What are the implications of this?'
                    rows={4}
                    maxLength={this.props.maxCommentLength || 500}
                    charCounter={true}
                    value={update.Comment}
                    onChange={v => changeTextField(v, 'Comment')}
                    history={so.Comment}
                    errorMessage={errors.Comment}
                />
                <CrCheckbox
                    label="Tick this box to mark the activity as closed. Only do this if delivery is complete and there are no more actions to take."
                    className={styles.formField}
                    checked={update.ToBeClosed}
                    onChange={(_, isChecked) => changeCheckbox(isChecked, 'ToBeClosed')}
                />
            </>
        );
    }

    //#endregion

    //#region Field change handlers

    private checkIfEarly = (updateIsEarly: boolean, warningIsShowing: boolean, warningIsDismissed: boolean): void => {
        if (updateIsEarly && !warningIsShowing && !warningIsDismissed) {
            this.setState({ ShowEarlyWarning: true });
        }
    }

    private changeHandlers: IProgressUpdateFormChangeHandlers<T> = {
        clearField: (f, callback?): void => {
            this.setState(s => ({ FormData: { ...s.FormData, [f]: null }, FormIsDirty: true }), () => callback?.(this.state.FormData));
        },
        changeColor: (colorId, f, callback?): void => {
            this.checkIfEarly(this.state.UpdateIsEarly, this.state.ShowEarlyWarning, this.state.EarlyWarningDismissed);
            this.setState(s => ({ FormData: { ...s.FormData, [f]: colorId }, FormIsDirty: true }), () => callback?.(this.state.FormData));
        },
        changeTextField: (value, f, callback?): void => {
            this.checkIfEarly(this.state.UpdateIsEarly, this.state.ShowEarlyWarning, this.state.EarlyWarningDismissed);
            this.setState(s => ({ FormData: { ...s.FormData, [f]: value }, FormIsDirty: true }), () => callback?.(this.state.FormData));
        },
        changeDropdown: (option, f, _i?, callback?): void => {
            this.checkIfEarly(this.state.UpdateIsEarly, this.state.ShowEarlyWarning, this.state.EarlyWarningDismissed);
            this.setState(s => ({ FormData: { ...s.FormData, [f]: option.key }, FormIsDirty: true }), () => callback?.(this.state.FormData));
        },
        changeNumberField: (value, f, callback?): void => {
            this.checkIfEarly(this.state.UpdateIsEarly, this.state.ShowEarlyWarning, this.state.EarlyWarningDismissed);
            this.setState(s => ({ FormData: { ...s.FormData, [f]: Number(value) }, FormIsDirty: true }), () => callback?.(this.state.FormData));
        },
        changeDatePicker: (value, f, callback?): void => {
            this.checkIfEarly(this.state.UpdateIsEarly, this.state.ShowEarlyWarning, this.state.EarlyWarningDismissed);
            this.setState(s => ({ FormData: { ...s.FormData, [f]: value && DateService.setLocaleDateToUTC(value) }, FormIsDirty: true }), () => callback?.(this.state.FormData));
        },
        changeCheckbox: (value, f, callback?): void => {
            this.checkIfEarly(this.state.UpdateIsEarly, this.state.ShowEarlyWarning, this.state.EarlyWarningDismissed);
            this.setState(s => ({ FormData: { ...s.FormData, [f]: value }, FormIsDirty: true }), () => callback?.(this.state.FormData));
        },
        changeChoiceGroup: (option, f, callback?): void => {
            this.checkIfEarly(this.state.UpdateIsEarly, this.state.ShowEarlyWarning, this.state.EarlyWarningDismissed);
            this.setState(s => ({ FormData: { ...s.FormData, [f]: option.key }, FormIsDirty: true }), () => callback?.(this.state.FormData));
        },
        changeJson: (value, f, callback?): void => {
            this.checkIfEarly(this.state.UpdateIsEarly, this.state.ShowEarlyWarning, this.state.EarlyWarningDismissed);
            this.setState(s => ({ FormData: { ...s.FormData, [f]: value }, FormIsDirty: true }), () => callback?.(this.state.FormData));
        },
        changeMultiDropdownStringArray: (item: IDropdownOption, f: string, callback): void => {
            this.checkIfEarly(this.state.UpdateIsEarly, this.state.ShowEarlyWarning, this.state.EarlyWarningDismissed);
            this.setState(s => {
                const choices = new Set<string>(Array.isArray(s.FormData[f]) ? s.FormData[f] : []);
                if (item.selected) {
                    choices.add(item.key as string);
                } else {
                    choices.delete(item.key as string);
                }
                return { FormData: { ...s.FormData, [f]: [...choices] }, FormIsDirty: true };
            }, () => callback?.(this.state.FormData));
        },
    };

    //#endregion

    //#region Form infrastructure

    private saveUpdate = async (): Promise<void> => {
        const { onValidateUpdate, onBeforeSave, onSaveUpdate, onAfterSave, onSaved } = this.props;
        const { FormData, ParentEntity } = this.state;
        try {
            let validations: V;
            if (onValidateUpdate) {
                validations = await onValidateUpdate(FormData, ParentEntity);
            }
            this.setState({ ValidationErrors: validations });
            if (validations.Valid) {
                this.setState({ FormSaveStatus: SaveStatus.Pending });
                const u = FormData;
                if (u.UpdateUser) delete u.UpdateUser;
                if (onBeforeSave) onBeforeSave(u, ParentEntity);
                delete u.ID;
                delete u['Id'];
                u.UpdateDate = new Date();

                const pu = await onSaveUpdate(u);
                this.setState({ FormSaveStatus: SaveStatus.Success, FormData: pu, FormIsDirty: false }, () => onAfterSave && onAfterSave(pu));
                this.props.errorHandling?.clearErrors();
                if (onSaved) onSaved();
            }
        } catch (err) {
            this.setState({ FormSaveStatus: SaveStatus.Error });
            this.props.errorHandling?.onError(`Error saving progress update`, err.message);
        }
    }

    private cancelUpdate = (): void => {
        if (this.props.onCancelled) {
            this.props.onCancelled(); return;
        }
        if (this.state.FormIsDirty)
            this.toggleClearFormDialog();
        else
            this.onConfirmClear();
    }

    private onConfirmClear = (): void => {
        this.loadPreviousEntityUpdate();
        this.setState({ HideClearFormDialog: true });
    }

    private toggleProgressUpdateForm = async (): Promise<void> => {
        this.loadLastSignedOffEntityUpdate();
        if (!this.state.ShowForm) {
            if (this.props.onFormOpened) this.props.onFormOpened();
        }
        this.setState(s => ({ ShowForm: !s.ShowForm }));
    }

    private toggleClearFormDialog = (): void => {
        this.setState(s => ({ HideClearFormDialog: !s.HideClearFormDialog }));
    }

    //#endregion
}
