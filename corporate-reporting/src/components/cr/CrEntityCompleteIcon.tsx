import React from 'react';
import styles from '../../styles/CrEntityCompleteIcon.module.scss';
import { Icon } from 'office-ui-fabric-react/lib/Icon';

export const CrEntityCompleteIcon = ({ title }: { title?: string }): React.ReactElement =>
    <Icon iconName="Completed" className={styles.entityCompleteIcon} title={title || "Complete"} />;
