import React from 'react';
import styles from '../../styles/cr.module.scss';
import { Icon } from 'office-ui-fabric-react';

export const CrInlineIcon = ({ iconName }: { iconName: string }): React.ReactElement =>
    <div className={styles.inlineIconContainer}><Icon iconName={iconName} className={styles.inlineIcon} /></div>;