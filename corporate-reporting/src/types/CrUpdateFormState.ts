import { CrFormState, ICrFormState } from "./CrFormState";
import { IEntityRole } from "./EntityRole";

export interface ICrUpdateFormState<T, V, E> extends ICrFormState<T, V> {
    FormData: T;
    ValidationErrors: V;
    ParentEntity: E;
    LastSignedOffUpdate: T;
    ShowForm: boolean;
    HideClearFormDialog: boolean;
    People: IEntityRole[];
    PeopleLoaded: boolean;
    UpdateIsEarly: boolean;
    ShowEarlyWarning: boolean;
    EarlyWarningDismissed: boolean;
}

export class CrUpdateFormState<T, V, E> extends CrFormState<T, V> implements ICrUpdateFormState<T, V, E>{
    public FormData: T;
    public ValidationErrors: V;
    public ParentEntity: E;
    public LastSignedOffUpdate: T;
    public ShowForm = false;
    public HideClearFormDialog = true;
    public People = [];
    public PeopleLoaded = false;
    public UpdateIsEarly = false;
    public ShowEarlyWarning = false;
    public EarlyWarningDismissed = false;

    constructor(formData: T, parentEntity: E, lastSignedOffUpdate: T, validationErrors?: V, defaultShowForm?: boolean) {
        super(formData, validationErrors);

        this.ParentEntity = parentEntity;
        this.LastSignedOffUpdate = lastSignedOffUpdate;
        this.ShowForm = defaultShowForm;
    }
}