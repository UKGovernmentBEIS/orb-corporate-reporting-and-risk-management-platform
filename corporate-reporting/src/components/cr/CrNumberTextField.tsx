import React from 'react';
import styles from '../../styles/CrNumberTextField.module.scss';
import { FieldHistory, FieldErrorMessage } from './FieldDecorators';
import { CrTextField } from '../cr/CrTextField';
import { NumberService } from '../../services/NumberService';

export interface ICrNumberTextFieldProps {
    label?: string;
    className?: string;
    value: number | string;
    disabled?: boolean;
    required?: boolean;
    maxLength?: number;
    onChange?: (value: string) => void;
    history?: number;
    errorMessage?: string;
    suffix?: string;
}

export const CrNumberTextField = ({ value, history, className, errorMessage, suffix, ...props }: ICrNumberTextFieldProps): React.ReactElement => {
    const n = Number(value);
    return (
        <div className={className}>
            <div className={styles.numberTextField}>
                <div style={{ maxWidth: '350px' }}>
                    <CrTextField
                        {...props}
                        labelIcon="NumberField"
                        className={errorMessage && styles.invalid}
                        placeholder="Numbers only"
                        value={NumberService.IsNullOrUndefined(value) ? null : value.toString()}
                        suffix={suffix}
                    />
                </div>
                {!isNaN(n) && n >= 1000 &&
                    <div className={styles.formattedNumber} style={{ paddingLeft: '12px' }}>{n.toLocaleString('en-GB')}</div>
                }
                {history !== undefined && history !== null &&
                    <FieldHistory value={history.toLocaleString('en-GB')} />
                }
                {errorMessage &&
                    <FieldErrorMessage value={errorMessage} />
                }
            </div>
        </div>
    );
};