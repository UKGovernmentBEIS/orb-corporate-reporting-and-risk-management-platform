import React, { useState } from 'react';
import { DayOfWeek } from 'office-ui-fabric-react';
import { CrDropdown } from './CrDropdown';

export interface ICrMonthlyWeekdayPickerProps {
    required?: boolean;
    className?: string;
    dueDay: number;
    onChange?: (dueDay: number) => void;
}

export const CrMonthlyWeekdayPicker = ({ required, className, dueDay, onChange }: ICrMonthlyWeekdayPickerProps): React.ReactElement => {
    const combineDayAndWeek = (occurence: number, dayOfWeek: DayOfWeek): number => {
        return Number(`1${occurence}${dayOfWeek}`);
    };
    const divideDayAndWeek = (combined: number): { occurenceInMonth: number, dayOfWeek: DayOfWeek } => {
        if (combined)
            return { occurenceInMonth: Number(combined.toString()[1]), dayOfWeek: Number(combined.toString()[2]) };
        else
            return { occurenceInMonth: null, dayOfWeek: null };
    };
    const [occurenceInMonth, setOccurenceInMonth] = useState(divideDayAndWeek(dueDay).occurenceInMonth);
    const [weekday, setWeekday] = useState(divideDayAndWeek(dueDay).dayOfWeek);

    const changeMonthlyWeekdayOccurence = (occurence: number): void => {
        setOccurenceInMonth(occurence);
        if (weekday) onChange(combineDayAndWeek(occurence, weekday));
    };

    const changeMonthlyWeekdayDayOfWeek = (dayOfWeek: number): void => {
        setWeekday(dayOfWeek);
        if (occurenceInMonth) onChange(combineDayAndWeek(occurenceInMonth, dayOfWeek));
    };

    const occurenceToName = (occ: number): string => {
        return occ === 1 ? 'First' : occ === 2 ? 'Second' : occ === 3 ? 'Third' : occ === 4 ? 'Fourth' : occ === 5 ? 'Last' : '...';
    };

    return (
        <div className={className}>
            <CrDropdown
                label="Day of the week"
                required={required}
                options={[
                    { key: DayOfWeek.Monday.toString(), text: 'Monday' },
                    { key: DayOfWeek.Tuesday.toString(), text: 'Tuesday' },
                    { key: DayOfWeek.Wednesday.toString(), text: 'Wednesday' },
                    { key: DayOfWeek.Thursday.toString(), text: 'Thursday' },
                    { key: DayOfWeek.Friday.toString(), text: 'Friday' },
                    { key: DayOfWeek.Saturday.toString(), text: 'Saturday' },
                    { key: DayOfWeek.Sunday.toString(), text: 'Sunday' }
                ]}
                selectedKey={weekday !== null && weekday.toString()}
                onChange={(_, d) => changeMonthlyWeekdayDayOfWeek(Number(d.key))}
            />
            <CrDropdown
                label={`${occurenceToName(occurenceInMonth)} ${weekday ? DayOfWeek[weekday] : `weekday`} of the month`}
                required={required}
                options={[
                    { key: 1, text: 'First' },
                    { key: 2, text: 'Second' },
                    { key: 3, text: 'Third' },
                    { key: 4, text: 'Fourth' },
                    { key: 5, text: 'Last' }
                ]}
                selectedKey={occurenceInMonth}
                onChange={(_, d) => changeMonthlyWeekdayOccurence(Number(d.key))}
            />
        </div>
    );
};
