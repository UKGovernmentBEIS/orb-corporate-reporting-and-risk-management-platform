import React from 'react';
import styles from '../../styles/cr.module.scss';
import { ChoiceGroup, IChoiceGroupProps } from 'office-ui-fabric-react/lib/ChoiceGroup';
import { FieldErrorMessage, FieldHistory } from './FieldDecorators';

export interface ICrChoiceGroupProps extends IChoiceGroupProps {
    history?: string;
    errorMessage?: string;
}

export const CrChoiceGroup = ({ className, history, errorMessage, ...otherProps }: ICrChoiceGroupProps): React.ReactElement => {
    return (
        <div className={className}>
            <div className={styles.cr}>
                <ChoiceGroup
                    {...otherProps}
                />
                {history && <FieldHistory value={history} />}
                {errorMessage && <FieldErrorMessage value={errorMessage} />}
            </div>
        </div>
    );
};
