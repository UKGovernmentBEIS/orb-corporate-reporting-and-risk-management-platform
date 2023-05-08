import React from 'react';
import styles from '../../styles/cr.module.scss';
import { ComboBox, IComboBoxProps } from 'office-ui-fabric-react/lib/ComboBox';
import { FieldErrorMessage, FieldHistory } from './FieldDecorators';
import { CrLabel } from './CrLabel';

export interface ICrComboBoxProps extends IComboBoxProps {
    history?: string;
    errorMessage?: string;
}

export const CrComboBox = ({ label, required, className, history, errorMessage, ...otherProps }: ICrComboBoxProps): React.ReactElement => {
    return (
        <div className={className}>
            <div className={styles.cr}>
                <ComboBox
                    {...otherProps}
                    className={errorMessage && styles.dropdownInvalid}
                    onRenderLabel={() => label && <CrLabel text={label} required={required} icon="Combobox" />
                    }
                />
                {history &&
                    <FieldHistory value={history} />
                }
                {errorMessage &&
                    <FieldErrorMessage value={errorMessage} />
                }
            </div>
        </div>
    );
};
