import React, { useState } from 'react';
import { EntityValidations, IReportingField, ISpecificEntityFormProps } from '../../types';
import styles from '../../styles/cr.module.scss';
import { CrDropdown } from '../cr/CrDropdown';
import { CrTextField } from '../cr/CrTextField';
import { IPanelHeaderRenderer, IPanelProps, Panel, PanelType } from 'office-ui-fabric-react';
import { FormCommandBar } from '../cr/FormCommandBar';
import { FormButtons } from '../cr/FormButtons';
import { ChoiceFieldTypes, FieldTypes } from '../../refData/FieldTypes';
import { TextFieldFormFields } from './TextFieldFormFields';
import { NoteFieldFormFields } from './NoteFieldFormFields';
import { LookupFieldFormFields } from './LookupFieldFormFields';
import { NumberFieldFormFields } from './NumberFieldFormFields';
import { GetFieldTypeSelectableOptions } from '../../services/ReportingFieldTypeHelpers';
import { PersonFieldFormFields } from './PersonFieldFormFields';
import { ChoiceFieldFormFields } from './ChoiceFieldFormFields';
import { FormErrorsList } from '../cr/FormErrorsList';

export class CustomFieldValidations extends EntityValidations {
    public Type: string = null;
    public MaxLength: string = null;
    public LookupList: string = null;
    public Min: string = null;
    public Max: string = null;
    public Choices: string = null;
}

export interface ICustomFieldFormProps extends ISpecificEntityFormProps {
    reportType: number;
    field: IReportingField;
    onDone: (field: IReportingField) => void;
    onCancel: () => void;
}

export const CustomFieldForm = ({ showForm, reportType, field, onDone, onCancel }: ICustomFieldFormProps): React.ReactElement => {
    const [name, setName] = useState(field.Title);
    const [description, setDescription] = useState(field.Description);
    const [type, setType] = useState(field.Type);
    const [maxLength, setMaxLength] = useState(field.MaxLength?.toString() || '255');
    const [isRequired, setIsRequired] = useState(field.Required);
    const [lookupList, setLookupList] = useState(field.LookupList);
    const [min, setMin] = useState(field.Min?.toString() || '');
    const [max, setMax] = useState(field.Max?.toString() || '');
    const [multiSelect, setMultiSelect] = useState(field.MultiSelect);
    const [choices, setChoices] = useState(field.Choices);
    const [choiceControl, setChoiceControl] = useState(field.ChoiceControl);
    const [errors, setErrors] = useState(new CustomFieldValidations());

    const validateEntity = (f: IReportingField): boolean => {
        const e = new CustomFieldValidations();

        if (f.Title === null || f.Title === '') {
            e.Title = 'Name is required';
            e.Valid = false;
        }
        else {
            e.Title = null;
        }

        if (f.Type == null) {
            e.Type = 'Type is required';
            e.Valid = false;
        } else {
            e.Type = null;
        }

        if (f.Type === FieldTypes.SingleLineOfText && isNaN(f.MaxLength)) {
            e.MaxLength = 'Maximum number of characters must be a number';
            e.Valid = false;
        } else if (f.Type === FieldTypes.SingleLineOfText && f.MaxLength < 1 || f.MaxLength > 255) {
            e.MaxLength = 'Maximum number of characters must be between 1 and 255';
            e.Valid = false;
        } else {
            e.MaxLength = null;
        }

        if (f.Type === FieldTypes.Lookup && f.LookupList == null) {
            e.LookupList = 'Lookup list is required';
            e.Valid = false;
        } else {
            e.LookupList = null;
        }

        if (f.Type === FieldTypes.Number && f.Min != null && isNaN(f.Min)) {
            e.Min = 'Minimum allowed value must be a number';
            e.Valid = false;
        } else {
            e.Min = null;
        }

        if (f.Type === FieldTypes.Number && f.Max != null && isNaN(f.Max)) {
            e.Max = 'Maximum allowed value must be a number';
            e.Valid = false;
        } else {
            e.Max = null;
        }

        if (f.Type === FieldTypes.Choice && (f.Choices == null || f.Choices === '')) {
            e.Choices = 'Please enter at least one choice';
            e.Valid = false;
        } else {
            e.Choices = null;
        }

        setErrors(e);
        return e.Valid;
    };

    const onSave = () => {
        const f: IReportingField = {
            FieldName: field.FieldName,
            Title: name,
            Description: description,
            Type: type,
            Required: isRequired,
            MaxLength: maxLength || maxLength === '0' ? Number(maxLength) : null,
            LookupList: lookupList,
            Min: min || min === '0' ? Number(min) : null,
            Max: max || max === '0' ? Number(max) : null,
            MultiSelect: multiSelect,
            Choices: choices,
            ChoiceControl: choiceControl
        };
        if (validateEntity(f)) {
            onDone(f);
        }
    };

    return (
        <Panel
            className={styles.cr}
            isOpen={showForm}
            onDismiss={onCancel}
            headerText="Create a column"
            type={PanelType.smallFixedFar}
            onRenderHeader={(panelProps: IPanelProps, defaultRender: IPanelHeaderRenderer) =>
                <div className={styles.panelHeaderText}>{defaultRender(panelProps)}</div>
            }
            onRenderNavigation={() =>
                <FormCommandBar primaryText="Done" onSave={onSave} onCancel={onCancel} />
            }
        >
            <div>
                <CrTextField
                    label="Name"
                    required={true}
                    maxLength={255}
                    className={styles.formField}
                    value={name}
                    onChange={v => setName(v)}
                    errorMessage={errors.Title}
                />
                <CrTextField
                    label="Description"
                    className={styles.formField}
                    value={description}
                    maxLength={500}
                    onChange={v => setDescription(v)}
                    multiline
                />
                <CrDropdown
                    label="Type"
                    required={true}
                    className={styles.formField}
                    options={GetFieldTypeSelectableOptions([
                        FieldTypes.SingleLineOfText,
                        FieldTypes.MultipleLinesOfText,
                        FieldTypes.Lookup,
                        FieldTypes.Number,
                        FieldTypes.Person,
                        FieldTypes.Choice
                    ])}
                    selectedKey={type}
                    onChange={(_, v) => {
                        setType(v.key as FieldTypes);
                        if (v.key === FieldTypes.Choice) {
                            setChoiceControl(ChoiceFieldTypes.DropDownMenu);
                        }
                    }}
                    errorMessage={errors.Type}
                />
                {type === FieldTypes.SingleLineOfText &&
                    <TextFieldFormFields
                        value={{ maxLength: maxLength, isRequired: isRequired }}
                        onChange={v => { setMaxLength(v.maxLength); setIsRequired(v.isRequired); }}
                        errorMessages={{ maxLength: errors.MaxLength }}
                    />
                }
                {type === FieldTypes.MultipleLinesOfText &&
                    <NoteFieldFormFields
                        value={{ isRequired: isRequired }}
                        onChange={v => setIsRequired(v.isRequired)}
                    />
                }
                {type === FieldTypes.Lookup &&
                    <LookupFieldFormFields
                        reportType={reportType}
                        value={{ lookupList: lookupList, isRequired: isRequired }}
                        onChange={v => { setLookupList(v.lookupList); setIsRequired(v.isRequired); }}
                        errorMessages={{ lookupList: errors.LookupList }}
                    />
                }
                {type === FieldTypes.Number &&
                    <NumberFieldFormFields
                        value={{ isRequired: isRequired, min: min, max: max }}
                        onChange={v => { setIsRequired(v.isRequired); setMin(v.min); setMax(v.max); }}
                        errorMessages={{ min: errors.Min, max: errors.Max }}
                    />
                }
                {type === FieldTypes.Person &&
                    <PersonFieldFormFields
                        value={{ isRequired: isRequired, isMultiSelect: multiSelect }}
                        onChange={v => { setIsRequired(v.isRequired); setMultiSelect(v.isMultiSelect); }}
                    />
                }
                {type === FieldTypes.Choice &&
                    <ChoiceFieldFormFields
                        value={{ isRequired: isRequired, isMultiSelect: multiSelect, choices: choices, choiceControl: choiceControl }}
                        onChange={v => {
                            setIsRequired(v.isRequired);
                            setMultiSelect(v.isMultiSelect);
                            setChoices(v.choices);
                            setChoiceControl(v.choiceControl);
                            if (v.choiceControl === ChoiceFieldTypes.RadioButtons) setMultiSelect(false);
                        }}
                        errorMessages={{ choices: errors.Choices }}
                    />
                }
                <FormButtons
                    primaryText="Done"
                    onPrimaryClick={onSave}
                    onSecondaryClick={onCancel}
                />
                <FormErrorsList errors={errors} />
            </div>
        </Panel>
    );
};
