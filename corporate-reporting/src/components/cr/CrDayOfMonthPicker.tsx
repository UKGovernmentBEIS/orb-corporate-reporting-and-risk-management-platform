import React from 'react';
import { ReportingFrequency } from '../../refData/ReportingFrequency';
import { IDropdownOption } from 'office-ui-fabric-react';
import { CrDropdown } from './CrDropdown';

export interface ICrDayOfMonthPickerProps {
    label: string;
    required?: boolean;
    className?: string;
    frequency: ReportingFrequency;
    month?: number; // JS Date month, 0==Jan, 1==Feb etc.
    selectedDay: number;
    onChange: (option: number) => void;
}

export const CrDayOfMonthPicker = ({ frequency, month, selectedDay, onChange, ...otherProps }: ICrDayOfMonthPickerProps): React.ReactElement => {

    const daysOfMonthOptions = (maxDay: number): IDropdownOption[] => [
        { key: 100, text: 'Last day' },
        { key: 99, text: 'Day before last' }
    ].concat(Array(maxDay).fill(null).map((_, i) => ({ key: i + 1, text: (i + 1).toString() }))).concat([
        { key: 99, text: 'Day before last' },
        { key: 100, text: 'Last day' }
    ]);

    let daysOfMonth: IDropdownOption[];
    if (frequency !== null) {
        if (frequency === ReportingFrequency.Monthly) {
            daysOfMonth = daysOfMonthOptions(28);
        } else if (month !== null) {
            if (frequency === ReportingFrequency.Quarterly) {
                if (month === 1) // Feb
                    daysOfMonth = daysOfMonthOptions(28);
                else
                    daysOfMonth = daysOfMonthOptions(30);
            } else if (frequency === ReportingFrequency.Biannually) {
                if (month === 0)  // Jan
                    daysOfMonth = daysOfMonthOptions(31);
                else if (month === 1) // Feb
                    daysOfMonth = daysOfMonthOptions(28);
                else
                    daysOfMonth = daysOfMonthOptions(30);
            } else if (frequency === ReportingFrequency.Annually) {
                if (month === 1) // Feb
                    daysOfMonth = daysOfMonthOptions(28);
                else if (month === 3 || month === 5 || month === 8 || month === 10) // Apr, Jun, Sep, Nov
                    daysOfMonth = daysOfMonthOptions(30);
                else
                    daysOfMonth = daysOfMonthOptions(31);
            }
        }
    }

    return <CrDropdown {...otherProps} options={daysOfMonth} selectedKey={selectedDay} onChange={(_, o) => onChange(Number(o.key))} />;
};
