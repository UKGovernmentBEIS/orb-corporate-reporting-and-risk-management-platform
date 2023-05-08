import React from 'react';
import { IEntity, IEntityListState, EntityListState, IEntityChildren, IBaseComponentProps } from '../types';
import styles from '../styles/cr.module.scss';
import { FilteredList } from './cr/FilteredList';
import { ConfirmDialog } from './cr/ConfirmDialog';
import { ListCommandBar } from './cr/ListCommandBar';
import { MessageDialog } from './cr/MessageDialog';
import { CrLoadingOverlay } from './cr/CrLoadingOverlay';
import { Toggle } from 'office-ui-fabric-react/lib/Toggle';
import { DateService } from '../services';
import { IColumn, IObjectWithKey, Selection } from 'office-ui-fabric-react/lib/DetailsList';
import { IUseApiProps } from './useApi';
import { IWithErrorHandlingProps } from './withErrorHandling';

export interface IEntityListProps<T extends IEntity> extends IBaseComponentProps, IWithErrorHandlingProps, IUseApiProps {
    entity: string;
    entityName: { Plural: string, Singular: string };
    addChild?: { Name: string };
    enableShowHideClosedEntities?: boolean;
    columns: IColumn[];
    loadListItems: (showClosedEntities: boolean) => Promise<T[]>;
    mapEntitiesToListItems: (entities: T[]) => IObjectWithKey[];
    entityForm: (showForm: boolean, entityId: number, onSaved: () => void, onCancelled: () => void) => React.ReactElement;
    childEntityForm?: (showForm: boolean, parentEntityId: number, onSaved: () => void, onCancelled: () => void) => React.ReactElement;
    onCheckDelete: (entityId: number) => Promise<IEntityChildren[]>;
    onDelete: (entityId: number) => Promise<void>;
    onChange?: () => void;
    disableAdd?: boolean;
    disableDelete?: (entity: T) => boolean;
    addMultiple?: boolean;
}

export class EntityList<T extends IEntity> extends React.Component<IEntityListProps<T>, IEntityListState<T>> {
    private _selection: Selection;

    constructor(props: IEntityListProps<T>) {
        super(props);
        this.state = new EntityListState<T>();
        this._selection = new Selection({
            onSelectionChanged: () => {
                if (this._selection.getSelectedCount() === 1) {
                    const key = Number(this._selection.getSelection()[0].key);
                    this.setState({ SelectedEntity: key, EnableEdit: true, EnableDelete: true, EnableAddChild: true });
                } else {
                    this.setState({ SelectedEntity: null, EnableEdit: false, EnableDelete: false, EnableAddChild: false });
                }
            }
        });
    }

    public render(): React.ReactElement<IEntityListProps<T>> {
        const {
            enableShowHideClosedEntities,
            entityName,
            addChild,
            columns,
            mapEntitiesToListItems,
            entityForm,
            childEntityForm,
            disableAdd,
            disableDelete,
            addMultiple } = this.props;
        const {
            LoadingListData,
            LoadingDeleteCheck,
            ShowClosedEntities,
            HideDeleteDialog,
            HideDeleteDisallowed,
            EnableEdit,
            EnableDelete,
            EnableAddChild,
            Entities,
            ListFilterText,
            ShowForm,
            ShowChildForm,
            SelectedEntity,
            SelectedEntityChildren } = this.state;
        const numChildren = this.totalChildren(SelectedEntityChildren);
        const addMultipleItems = addMultiple ? { onAddMultiple: this.addEntity } : {};

        return (
            <div className={`${styles.cr} ${this.props.isFullPage ? styles.crFullPage : ''}`}>
                <CrLoadingOverlay isLoading={LoadingDeleteCheck} opaque={false} />
                <ListCommandBar
                    onAdd={this.addEntity}
                    {...addMultipleItems}
                    onEdit={this.editEntity}
                    onDelete={this.checkDelete}
                    onFilterChange={this.onFilterChange}
                    addDisabled={disableAdd || false}
                    editDisabled={!EnableEdit}
                    deleteDisabled={!EnableDelete || disableDelete?.(Entities?.Items?.find(i => i.ID === SelectedEntity))}
                    addChildDisabled={!EnableAddChild}
                    onAddChild={this.addEntityChild}
                    addChildName={addChild?.Name} />
                <div style={{ display: 'flex' }}>
                    <h2 style={{ flexGrow: 1 }} className={styles.listTitle}>{entityName.Plural}</h2>
                    {enableShowHideClosedEntities &&
                        <div style={{ paddingTop: '8px' }}>
                            <Toggle
                                onText={`Show closed ${entityName.Plural?.toLocaleLowerCase()}?`}
                                offText={`Show closed ${entityName.Plural?.toLocaleLowerCase()}?`}
                                checked={ShowClosedEntities}
                                onChange={this.onClosedToggleChange}
                            />
                        </div>
                    }
                </div>
                <div data-is-scrollable={this.props.isFullPage ? 'true' : 'false'} className={styles.crFullPageList} style={{ position: 'relative' }}>
                    <CrLoadingOverlay isLoading={LoadingListData} opaque={true} />
                    <FilteredList
                        columns={columns}
                        items={{ Timestamp: Entities.Timestamp, Items: mapEntitiesToListItems(Entities.Items) }}
                        selection={this._selection}
                        filterText={ListFilterText}
                    />
                </div>
                {ShowForm && entityForm(ShowForm, SelectedEntity, this.entitySaved, this.closePanel)}
                {ShowChildForm && childEntityForm && childEntityForm(ShowChildForm, SelectedEntity, this.childEntitySaved, this.closeChildPanel)}
                <MessageDialog
                    hidden={HideDeleteDisallowed}
                    title={`${entityName.Singular} cannot be deleted`}
                    handleOk={this.toggleDeleteDisallowed}>
                    {this.anyChildrenUnadoptable(SelectedEntityChildren)
                        ?
                        <>
                            <p>{entityName.Singular} &apos;{this.getSelectedEntityName()}&apos; has items of the following types belonging to it that cannot be moved or deleted.</p>
                            <p>{SelectedEntityChildren.filter(c => !c.CanBeAdopted).map(c => c.ChildType).join(', ')}</p>
                        </>
                        :
                        <>
                            <p>{entityName.Singular} &apos;{this.getSelectedEntityName()}&apos; has {this.anyChildrenMax(SelectedEntityChildren)
                                ? `${numChildren} or more items` : numChildren > 1 ? `${numChildren} items` : `1 item`} belonging to it:</p>
                            {SelectedEntityChildren.filter(c => c.ChildIDs.length > 0).map(c => <p key={c.ChildType}>{`${c.ChildType} (IDs) - ${c.ChildIDs.join(', ')}`}</p>)}
                            <p>{numChildren > 1 ? 'These' : 'This'} must be deleted or moved from this {entityName.Singular} before it can be deleted.</p>
                        </>
                    }
                </MessageDialog>
                <ConfirmDialog
                    hidden={HideDeleteDialog}
                    title={`Are you sure you want to delete ${this.getSelectedEntityName() || `this ${entityName.Singular.toLowerCase()}`}?`}
                    content={`Deleting a ${entityName.Singular.toLowerCase()} cannot be undone.`}
                    confirmButtonText="Delete"
                    handleConfirm={this.deleteEntity}
                    handleCancel={this.toggleDeleteConfirm}
                />
            </div>
        );
    }

    //#region Form initialisation

    public componentDidMount(): void {
        if (this.props.apiConnected) {
            this.loadEntities();
        }
    }

    public componentDidUpdate(prevProps: IEntityListProps<T>): void {
        if (prevProps.apiConnected !== this.props.apiConnected || prevProps.entity !== this.props.entity) {
            this.loadEntities();
        }
    }

    private loadEntities = async (): Promise<void> => {
        const { entityName, loadListItems } = this.props;
        this.setState({ LoadingListData: true });
        try {
            const items = await loadListItems(this.state.ShowClosedEntities);
            if (items && items.length > 0) {
                this.setState({ Entities: { Timestamp: DateService.timestamp(), Items: items } });
            }
        }
        catch (err) {
            this.props.errorHandling?.onError(`Error loading ${entityName.Plural || 'items'} `, err.message);
        } finally {
            this.setState({ LoadingListData: false });
        }
    }

    //#endregion

    //#region Form infrastructure

    private getSelectedEntityName = (): string => {
        const entity = this.state.Entities.Items.find(e => e.ID === this.state.SelectedEntity);
        return entity ? entity.Title : null;
    }

    private addEntity = (): void => {
        if (this.state.SelectedEntity) {
            this._selection.setKeySelected(this.state.SelectedEntity.toString(), false, false);
        }
        this.setState({ SelectedEntity: null, ShowForm: true });
    }

    private editEntity = (): void => {
        this.setState({ ShowForm: true });
    }

    private deleteEntity = async (): Promise<void> => {
        const { onDelete } = this.props;
        const { SelectedEntity } = this.state;
        this.props.errorHandling?.clearErrors();
        this.setState({ HideDeleteDialog: true });
        if (SelectedEntity) {
            try {
                await onDelete(SelectedEntity);
                this.loadEntities();
            } catch (err) {
                this.props.errorHandling?.onError(`Error deleting item ${SelectedEntity} `, err.message);
            }
        }
    }

    private addEntityChild = (): void => {
        if (this.state.SelectedEntity) {
            this.setState({ ShowChildForm: true });
        }
    }

    private entitySaved = (): void => {
        this.loadEntities();
        if (this.props.onChange) this.props.onChange();
        this.closePanel();
    }

    private childEntitySaved = (): void => {
        this.loadEntities();
        this.closeChildPanel();
    }

    private closePanel = (): void => {
        this.setState({ ShowForm: false });
    }

    private closeChildPanel = (): void => {
        this.setState({ ShowChildForm: false });
    }

    private toggleDeleteConfirm = (): void => {
        this.setState({ HideDeleteDialog: !this.state.HideDeleteDialog });
    }

    private toggleDeleteDisallowed = (): void => {
        this.setState({ HideDeleteDisallowed: !this.state.HideDeleteDisallowed });
    }

    private checkDelete = async (): Promise<void> => {
        this.setState({ LoadingDeleteCheck: true });
        try {
            const children = await this.props.onCheckDelete(this.state.SelectedEntity);
            if (this.totalChildren(children) > 0) {
                this.setState({ SelectedEntityChildren: children }, this.toggleDeleteDisallowed);
            }
            else {
                this.toggleDeleteConfirm();
            }
        } catch (err) {
            this.props.errorHandling?.onError(`Error checking if item can be deleted.`, err.message);
        } finally {
            this.setState({ LoadingDeleteCheck: false });
        }
    }

    private totalChildren = (children: IEntityChildren[]): number => {
        return children.map(c => c.ChildIDs.length).reduce((total, numberOfChildType) => total + numberOfChildType, 0);
    }

    private anyChildrenUnadoptable = (children: IEntityChildren[]): boolean => {
        return children.some(c => !c.CanBeAdopted && c.ChildIDs.length > 0);
    }

    private anyChildrenMax = (children: IEntityChildren[]): boolean => {
        return children.some(c => c.ChildIDs.length === 10);
    }

    private onFilterChange = (value: string): void => {
        this.setState({ ListFilterText: value });
    }

    private onClosedToggleChange = (_, checked: boolean): void => {
        this.setState({ ShowClosedEntities: checked }, this.loadEntities);
    }

    //#endregion
}
