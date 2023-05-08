import React from 'react';
import { Period } from '../../refData/Period';
import { CrChoiceGroup } from './CrChoiceGroup';

export interface ICrUpdatePeriodPickerProps {
    label?: string;
    required?: boolean;
    disabled?: boolean;
    className?: string;
    value?: Period;
    onChange: (period: Period) => void;
}

export const CrUpdatePeriodPicker = ({ value, onChange, ...otherProps }: ICrUpdatePeriodPickerProps): React.ReactElement => {
    return (
        <CrChoiceGroup
            {...otherProps}
            styles={{ flexContainer: { display: 'flex' } }}
            options={[
                { key: Period.Previous.toString(), text: `Last period\u00A0\u00A0` },
                { key: Period.Current.toString(), text: `Current period` }
            ]}
            selectedKey={value.toString()}
            onChange={(_, p) => onChange(Number(p.key))}
        />
    );
};
