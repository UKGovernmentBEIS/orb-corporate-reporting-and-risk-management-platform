import { Icon, Label, TooltipHost, TooltipOverflowMode } from 'office-ui-fabric-react';
import React, { ReactNode } from 'react';
import styles from '../../styles/cr.module.scss';

interface ICrLabelProps {
    text?: string;
    required?: boolean;
    icon?: string;
    singleLine?: boolean;
    children?: ReactNode;
}

export const CrLabel = ({ text, required, icon, singleLine, children }: ICrLabelProps): React.ReactElement =>
    <TooltipHost overflowMode={TooltipOverflowMode.Self} content={text}>
        <Label required={required} className={singleLine ? styles.formLabelNoWrap : ''}>
            <span className={styles.fieldLabelWrapper}>
                {icon &&
                    <Icon iconName={icon} className={styles.fieldLabelIcon} />
                }
                <span>{text || children}</span>
            </span>
        </Label>
    </TooltipHost>;
