import { SaveStatus } from "./SaveStatus";
import { IContributor } from "./Contributor";
import { ILookupData, LookupData } from "./LookupData";

export interface IEntityFormState<T, V> {
    FormData: T;
    FormIsDirty: boolean;
    FormSaveStatus: SaveStatus;
    LookupData: ILookupData;
    ValidationErrors: V;
    FormDataBeforeChanges: T;
    Loading: boolean;
    ShowClosureConfirmation: boolean;
    ClosureConfirmed: boolean;
    NormalContributors?: IContributor[];
    ReadOnlyContributors?: IContributor[];
    Error?: string;
}

export class EntityFormState<T, V> implements IEntityFormState<T, V>{
    public FormData: T;
    public FormIsDirty = false;
    public FormSaveStatus = SaveStatus.None;
    public LookupData = new LookupData();
    public ValidationErrors: V;
    public FormDataBeforeChanges: T;
    public Loading = false;
    public ShowClosureConfirmation = false;
    public ClosureConfirmed = false;
    public NormalContributors = [];
    public ReadOnlyContributors = [];
    public Error = null;

    constructor(formData: T, validationErrors?: V, defaultValues?: { field: string, value: string | number | Date | [] }[]) {
        this.FormData = formData;
        this.ValidationErrors = validationErrors;
        this.FormDataBeforeChanges = formData;

        if (defaultValues) {
            defaultValues.forEach(dv => {
                this.FormData[dv.field] = dv.value;
            });
        }
    }
}

export interface IEntityFormValidations {
    Valid: boolean;
    Title: string;
}

export class EntityFormValidations implements IEntityFormValidations {
    public Valid = true;
    public Title = null;
}
