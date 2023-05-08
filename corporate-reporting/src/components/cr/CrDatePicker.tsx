import React from 'react';
import { format } from 'date-fns';
import { DateService } from '../../services/DateService';
import styles from '../../styles/cr.module.scss';
import { DatePicker, DayOfWeek } from 'office-ui-fabric-react/lib/DatePicker';
import { FieldErrorMessage, FieldHistory, FieldDescriptionBelow } from './FieldDecorators';
import { CrLabel } from './CrLabel';

export interface ICrDatePickerProps {
    label?: string;
    required?: boolean;
    placeholder?: string;
    className?: string;
    disabled?: boolean;
    minDate?: Date;
    maxDate?: Date;
    value?: Date;
    onSelectDate?: (date: Date) => void;
    history?: Date;
    errorMessage?: string;
    helpText?: string;
}

export const CrDatePicker = (
    { className, label, required, helpText, errorMessage, history, ...otherProps }: ICrDatePickerProps
): React.ReactElement => {
    return (
        <div className={className}>
            {label &&
                <CrLabel text={label} required={required} icon="Calendar" />
            }
            <div style={{ maxWidth: '350px' }}>
                <DatePicker
                    {...otherProps}
                    className={errorMessage && styles.datePickerInvalid}
                    allowTextInput={true}
                    parseDateFromString={DateService.parseUkDate}
                    formatDate={date => date && format(date, DateService.ukDateFormat)}
                    firstDayOfWeek={DayOfWeek.Monday}
                />
            </div>
            {helpText &&
                <FieldDescriptionBelow value={helpText} />
            }
            {history &&
                <FieldHistory value={DateService.dateToUkDate(history)} />
            }
            {errorMessage &&
                <FieldErrorMessage value={errorMessage} />
            }
        </div>
    );
};
