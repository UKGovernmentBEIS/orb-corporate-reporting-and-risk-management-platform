import React, { useState } from 'react';
import styles from '../../styles/cr.module.scss';
import { ReportingFrequency } from '../../refData/ReportingFrequency';
import { DayOfWeek } from 'office-ui-fabric-react';
import { CrReportingCycleMonthPicker } from './CrReportingCycleMonthPicker';
import { CrDatePicker } from './CrDatePicker';
import { CrMonthlyWeekdayPicker } from './CrMonthlyWeekdayPicker';
import { IReportingCycle } from '../../types';
import { CrDayOfMonthPicker } from './CrDayOfMonthPicker';
import { FieldErrorMessage } from './FieldDecorators';
import { CrLabel } from './CrLabel';
import { CrDropdown } from './CrDropdown';

export interface ICrReportingCyclePickerProps {
    label?: string;
    required?: boolean;
    className?: string;
    cycle: IReportingCycle;
    onChange: (reportingCycle: IReportingCycle) => void;
    errorMessage?: string;
}

export const CrReportingCyclePicker = ({ label, required, className, cycle, onChange, errorMessage, ...otherProps }: ICrReportingCyclePickerProps): React.ReactElement => {
    const [startDateValidationMessage, setStartDateValidationMessage] = useState('');
    const validateStartDate = (date: Date, dayOfWeek: DayOfWeek): boolean => {
        if (date?.getDay() !== dayOfWeek) {
            setStartDateValidationMessage('For fortnightly reports, the start date day must be the same as the due day');
            return false;
        }
        setStartDateValidationMessage('');
        return true;
    };
    return (
        <div className={className}>
            {label &&
                <CrLabel text={label} required={required} icon="Calendar" />
            }
            <div className={styles.formSubField}>
                <CrDropdown
                    {...otherProps}
                    label="Frequency"
                    options={[
                        // { key: ReportingFrequency.Daily.toString(), text: 'Daily' },
                        { key: ReportingFrequency.Weekly.toString(), text: 'Weekly' },
                        { key: ReportingFrequency.Fortnightly.toString(), text: 'Fortnightly' },
                        { key: ReportingFrequency.Monthly.toString(), text: 'Monthly (fixed date)' },
                        { key: ReportingFrequency.MonthlyWeekday.toString(), text: 'Monthly (nth weekday of the month)' },
                        { key: ReportingFrequency.Quarterly.toString(), text: 'Quarterly' },
                        { key: ReportingFrequency.Biannually.toString(), text: 'Biannually' },
                        { key: ReportingFrequency.Annually.toString(), text: 'Annually' }
                    ]}
                    selectedKey={cycle.frequency?.toString()}
                    onChange={(_, f) => onChange({ frequency: Number(f.key), dueDay: null, startDate: null })}
                />
                {(cycle.frequency === ReportingFrequency.Weekly || cycle.frequency === ReportingFrequency.Fortnightly) &&
                    <CrDropdown
                        label="Day of the week"
                        options={[
                            { key: DayOfWeek.Monday.toString(), text: 'Monday' },
                            { key: DayOfWeek.Tuesday.toString(), text: 'Tuesday' },
                            { key: DayOfWeek.Wednesday.toString(), text: 'Wednesday' },
                            { key: DayOfWeek.Thursday.toString(), text: 'Thursday' },
                            { key: DayOfWeek.Friday.toString(), text: 'Friday' },
                            { key: DayOfWeek.Saturday.toString(), text: 'Saturday' },
                            { key: DayOfWeek.Sunday.toString(), text: 'Sunday' }
                        ]}
                        selectedKey={cycle.dueDay?.toString()}
                        onChange={(_, d) => onChange({ frequency: cycle.frequency, dueDay: Number(d.key), startDate: cycle.startDate })}
                    />
                }
                {cycle.frequency === ReportingFrequency.Fortnightly &&
                    <CrDatePicker
                        label="Start date"
                        placeholder="Select the date the first report is due"
                        value={cycle.startDate}
                        onSelectDate={d => {
                            if (validateStartDate(d, cycle.dueDay)) {
                                onChange({ frequency: cycle.frequency, dueDay: cycle.dueDay, startDate: d });
                            } else {
                                onChange({ frequency: cycle.frequency, dueDay: cycle.dueDay, startDate: null });
                            }
                        }}
                        errorMessage={startDateValidationMessage}
                    />
                }
                {cycle.frequency === ReportingFrequency.Monthly &&
                    <CrDayOfMonthPicker
                        label="Day of the month"
                        frequency={cycle.frequency}
                        selectedDay={cycle.dueDay}
                        onChange={d => onChange({ frequency: cycle.frequency, dueDay: d, startDate: null })}
                    />
                }
                {cycle.frequency === ReportingFrequency.MonthlyWeekday &&
                    <CrMonthlyWeekdayPicker
                        dueDay={cycle.dueDay}
                        onChange={day => onChange({ frequency: cycle.frequency, dueDay: day, startDate: cycle.startDate })}
                    />
                }
                {(cycle.frequency === ReportingFrequency.Quarterly || cycle.frequency === ReportingFrequency.Biannually || cycle.frequency === ReportingFrequency.Annually) &&
                    <>
                        <CrReportingCycleMonthPicker
                            label="Reporting month(s)"
                            frequency={cycle.frequency}
                            selectedKey={cycle.startDate?.getMonth() + 1}
                            onChange={f => onChange({ frequency: cycle.frequency, dueDay: cycle.dueDay, startDate: new Date(Date.UTC(2020, f - 1, 1)) })}
                        />
                        <CrDayOfMonthPicker
                            label="Day of the month"
                            frequency={cycle.frequency}
                            month={cycle.startDate?.getMonth()}
                            selectedDay={cycle.dueDay}
                            onChange={day => onChange({ frequency: cycle.frequency, dueDay: day, startDate: cycle.startDate })}
                        />
                    </>
                }
            </div>
            {errorMessage &&
                <FieldErrorMessage value={errorMessage} />
            }
        </div>
    );
};
