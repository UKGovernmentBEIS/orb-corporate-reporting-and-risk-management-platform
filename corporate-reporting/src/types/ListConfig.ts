export interface IListPlaceholders {
    dataTBC: string;
    dataMissing: string;
}

export interface IColumnWidths {
    date: number;
    editIcon: number;
    rag: number;
    user: number;
}

export interface IListConfig {
    columnWidths: IColumnWidths;
    placeholders: IListPlaceholders;
}
