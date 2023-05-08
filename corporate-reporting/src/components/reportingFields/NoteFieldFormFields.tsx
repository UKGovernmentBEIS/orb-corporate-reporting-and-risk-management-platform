import { Toggle } from 'office-ui-fabric-react';
import React from 'react';
import styles from '../../styles/cr.module.scss';

export interface INoteFieldFormValues {
    isRequired: boolean;
}

interface INoteFieldFormFieldsProps {
    value: INoteFieldFormValues;
    onChange: (value: INoteFieldFormValues) => void;
}

export const NoteFieldFormFields = ({ value, onChange }: INoteFieldFormFieldsProps): React.ReactElement => {
    return (
        <>
            <Toggle
                label="Require that this column contains information"
                className={styles.formField}
                checked={value.isRequired}
                onChange={(_, c) => onChange({ ...value, isRequired: c })}
            />
        </>
    );
};