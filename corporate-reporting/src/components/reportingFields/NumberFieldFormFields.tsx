import { Toggle } from 'office-ui-fabric-react';
import React from 'react';
import styles from '../../styles/cr.module.scss';
import { CrNumberTextField } from '../cr/CrNumberTextField';

export interface INumberFieldFormValues {
    isRequired: boolean;
    min: string;
    max: string;
}

interface INumberFieldFormFieldsProps {
    value: INumberFieldFormValues;
    onChange: (value: INumberFieldFormValues) => void;
    errorMessages?: { min: string, max: string };
}

export const NumberFieldFormFields = ({ value, onChange, errorMessages }: INumberFieldFormFieldsProps): React.ReactElement => {
    return (
        <>
            <CrNumberTextField
                label="Minimum allowed value"
                className={styles.formField}
                maxLength={18}
                value={value.min}
                onChange={v => onChange({ ...value, min: v })}
                errorMessage={errorMessages?.min}
            />
            <CrNumberTextField
                label="Maximum allowed value"
                className={styles.formField}
                maxLength={18}
                value={value.max}
                onChange={v => onChange({ ...value, max: v })}
                errorMessage={errorMessages?.max}
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