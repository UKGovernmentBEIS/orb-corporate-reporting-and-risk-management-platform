import { Toggle } from 'office-ui-fabric-react';
import React from 'react';
import styles from '../../styles/cr.module.scss';
import { CrNumberTextField } from '../cr/CrNumberTextField';

export interface ITextFieldFormValues {
    maxLength: string;
    isRequired: boolean;
}
interface ITextFieldFormFieldsProps {
    value: ITextFieldFormValues;
    onChange: (value: ITextFieldFormValues) => void;
    errorMessages?: { maxLength: string };
}

export const TextFieldFormFields = ({ value, onChange, errorMessages }: ITextFieldFormFieldsProps): React.ReactElement => {
    return (
        <>
            <CrNumberTextField
                label="Maximum number of characters"
                className={styles.formField}
                required={true}
                maxLength={3}
                value={value.maxLength}
                onChange={v => onChange({ ...value, maxLength: v })}
                errorMessage={errorMessages?.maxLength}
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