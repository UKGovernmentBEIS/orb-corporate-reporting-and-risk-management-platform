import { IEntityChildren } from "./EntityChildren";

export interface IEntityListState<T> {
    SelectedEntity: number;
    SelectedEntityChildren: IEntityChildren[];
    ShowForm: boolean;
    Entities: { Timestamp: number, Items: T[] };
    HideDeleteDialog: boolean;
    HideDeleteDisallowed: boolean;
    EnableEdit?: boolean;
    EnableDelete?: boolean;
    EnableAddChild?: boolean;
    ListFilterText?: string;
    LoadingListData: boolean;
    LoadingDeleteCheck: boolean;
    ShowChildForm: boolean;
    ShowClosedEntities: boolean;
}

export class EntityListState<T> implements IEntityListState<T> {
    public SelectedEntity = null;
    public SelectedEntityChildren = [];
    public ShowForm = false;
    public Entities = { Timestamp: null, Items: [] };
    public HideDeleteDialog = true;
    public HideDeleteDisallowed = true;
    public EnableEdit = false;
    public EnableDelete = false;
    public EnableAddChild = false;
    public ListFilterText = null;
    public LoadingListData = false;
    public LoadingDeleteCheck = false;
    public ShowChildForm = false;
    public ShowClosedEntities = false;
}
