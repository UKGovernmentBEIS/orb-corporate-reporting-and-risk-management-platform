import { SaveStatus } from "./SaveStatus";

export interface ICrFormState<T, V> {
    FormData: T;
    FormIsDirty: boolean;
    FormSaveStatus: SaveStatus;
    ValidationErrors: V;
    FormDataBeforeChanges: T;
    Loading: boolean;
    ShowClosureConfirmation: boolean;
    ClosureConfirmed: boolean;
}

export class CrFormState<T, V> implements ICrFormState<T, V>{
    public FormData: T;
    public FormIsDirty = false;
    public FormSaveStatus = SaveStatus.None;
    public ValidationErrors: V;
    public FormDataBeforeChanges: T;
    public Loading = false;
    public ShowClosureConfirmation = false;
    public ClosureConfirmed = false;

    constructor(formData: T, validationErrors?: V, defaultValues?: { field: string, value: string | number | Date | [] }[]) {
        this.FormData = formData;
        this.ValidationErrors = validationErrors;
        this.FormDataBeforeChanges = formData;

        if (defaultValues)
            defaultValues.forEach(dv => {
                this.FormData[dv.field] = dv.value;
            });
    }
}

export interface ICrFormValidations {
    Valid: boolean;
    Title: string;
}

export class CrFormValidations implements ICrFormValidations {
    public Valid = true;
    public Title = null;
}
