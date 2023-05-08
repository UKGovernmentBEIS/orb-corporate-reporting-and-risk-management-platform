import React from 'react';
import styles from '../../styles/cr.module.scss';
import { Dropdown, IDropdownProps } from 'office-ui-fabric-react/lib/Dropdown';
import { FieldErrorMessage, FieldHistory } from './FieldDecorators';
import { CrLabel } from './CrLabel';

export interface ICrDropdownProps extends IDropdownProps {
    history?: string;
    errorMessage?: string;
}

export const CrDropdown = ({ label, required, className, errorMessage, history, ...otherProps }: ICrDropdownProps): React.ReactElement => {
    return (
        <div className={className}>
            <div className={styles.cr}>
                <Dropdown
                    {...otherProps}
                    onRenderLabel={() => label &&
                        <CrLabel text={label} required={required} icon="Dropdown" />
                    }
                    className={errorMessage && styles.dropdownInvalid}
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
