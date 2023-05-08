import React from 'react';
import { DetailsList, Selection, IDetailsListProps, IDragDropEvents, IObjectWithKey } from 'office-ui-fabric-react/lib/DetailsList';
import styles from '../../styles/cr.module.scss';

export interface ICrListProps extends IDetailsListProps {
    getItemId: (item: unknown) => number | string;
    onSelectedIdChange: (itemId: number | string) => void;
    onOrderChange: (items: unknown[]) => void;
}

// https://developer.microsoft.com/en-us/fluentui#/controls/web/detailslist/draganddrop

export class CrList extends React.Component<ICrListProps> {
    private _selection: Selection;
    private _dragDropEvents: IDragDropEvents;
    private _draggedItem: IObjectWithKey | undefined;
    private _draggedIndex: number;

    constructor(props: ICrListProps) {
        super(props);

        this._selection = new Selection({
            onSelectionChanged: () => {
                props.onSelectedIdChange?.(this._selection.getSelectedCount() === 1 ? this.props.getItemId(this._selection.getSelection()[0]) : null);
            }
        });
        this._dragDropEvents = this._getDragDropEvents();
        this._draggedIndex = -1;
    }

    public render(): React.ReactElement {
        return (
            <DetailsList
                {...this.props}
                setKey="set"
                selection={this._selection}
                dragDropEvents={this._dragDropEvents}
            />
        );
    }

    private _getDragDropEvents(): IDragDropEvents {
        return {
            canDrop: () => {
                return true;
            },
            canDrag: () => {
                return true;
            },
            onDragEnter: () => {
                // return string is the css classes that will be added to the entering element.
                return styles.bgColorNeutralLight;
            },
            onDragLeave: () => {
                return;
            },
            onDrop: (item?: IObjectWithKey) => {
                if (this._draggedItem) {
                    this._insertBeforeItem(item);
                }
            },
            onDragStart: (item?: IObjectWithKey, itemIndex?: number) => {
                this._draggedItem = item;
                this._draggedIndex = itemIndex!; // eslint-disable-line @typescript-eslint/no-non-null-assertion
            },
            onDragEnd: () => {
                this._draggedItem = undefined;
                this._draggedIndex = -1;
            }
        };
    }

    private _insertBeforeItem(item: IObjectWithKey): void {
        const draggedItems = this._selection.isIndexSelected(this._draggedIndex)
            ? (this._selection.getSelection() as IObjectWithKey[])
            : [this._draggedItem!]; // eslint-disable-line @typescript-eslint/no-non-null-assertion

        const items = this.props.items.filter(itm => draggedItems.indexOf(itm) === -1);
        let insertIndex = items.indexOf(item);

        // if dragging/dropping on itself, index will be 0.
        if (insertIndex === -1) {
            insertIndex = 0;
        }

        items.splice(insertIndex, 0, ...draggedItems);

        this.props.onOrderChange?.(items);
    }
}