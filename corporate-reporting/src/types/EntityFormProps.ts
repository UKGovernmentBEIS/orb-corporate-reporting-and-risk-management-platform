import { ICrMultiDropdownWithTextValue } from "../components/cr/CrMultiDropdownWithText";
import { IEntityFormState } from "./EntityFormState";
import { IFormDataChildEntities } from "./FormDataRelationships";
import { IDropdownOption } from "office-ui-fabric-react/lib/Dropdown";
import { IComboBoxOption } from "office-ui-fabric-react/lib/ComboBox";
import { IChoiceGroupOption } from "office-ui-fabric-react/lib/ChoiceGroup";
import { IReportingCycle, IReportingCycleFields } from "./ReportingCycle";
import { IEntity } from "./Entity";
import { IBaseComponentProps, IDirectorate } from ".";

export interface IEntityFormChangeHandlers<T> {
    clearField: (fieldName: string, callback?: (entity: T) => void) => void;
    changeTextField: (value: string, fieldName: string, callback?: (entity: T) => void) => void;
    changeNumberField: (value: number, fieldName: string, callback?: (entity: T) => void) => void;
    changeDatePicker: (value: Date, fieldName: string, callback?: (entity: T) => void) => void;
    changeDropdown: (option: IDropdownOption, fieldName: string, index?: number, callback?: (entity: T) => void) => void;
    changeComboBox: (option: IComboBoxOption, fieldName: string, index?: number, callback?: (entity: T) => void) => void;
    changeChoiceGroup: (option: IChoiceGroupOption, f: string, callback?: (entity: T) => void) => void;
    changeCheckbox: (value: boolean, fieldName: string, callback?: (entity: T) => void) => void;
    changeUserPicker: (value: number[], fieldName: string, callback?: (entity: T) => void) => void;
    changeEntityPicker: (value: number[], fieldName: string, newEntity: IEntity, entityIdProperty: string, callback?: (entity: T) => void) => void;
    changeMultiUserPicker: (value: number[], fieldName: string, newEntity: IEntity, userIdProperty: string, callback?: (entity: T) => void) => void;
    changeMultiUserPickerROC: (value: number[], fieldName: string, newEntity: IEntity, userIdProperty: string, callback?: (entity: T) => void) => void;
    changeMultiUserPickerC: (value: number[], fieldName: string, newEntity: IEntity, userIdProperty: string, callback?: (entity: T) => void) => void;
    changeMultiDropdown: (item: IDropdownOption, f: string, newEntity: IEntity, optionIdProperty: string, callback?: (entity: T) => void) => void;
    changeMultiDropdownStringArray: (item: IDropdownOption, f: string, callback?: (entity: T) => void) => void;
    changeMultiDropdownWithText: (value: ICrMultiDropdownWithTextValue[], f: string, newEntity: IEntity, optionIdProperty: string, textValueProperty: string, callback?: (entity: T) => void) => void;
    changeStatusDropdown: (option: IDropdownOption, f: string, index?: number, callback?: (entity: T) => void) => void;
    changeReportingCycle: (reportingCycle: IReportingCycle) => void;
    changeCycle: (cycle: IReportingCycle, cycleFields: IReportingCycleFields) => void;
    changeJson: (value: unknown, fieldName: string, callback?: (entity: T) => void) => void;
}

export interface ICoreFormProps extends IBaseComponentProps {
    onLoading?: (isLoading: boolean) => void;
    showForm?: boolean;
    entityName?: string;
    entityId?: number;
    onSaved?: () => void;
    onCancelled?: () => void;
    defaultValues?: { field: string, value: string | number | Date | [] }[];
}

export interface IEntityFormProps<T, V> extends ICoreFormProps {
    renderFormFields?: (changeHandlers: IEntityFormChangeHandlers<T>, formState: IEntityFormState<T, V>) => React.ReactElement;
    loadEntity: (entityId: number) => Promise<T>;
    loadNewEntity: () => T;
    loadEntityValidations: () => V;
    onAfterLoad?: (entity: T) => void;
    onValidateEntity?: (entity: T) => Promise<V>;
    onBeforeSave?: (entity: T) => void;
    onCreate: (entity: T) => Promise<T>;
    onAfterCreate?: (entity: T) => Promise<T>;
    onUpdate: (entity: T) => Promise<void>;
    onAfterUpdate?: () => Promise<void>;
    parentEntities?: string[];
    childEntities?: IFormDataChildEntities[];
    includePropertiesOnSave?: string[];
    closeEntityConfirm?: { header: string, text: string };
}

export interface ISpecificEntityFormProps extends ICoreFormProps {
    lookupDirectorates?: IDirectorate[];
}
