import React from 'react';
import styles from '../../styles/cr.module.scss';
import { DefaultButton, PrimaryButton } from 'office-ui-fabric-react/lib/Button';
import { SaveIndicator } from './SaveIndicator';
import { SaveStatus } from '../../types';

export interface IFormButtonsProps {
    primaryText?: string;
    secondaryText?: string;
    primaryStatus?: SaveStatus;
    primaryDisabled?: boolean;
    secondaryDisabled?: boolean;
    onPrimaryClick: () => void;
    onSecondaryClick: () => void;
}

export const FormButtons = (
    { primaryText, secondaryText, onPrimaryClick, onSecondaryClick, primaryDisabled, secondaryDisabled, primaryStatus }: IFormButtonsProps): React.ReactElement => {
    return (
        <div>
            <PrimaryButton text={primaryText || 'Save'} className={styles.formButton} onClick={onPrimaryClick} disabled={primaryDisabled} style={{ marginRight: '5px' }} />
            <DefaultButton text={secondaryText || 'Cancel'} className={styles.formButton} onClick={onSecondaryClick} disabled={secondaryDisabled} />
            <SaveIndicator saveStatus={primaryStatus} />
        </div>
    );
};
