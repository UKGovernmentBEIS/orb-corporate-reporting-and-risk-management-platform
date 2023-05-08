import React from 'react';
import { ReportingFrequency } from '../../refData/ReportingFrequency';
import { CrDropdown } from './CrDropdown';

export interface ICrReportingCycleMonthPickerProps {
    frequency: ReportingFrequency;
    className?: string;
    label?: string;
    required?: boolean;
    selectedKey?: number;
    onChange?: (option: number) => void;
    placeholder?: string;
    history?: string;
    errorMessage?: string;
}

export const CrReportingCycleMonthPicker = ({ frequency, selectedKey, onChange, ...otherProps }: ICrReportingCycleMonthPickerProps): React.ReactElement => {
    let startMonths: { key: number, text: string }[] = [];
    if (frequency === ReportingFrequency.Quarterly) {
        startMonths = [
            { key: 1, text: 'Jan, Apr, Jul, Oct' },
            { key: 2, text: 'Feb, May, Aug, Nov' },
            { key: 3, text: 'Mar, Jun, Sep, Dec' }
        ];
    }
    if (frequency === ReportingFrequency.Biannually) {
        startMonths = [
            { key: 1, text: 'Jan, Jul' },
            { key: 2, text: 'Feb, Aug' },
            { key: 3, text: 'Mar, Sep' },
            { key: 4, text: 'Apr, Oct' },
            { key: 5, text: 'May, Nov' },
            { key: 6, text: 'Jun, Dec' }
        ];
    }
    if (frequency === ReportingFrequency.Annually) {
        startMonths = [
            { key: 1, text: 'Jan' },
            { key: 2, text: 'Feb' },
            { key: 3, text: 'Mar' },
            { key: 4, text: 'Apr' },
            { key: 5, text: 'May' },
            { key: 6, text: 'Jun' },
            { key: 7, text: 'Jul' },
            { key: 8, text: 'Aug' },
            { key: 9, text: 'Sep' },
            { key: 10, text: 'Oct' },
            { key: 11, text: 'Nov' },
            { key: 12, text: 'Dec' }
        ];
    }
    return <CrDropdown {...otherProps} options={startMonths} selectedKey={selectedKey} onChange={(_, o) => onChange(Number(o.key))} />;
};
