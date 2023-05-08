import React from 'react';
import {
    IEntity,
    IEntityFormProps,
    SaveStatus,
    IContributor,
    IEntityFormState,
    IEntityValidations,
    EntityFormState,
    EntityValidations,
    IReportingCycle,
    IReportingCycleFields
} from '../types';
import styles from '../styles/cr.module.scss';
import { IDropdownOption } from 'office-ui-fabric-react/lib/Dropdown';
import { FormButtons } from './cr/FormButtons';
import { ICrMultiDropdownWithTextValue } from './cr/CrMultiDropdownWithText';
import { CrLoadingOverlay } from './cr/CrLoadingOverlay';
import { FormCommandBar } from './cr/FormCommandBar';
import { IPanelHeaderRenderer, IPanelProps, Panel, PanelType } from 'office-ui-fabric-react/lib/Panel';
import { ConfirmDialog } from './cr/ConfirmDialog';
import { EntityStatus } from '../refData/EntityStatus';
import { IEntityFormChangeHandlers } from '../types/EntityFormProps';
import { CrTextField } from './cr/CrTextField';
import { DateService } from '../services';
import { MessageBar, MessageBarType } from 'office-ui-fabric-react';
import { FormErrorsList } from './cr/FormErrorsList';

export class EntityForm<E extends IEntity, V extends IEntityValidations> extends React.Component<IEntityFormProps<E, V>, IEntityFormState<E, V>> {
    constructor(props: IEntityFormProps<E, V>) {
        super(props);
        this.state = new EntityFormState(props.loadNewEntity(), props.loadEntityValidations(), props.defaultValues);
    }

    public render(): React.ReactElement {
        const { showForm, entityName, onCancelled, renderFormFields, closeEntityConfirm } = this.props;
        const { Loading, FormData, FormIsDirty, FormSaveStatus, ValidationErrors: errors, Error } = this.state;

        return (
            <Panel
                className={styles.cr}
                isOpen={showForm}
                headerText={entityName}
                type={PanelType.medium}
                onRenderHeader={(props: IPanelProps, defaultRender: IPanelHeaderRenderer) =>
                    <>
                        {Error && <MessageBar messageBarType={MessageBarType.error}>{Error}</MessageBar>}
                        <div className={styles.panelHeaderText}>{defaultRender(props)}</div>
                    </>
                }
                onRenderNavigation={() =>
                    <FormCommandBar onSave={this.saveEntity} onCancel={onCancelled} />
                }
            >
                <div className={styles.cr}>
                    <CrLoadingOverlay isLoading={Loading} opaque={true} />
                    {renderFormFields ?
                        renderFormFields(this.entityFormChangeHandlers, this.state)
                        :
                        <CrTextField
                            label="Name"
                            className={styles.formField}
                            required={true}
                            maxLength={255}
                            value={FormData.Title}
                            onChange={v => this.entityFormChangeHandlers.changeTextField(v, 'Title')}
                            errorMessage={errors.Title}
                        />
                    }
                    <FormButtons
                        primaryStatus={FormSaveStatus}
                        primaryDisabled={!FormIsDirty || FormSaveStatus === SaveStatus.Pending}
                        secondaryDisabled={FormSaveStatus === SaveStatus.Pending}
                        onPrimaryClick={this.saveEntity}
                        onSecondaryClick={onCancelled}
                    />
                    <FormErrorsList errors={errors} />
                </div>
                <ConfirmDialog
                    hidden={!this.state.ShowClosureConfirmation}
                    title={closeEntityConfirm?.header
                        || `Are you sure you want to close this ${entityName?.toLowerCase()}?`}
                    content={closeEntityConfirm?.text
                        || `All the elements that sit below it will also be closed. Please make sure that you have first moved any content that should stay open.`}
                    confirmButtonText="Yes"
                    handleConfirm={this.closureConfirmed}
                    handleCancel={this.closureCancelled}
                />
            </Panel>
        );
    }

    //#region Form initialisation

    public componentDidMount(): void {
        this.loadForm();
    }

    private loadForm = async (): Promise<void> => {
        this.setState({ Loading: true });
        try {
            if (this.props.entityId) {
                const entity = await this.loadEntity(this.props.entityId);
                if (this.props.onAfterLoad) this.props.onAfterLoad(entity);
            }
        } catch (err) {
            this.setState({ Error: `Error loading form: ${err.message}` });
        } finally {
            this.setState({ Loading: false });
        }
    }

    private loadEntity = async (id: number): Promise<E> => {
        try {
            const entity = await this.props.loadEntity(id);
            this.setState({ FormIsDirty: false, FormData: { ...entity }, FormDataBeforeChanges: { ...entity } });
            return entity;
        } catch (err) {
            this.setState({ Error: `Error loading form data: ${err.message}` });
        }
    }

    //#endregion

    //#region Form change handlers

    private entityFormChangeHandlers: IEntityFormChangeHandlers<E> = {
        clearField: (f, callback) => {
            this.setState(s => ({ FormData: { ...s.FormData, [f]: null }, FormIsDirty: true }), () => callback?.(this.state.FormData));
        },
        changeTextField: (value, f, callback): void => {
            this.setState(s => ({ FormData: { ...s.FormData, [f]: value }, FormIsDirty: true }), () => callback?.(this.state.FormData));
        },
        changeNumberField: (value, f, callback): void => {
            this.setState(s => ({ FormData: { ...s.FormData, [f]: value }, FormIsDirty: true }), () => callback?.(this.state.FormData));
        },
        changeDatePicker: (date, f, callback): void => {
            this.setState(s => ({ FormData: { ...s.FormData, [f]: date && DateService.setLocaleDateToUTC(date) }, FormIsDirty: true }), () => callback?.(this.state.FormData));
        },
        changeDropdown: (option, f, _, callback): void => {
            this.setState(s => ({ FormData: { ...s.FormData, [f]: option.key }, FormIsDirty: true }), () => callback?.(this.state.FormData));
        },
        changeComboBox: (option, f, _, callback): void => {
            this.setState(s => ({ FormData: { ...s.FormData, [f]: option.key }, FormIsDirty: true }), () => callback?.(this.state.FormData));
        },
        changeChoiceGroup: (option, f, callback): void => {
            this.setState(s => ({ FormData: { ...s.FormData, [f]: Number(option.key) || option.key }, FormIsDirty: true }), () => callback?.(this.state.FormData));
        },
        changeCheckbox: (value, f, callback): void => {
            this.setState(s => ({ FormData: { ...s.FormData, [f]: value }, FormIsDirty: true }), () => callback?.(this.state.FormData));
        },
        changeUserPicker: (value, f, callback): void => {
            this.setState(s => ({ FormData: { ...s.FormData, [f]: value.length === 1 ? value[0] : null }, FormIsDirty: true }), () => callback?.(this.state.FormData));
        },
        changeEntityPicker: (value: number[], f: string, newEntity: IEntity, entityIdProperty: string, callback): void => {
            this.setState(s => {
                const loadedEntities = { ...s.FormDataBeforeChanges };
                const newEntities = [];
                value.forEach((entityId) => {
                    const existingEntity = loadedEntities[f] ? loadedEntities[f].map(entity => entity[entityIdProperty]).indexOf(entityId) : -1;
                    if (existingEntity !== -1) {
                        newEntities.push(loadedEntities[f][existingEntity]);
                    } else {
                        const newEnt = { ...newEntity };
                        newEnt[entityIdProperty] = entityId;
                        newEntities.push(newEnt);
                    }
                });
                return { FormData: { ...s.FormData, [f]: newEntities }, FormIsDirty: true };
            }, () => callback?.(this.state.FormData));
        },
        changeMultiUserPicker: (value: number[], f: string, newEntity: IEntity, userIdProperty: string, callback): void => {
            this.setState(s => {
                const loadedUsers = { ...s.FormDataBeforeChanges };
                const newUsers = [];
                value.forEach((userId) => {
                    const existingUser = loadedUsers[f] ? loadedUsers[f].map(user => user[userIdProperty]).indexOf(userId) : -1;
                    if (existingUser !== -1)
                        newUsers.push(loadedUsers[f][existingUser]);
                    else {
                        const newUser = { ...newEntity };
                        newUser[userIdProperty] = userId;
                        newUsers.push(newUser);
                    }
                });
                return { FormData: { ...s.FormData, [f]: newUsers }, FormIsDirty: true };
            }, () => callback?.(this.state.FormData));
        },
        changeMultiUserPickerROC: (value: number[], f: string, newEntity: IEntity, userIdProperty: string, callback): void => {
            this.setState(s => {
                const allPreviousUsers = { ...s.FormData }[f];
                const loadedUsers = allPreviousUsers.filter((a: IContributor) => a['IsReadOnly']);
                const newUsers = [];
                value.forEach((userId) => {
                    const existingUser = loadedUsers ? loadedUsers.map(user => user[userIdProperty]).indexOf(userId) : -1;
                    if (existingUser !== -1)
                        newUsers.push(loadedUsers[existingUser]);
                    else {
                        const newUser = { ...newEntity };
                        newUser[userIdProperty] = userId;
                        newUser['IsReadOnly'] = true;
                        newUsers.push(newUser);
                    }
                });
                const otherUsers = allPreviousUsers.filter((a: IContributor) => !a['IsReadOnly']);
                const allContributors = [...newUsers, ...otherUsers];
                return { ReadOnlyContributors: newUsers, FormData: { ...s.FormData, [f]: allContributors }, FormIsDirty: true };
            }, () => callback?.(this.state.FormData));
        },
        changeMultiUserPickerC: (value: number[], f: string, newEntity: IEntity, userIdProperty: string, callback): void => {
            this.setState(s => {
                const allPreviousUsers = { ...s.FormData }[f];
                const loadedUsers = allPreviousUsers.filter((a: IContributor) => !a['IsReadOnly']);
                const newUsers = [];
                value.forEach((userId) => {
                    const existingUser = loadedUsers ? loadedUsers.map(user => user[userIdProperty]).indexOf(userId) : -1;
                    if (existingUser !== -1)
                        newUsers.push(loadedUsers[existingUser]);
                    else {
                        const newUser = { ...newEntity };
                        newUser[userIdProperty] = userId;
                        newUsers.push(newUser);
                    }
                });
                const otherUsers = allPreviousUsers.filter((a: IContributor) => a['IsReadOnly']);
                const allContributors = [...newUsers, ...otherUsers];
                return { NormalContributors: newUsers, FormData: { ...s.FormData, [f]: allContributors }, FormIsDirty: true };
            }, () => callback?.(this.state.FormData));
        },
        changeMultiDropdown: (item: IDropdownOption, f: string, newEntity: IEntity, optionIdProperty: string, callback): void => {
            this.setState(s => {
                const loadedChoices = [...s.FormDataBeforeChanges[f]];
                const editedChoices = [...s.FormData[f]];
                if (item.selected) {
                    const indexOfExisting = loadedChoices ? loadedChoices.map(choice => choice[optionIdProperty]).indexOf(item.key) : -1;
                    if (indexOfExisting !== -1) {
                        editedChoices.push({ ...loadedChoices[indexOfExisting] });
                    } else {
                        const newChoice = { ...newEntity };
                        newChoice[optionIdProperty] = item.key;
                        editedChoices.push(newChoice);
                    }
                } else {
                    const indexToRemove = editedChoices.map(choice => choice[optionIdProperty]).indexOf(item.key);
                    editedChoices.splice(indexToRemove, 1);
                }
                return { FormData: { ...s.FormData, [f]: editedChoices }, FormIsDirty: true };
            }, () => callback?.(this.state.FormData));
        },
        changeMultiDropdownStringArray: (item: IDropdownOption, f: string, callback): void => {
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
        changeMultiDropdownWithText: (value: ICrMultiDropdownWithTextValue[], f: string, newEntity: IEntity, optionIdProperty: string, textValueProperty: string, callback): void => {
            this.setState(s => {
                const formValues = { ...s.FormData };
                const newChoices = [];
                value.forEach((val) => {
                    const existingValue = formValues[f] ? formValues[f].map(v => v[optionIdProperty]).indexOf(val.Key) : -1;
                    if (existingValue !== -1) {
                        const editChoice = { ...formValues[f][existingValue] };
                        editChoice[textValueProperty] = val.Text;
                        newChoices.push(editChoice);
                    }
                    else {
                        const newChoice = { ...newEntity };
                        newChoice[optionIdProperty] = val.Key;
                        newChoice[textValueProperty] = val.Text;
                        newChoices.push(newChoice);
                    }
                });
                return { FormData: { ...s.FormData, [f]: newChoices }, FormIsDirty: true };
            }, () => callback?.(this.state.FormData));
        },
        changeStatusDropdown: (option: IDropdownOption, _, __, callback): void => {
            if (option.key === EntityStatus.Closed)
                this.setState({ ShowClosureConfirmation: true });
            else
                this.setState(s => ({ FormData: { ...s.FormData, EntityStatusID: option.key }, FormIsDirty: true }), () => callback?.(this.state.FormData));
        },
        changeReportingCycle: ({ frequency, dueDay, startDate }: IReportingCycle): void => {
            this.setState(s => ({ FormData: { ...s.FormData, ReportingFrequency: frequency, ReportingDueDay: dueDay, ReportingStartDate: startDate && DateService.setLocaleDateToUTC(startDate) }, FormIsDirty: true }));
        },
        changeCycle: ({ frequency, dueDay, startDate }: IReportingCycle, { frequency: freq, dueDay: dd, startDate: sd }: IReportingCycleFields): void => {
            this.setState(s => ({ FormData: { ...s.FormData, [freq]: frequency, [dd]: dueDay, [sd]: startDate && DateService.setLocaleDateToUTC(startDate) }, FormIsDirty: true }));
        },
        changeJson: (value, f, callback?): void => {
            this.setState(s => ({ FormData: { ...s.FormData, [f]: value }, FormIsDirty: true }), () => callback?.(this.state.FormData));
        }
    };

    private closureConfirmed = (): void => {
        this.setState(state => ({
            ShowClosureConfirmation: false,
            ClosureConfirmed: true,
            FormData: { ...state.FormData, EntityStatusID: EntityStatus.Closed },
            FormIsDirty: true
        }));
    }

    private closureCancelled = (): void => {
        this.setState({ ShowClosureConfirmation: false });
    }

    //#endregion

    //#region Validations

    private validateEntity = (entity: IEntity): Promise<IEntityValidations> => {
        const errors = new EntityValidations();

        if (entity.Title === null || entity.Title === '') {
            errors.Title = 'Name is required';
            errors.Valid = false;
        }
        else
            errors.Title = null;

        return Promise.resolve(errors);
    }

    //#endregion

    //#region Form operations

    private saveEntity = async (): Promise<void> => {
        let validations: IEntityValidations;
        if (this.props.onValidateEntity) {
            validations = await this.props.onValidateEntity(this.state.FormData);
        } else {
            validations = await this.validateEntity(this.state.FormData);
        }
        this.setState({ ValidationErrors: validations as V });
        if (validations.Valid) {
            this.setState({ Error: null, FormSaveStatus: SaveStatus.Pending });
            const d = { ...this.state.FormData as E };
            // Delete array (children) and object (parent) properties, these will be saved separately
            Object.keys(d).forEach(key => {
                if (!this.props.includePropertiesOnSave || this.props.includePropertiesOnSave.indexOf(key) === -1) {
                    if (Array.isArray(d[key]) || (d[key] !== null && d[key].constructor.name === 'Object')) {
                        delete d[key];
                        delete d[`${key}@odata.type`];
                    }
                }
            });
            if (this.props.parentEntities) this.props.parentEntities.forEach(p => delete d[p]); // Probably obsolete now that all array and object properties are deleted
            if (this.props.childEntities) this.props.childEntities.forEach(c => delete d[c.ObjectParentProperty]); // Ditto
            if (this.props.onBeforeSave) this.props.onBeforeSave(d);
            if (d.ID === 0) {
                try {
                    const e = await this.props.onCreate(d);
                    await this.saveChildEntitiesAfterCreate(e);
                    if (this.props.onAfterCreate) this.props.onAfterCreate(e);
                    this.props.onSaved();
                } catch (err) {
                    this.setState({ FormSaveStatus: SaveStatus.Error, Error: `Error creating item${err?.message ? `: ${err.message}` : ``}` });
                }
            }
            else {
                try {
                    await this.props.onUpdate(d);
                    await this.saveChildEntitiesAfterUpdate();
                    if (this.props.onAfterUpdate) this.props.onAfterUpdate();
                    this.props.onSaved();
                } catch (err) {
                    this.setState({ FormSaveStatus: SaveStatus.Error, Error: `Error updating item${err?.message ? `: ${err.message}` : ``}` });
                }
            }
        }
    }

    private saveChildEntitiesAfterCreate = (parentEntity: E): Promise<unknown> => {
        if (this.props.childEntities) {
            const promises = [];
            this.props.childEntities.forEach((ce) => {
                this.state.FormData[ce.ObjectParentProperty].forEach((c) => {
                    c[ce.ParentIdProperty] = parentEntity.ID;
                    if (c.ID === 0)
                        promises.push(ce.ChildService.create(c));
                });
            });
            return Promise.all(promises);
        }
        return Promise.resolve();
    }

    private saveChildEntitiesAfterUpdate = (): Promise<unknown> => {
        if (this.props.childEntities) {
            const promises = [];
            this.props.childEntities.forEach(ce => {

                this.state.FormData[ce.ObjectParentProperty]
                    ?.filter((e, index, arr) => arr.findIndex(i => i[ce.ChildIdProperty] == e[ce.ChildIdProperty] &&
                        (ce.ObjectParentProperty != 'Contributors' || i['IsReadOnly'] == i['IsReadOnly'])) == index)
                    ?.forEach((c) => {
                        if (c.ID === 0) {
                            c[ce.ParentIdProperty] = this.state.FormData.ID;
                            promises.push(ce.ChildService.create(c));
                        } else {
                            const loadedObject = this.state.FormDataBeforeChanges[ce.ObjectParentProperty].filter(o => o.ID === c.ID);
                            if (loadedObject && JSON.stringify(loadedObject[0]) !== JSON.stringify(c))
                                promises.push(ce.ChildService.update(c.ID, c));
                        }
                    });

                this.state.FormDataBeforeChanges[ce.ObjectParentProperty]
                    ?.filter((e, index, arr) => arr.findIndex(i => i[ce.ChildIdProperty] == e[ce.ChildIdProperty] &&
                        (ce.ObjectParentProperty != 'Contributors' || i['IsReadOnly'] == i['IsReadOnly'])) == index)
                    ?.forEach((c) => {
                        const newCount = this.state.FormData[ce.ObjectParentProperty].filter(con => ce.ObjectParentProperty != 'Contributors' || con['IsReadOnly'] == c['IsReadOnly']).map((i) => i[ce.ChildIdProperty]).filter(cont => cont == c[ce.ChildIdProperty]).length;
                        const oldCount = this.state.FormDataBeforeChanges[ce.ObjectParentProperty].filter(con => ce.ObjectParentProperty != 'Contributors' || con['IsReadOnly'] == c['IsReadOnly']).map((i) => i[ce.ChildIdProperty]).filter(cont => cont == c[ce.ChildIdProperty]).length;

                        if (newCount > 0 && oldCount > 1 && newCount < oldCount) {
                            this.state.FormDataBeforeChanges[ce.ObjectParentProperty]
                                ?.filter(con => con[ce.ChildIdProperty] == c[ce.ChildIdProperty] && (ce.ObjectParentProperty != 'Contributors' || con['IsReadOnly'] == c['IsReadOnly']))
                                .slice(0, (oldCount - 1))
                                .forEach((cee) => {
                                    promises.push(ce.ChildService.delete(cee.ID));
                                });
                        }
                    });

                this.state.FormDataBeforeChanges[ce.ObjectParentProperty]?.forEach((c) => {
                    if (this.state.FormData[ce.ObjectParentProperty]?.filter(con => ce.ObjectParentProperty != 'Contributors' || con['IsReadOnly'] == c['IsReadOnly']).map(i => i[ce.ChildIdProperty]).indexOf(c[ce.ChildIdProperty]) === -1)
                        promises.push(ce.ChildService.delete(c.ID));
                });

            });
            return Promise.all(promises);
        }
        return Promise.resolve();
    }

    //#endregion
}
