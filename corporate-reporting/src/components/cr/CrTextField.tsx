import React from 'react';
import styles from '../../styles/cr.module.scss';
import { TextField } from 'office-ui-fabric-react/lib/TextField';
import { TextFieldCharCounter, FieldHistory, FieldErrorMessage, FieldDescriptionAbove, FieldDescriptionBelow } from './FieldDecorators';
import { CrLabel } from './CrLabel';

export interface ICrTextFieldProps {
    label?: string;
    labelIcon?: string;
    className?: string;
    style?: React.CSSProperties;
    value: string;
    disabled?: boolean;
    required?: boolean;
    placeholder?: string;
    multiline?: boolean;
    rows?: number;
    maxLength?: number;
    onChange?: (value: string) => void;
    history?: string;
    charCounter?: boolean;
    errorMessage?: string;
    suffix?: string;
}

export const CrTextField = (
    { label, labelIcon, placeholder, value, required, className, style, errorMessage, onChange, maxLength, charCounter, history, multiline, ...otherProps }: ICrTextFieldProps
): React.ReactElement => {
    return (
        <div className={className} style={style}>
            {label &&
                <CrLabel
                    text={label}
                    required={required}
                    icon={labelIcon || (multiline ? `AlignLeft` : `TextField`)}
                />
            }
            {placeholder && multiline &&
                <FieldDescriptionAbove value={placeholder} />
            }
            <TextField
                {...otherProps}
                placeholder={!multiline && placeholder}
                value={value}
                maxLength={maxLength}
                multiline={multiline}
                className={errorMessage && styles.textFieldInvalid}
                onChange={(_e, v) => onChange(v)}
            />
            {charCounter && maxLength &&
                <TextFieldCharCounter maxChars={maxLength} text={value} />
            }
            {placeholder && !multiline && value != null && value !== '' &&
                <FieldDescriptionBelow value={placeholder} />
            }
            {history &&
                <FieldHistory value={history} />
            }
            {errorMessage &&
                <FieldErrorMessage value={errorMessage} />
            }
        </div>
    );
};
