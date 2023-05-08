import React from 'react';
import styles from '../../styles/FieldDecorators.module.scss';

export interface IFieldDescriptionProps {
    value: string;
}

export const FieldDescriptionAbove = ({ value }: IFieldDescriptionProps): React.ReactElement =>
    <div className={styles.fieldDecorators}>
        <div className={styles.descriptionAbove}>{value}</div>
    </div>;

export const FieldDescriptionBelow = ({ value }: IFieldDescriptionProps): React.ReactElement =>
    <div className={styles.fieldDecorators}>
        <div className={styles.descriptionBelow}>{value}</div>
    </div>;

export interface IFieldErrorMessageProps {
    value: string;
}

export const FieldErrorMessage = ({ value }: IFieldErrorMessageProps): React.ReactElement =>
    <span className={styles.fieldDecorators}>
        <div role="alert">
            <p className={styles.errorMessage}>
                <span>{value}</span>
            </p>
        </div>
    </span>;

export interface IFieldHistoryProps {
    value: string;
}

export const FieldHistory = ({ value }: IFieldHistoryProps): React.ReactElement =>
    <div className={styles.fieldDecorators}>
        <div className={styles.history}>Last reporting period: <span>{value}</span></div>
    </div>;

export interface ITextFieldCharCounterProps {
    maxChars: number;
    text: string;
}

export const TextFieldCharCounter = ({ maxChars, text }: ITextFieldCharCounterProps): React.ReactElement =>
    <div style={{ textAlign: 'right' }}>{`${text ? maxChars - text.length : maxChars} characters remaining`}</div>;
