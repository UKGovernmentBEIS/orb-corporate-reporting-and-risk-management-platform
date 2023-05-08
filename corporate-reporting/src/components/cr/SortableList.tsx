import React from 'react';
import { DetailsList, SelectionMode, IColumn, ISelection, IObjectWithKey, IDetailsListProps } from 'office-ui-fabric-react/lib/DetailsList';
import { ArrayService } from '../../services/ArrayService';

export interface ISortableListProps extends IDetailsListProps {
    className?: string;
    columns: IColumn[];
    items: IObjectWithKey[];
    selectionMode?: SelectionMode;
    selection?: ISelection;
}

export interface ISortableListState {
    Columns: IColumn[];
    Items: IObjectWithKey[];
}

export class SortableList extends React.Component<ISortableListProps, ISortableListState> {

    constructor(props: ISortableListProps) {
        super(props);
        this.state = { Columns: [], Items: [] };
    }

    public render(): React.ReactElement {
        const { props, state } = this;
        return (
            <DetailsList
                {...props}
                className={props.className}
                selectionMode={props.selectionMode != null ? props.selectionMode : SelectionMode.single}
                selection={props.selection}
                setKey={"state.SortableItems"}
                columns={state.Columns}
                items={state.Items}
            />
        );
    }

    //#region Form initialisation

    public componentDidMount(): void {
        this.setColumns(this.props.columns);
        this.setState({ Items: this.cloneArray(this.props.items) });
    }

    public componentDidUpdate(prevProps: ISortableListProps): void {
        if (JSON.stringify(prevProps.items) !== JSON.stringify(this.props.items)) {
            this.setState({ Items: this.cloneArray(this.props.items) });
        }
        if (JSON.stringify(prevProps.columns) !== JSON.stringify(this.props.columns)) {
            this.setColumns(this.props.columns);
        }
    }

    private setColumns = (cols: IColumn[]) => {
        const _cols = cols.map(c => ({ ...c }));
        _cols.forEach(c => c.onColumnClick = this._onColumnClick);
        this.setState({ Columns: _cols });
    }

    private cloneArray = (arr: IObjectWithKey[]) => arr.map(a => ({ ...a }));

    //#endregion

    //#region Form infrastructure

    private _onColumnClick = (_, column: IColumn): void => {
        const { Columns, Items } = this.state;
        let newItems: IObjectWithKey[] = this.cloneArray(Items);
        const newColumns: IColumn[] = Columns.map(c => ({ ...c }));
        const currColumn: IColumn = newColumns.find(currCol => column.key === currCol.key);
        newColumns.forEach(newCol => {
            if (newCol === currColumn) {
                currColumn.isSortedDescending = !currColumn.isSortedDescending;
                currColumn.isSorted = true;
            } else {
                newCol.isSorted = false;
                newCol.isSortedDescending = true;
            }
        });
        newItems = ArrayService.sortObjectArray(newItems, currColumn.fieldName || '', currColumn.isSortedDescending);
        this.setColumns(newColumns);
        this.setState({ Items: newItems });
    }

    //#endregion
}
