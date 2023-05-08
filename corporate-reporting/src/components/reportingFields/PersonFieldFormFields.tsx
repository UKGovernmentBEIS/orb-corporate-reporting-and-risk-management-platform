import { Toggle } from 'office-ui-fabric-react';
import React from 'react';
import styles from '../../styles/cr.module.scss';

export interface IPersonFieldFormValues {
    isRequired: boolean;
    isMultiSelect: boolean;
}

interface IPersonFieldFormFieldsProps {
    value: IPersonFieldFormValues;
    onChange: (value: IPersonFieldFormValues) => void;
}

export const PersonFieldFormFields = ({ value, onChange }: IPersonFieldFormFieldsProps): React.ReactElement => {
    return (
        <>
            <Toggle
                label="Allow multiple selections"
                className={styles.formField}
                checked={value.isMultiSelect}
                onChange={(_, c) => onChange({ ...value, isMultiSelect: c })}
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