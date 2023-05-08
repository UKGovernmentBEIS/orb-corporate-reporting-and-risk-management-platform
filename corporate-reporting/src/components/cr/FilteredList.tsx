import React from 'react';
import { DetailsList, SelectionMode, IColumn, ISelection, IObjectWithKey } from 'office-ui-fabric-react/lib/DetailsList';
import { SearchObjectService } from '../../services/SearchObjectService';
import { ArrayService } from '../../services/ArrayService';

export interface IFilteredListProps {
    className?: string;
    columns: IColumn[];
    items: { Timestamp: number, Items: IObjectWithKey[] };
    filterText?: string;
    selectionMode?: SelectionMode;
    selection?: ISelection;
}

export interface IFilteredListState {
    Columns: IColumn[];
    FilteredItems: IObjectWithKey[];
}

export class FilteredList extends React.Component<IFilteredListProps, IFilteredListState> {

    constructor(props: IFilteredListProps) {
        super(props);
        this.state = { Columns: [], FilteredItems: [] };
    }

    public render(): React.ReactElement {
        const { props, state } = this;
        return (
            <DetailsList
                className={props.className}
                selectionMode={props.selectionMode != null ? props.selectionMode : SelectionMode.single}
                selection={props.selection}
                setKey={"state.FilteredItems"}
                columns={state.Columns}
                items={state.FilteredItems}
            />
        );
    }

    //#region Form initialisation

    public componentDidMount(): void {
        this.setColumns(this.props.columns);
        this.setState({ FilteredItems: SearchObjectService.filterEntities(this.props.items.Items.map(i => ({ ...i })), this.props.filterText) });
    }

    public componentDidUpdate(prevProps: IFilteredListProps): void {
        if (prevProps.items.Timestamp !== this.props.items.Timestamp || prevProps.filterText !== this.props.filterText) {
            this.setState({ FilteredItems: SearchObjectService.filterEntities(this.props.items.Items.map(i => ({ ...i })), this.props.filterText) });
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

    //#endregion

    //#region Form infrastructure

    private _onColumnClick = (_, column: IColumn): void => {
        const { Columns, FilteredItems } = this.state;
        let newItems: IObjectWithKey[] = FilteredItems.map(i => ({ ...i }));
        const newColumns: IColumn[] = Columns.map(c => ({ ...c }));
        const currColumn: IColumn = newColumns.filter(currCol => column.key === currCol.key)[0];
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
        this.setState({ FilteredItems: newItems });
    }

    //#endregion
}
