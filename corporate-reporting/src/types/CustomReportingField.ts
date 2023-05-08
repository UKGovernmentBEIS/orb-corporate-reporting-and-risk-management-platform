import { ChoiceFieldTypes, FieldTypes } from "../refData/FieldTypes";

export interface IReportingField {
    FieldName: string;
    Title: string;
    Description: string;
    Type: FieldTypes;
    Required?: boolean;
    MaxLength?: number;
    LookupList?: number;
    Min?: number;
    Max?: number;
    MultiSelect?: boolean;
    Choices?: string;
    ChoiceControl?: ChoiceFieldTypes;
}

export class ReportingField {
    public FieldName = null;
    public Title = '';
    public Description = '';
    public Type = null;
}