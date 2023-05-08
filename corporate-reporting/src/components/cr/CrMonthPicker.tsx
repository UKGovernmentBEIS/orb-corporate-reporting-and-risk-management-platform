import React from 'react';
import { eachMonthOfInterval, format, formatISO } from 'date-fns';
import { DateService } from '../../services/DateService';
import { CrDropdown } from './CrDropdown';

export interface ICrMonthPickerProps {
    from: Date;
    to: Date;
    label?: string;
    required?: boolean;
    disabled?: boolean;
    className?: string;
    placeholder?: string;
    value?: Date;
    onChange?: (date: Date) => void;
    errorMessage?: string;
}

export const CrMonthPicker = ({ from, to, errorMessage, value, onChange, ...otherProps }: ICrMonthPickerProps): React.ReactElement => {
    const monthOptions = eachMonthOfInterval({ start: from, end: to })
        .map(d => DateService.lastDateOfMonth(d))
        .map(d => ({ key: formatISO(d), text: format(d, DateService.monthNameFormat) }));

    return (
        <CrDropdown
            {...otherProps}
            options={monthOptions}
            selectedKey={formatISO(value)}
            onChange={(_, option) => onChange && onChange(DateService.setLocaleDateToUTC(new Date(option.key.toString())))}
            errorMessage={errorMessage}
        />
    );
};
