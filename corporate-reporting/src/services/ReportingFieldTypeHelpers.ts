import { FieldTypes } from "../refData/FieldTypes";

export const GetFieldTypeName = (fieldTypeId: number): string => {
    switch (fieldTypeId) {
        case FieldTypes.SingleLineOfText: return 'Single line of text';
        case FieldTypes.MultipleLinesOfText: return 'Multiple lines of text';
        case FieldTypes.Number: return 'Number';
        case FieldTypes.Lookup: return 'Lookup';
        case FieldTypes.Person: return 'Person';
        case FieldTypes.Choice: return 'Choice';
        default: return 'Unknown field type';
    }
};

export const GetFieldTypeSelectableOptions = (fieldTypes: FieldTypes[]): { key: string | number, text: string }[] =>
    fieldTypes.map(ft => ({ key: ft, text: GetFieldTypeName(ft) }));