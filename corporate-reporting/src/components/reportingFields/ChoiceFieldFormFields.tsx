import { Toggle } from 'office-ui-fabric-react';
import React from 'react';
import { ChoiceFieldTypes } from '../../refData/FieldTypes';
import styles from '../../styles/cr.module.scss';
import { CrChoiceGroup } from '../cr/CrChoiceGroup';
import { CrTextField } from '../cr/CrTextField';

export interface IChoiceFieldFormValues {
    choices: string;
    choiceControl: ChoiceFieldTypes;
    isMultiSelect: boolean;
    isRequired: boolean;
}

interface IChoiceFieldFormFieldsProps {
    value: IChoiceFieldFormValues;
    onChange: (value: IChoiceFieldFormValues) => void;
    errorMessages?: { choices: string };
}

export const ChoiceFieldFormFields = ({ value, onChange, errorMessages }: IChoiceFieldFormFieldsProps): React.ReactElement => {
    return (
        <>
            <CrTextField
                label="Choices"
                required={true}
                multiline
                placeholder="Type each choice on a separate line"
                className={styles.formField}
                value={value.choices}
                onChange={v => onChange({ ...value, choices: v })}
                errorMessage={errorMessages?.choices}
            />
            <CrChoiceGroup
                label="Display choices using:"
                className={styles.formField}
                options={[
                    { key: ChoiceFieldTypes.DropDownMenu.toString(), text: 'Drop-Down Menu' },
                    { key: ChoiceFieldTypes.RadioButtons.toString(), text: 'Radio Buttons' }
                ]}
                selectedKey={value.choiceControl?.toString()}
                onChange={(_, o) => onChange({ ...value, choiceControl: Number(o.key) })}
            />
            <Toggle
                label="Allow multiple selections"
                className={styles.formField}
                disabled={value.choiceControl === ChoiceFieldTypes.RadioButtons}
                checked={value.isMultiSelect}
                onChange={(_, v) => onChange({ ...value, isMultiSelect: v })}
            />
            <Toggle
                label="Require that this column contains information"
                className={styles.formField}
                checked={value.isRequired}
                onChange={(_, c) => onChange({ ...value, isRequired: c })}
            />
        </>
    );
};