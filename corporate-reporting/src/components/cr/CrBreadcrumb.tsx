import React from 'react';
import styles from '../../styles/CrBreadcrumb.module.scss';
import { Icon } from 'office-ui-fabric-react/lib/Icon';
import { TooltipHost, TooltipOverflowMode } from 'office-ui-fabric-react/lib/Tooltip';

export interface ICrBreadcrumbProps {
    items: string[];
}

export const CrBreadcrumb = ({ items }: ICrBreadcrumbProps): React.ReactElement => {
    return (
        <ol className={styles.crBreadcrumb}>
            {items && items.map((value, index) => {
                return (
                    <li key={index} className={styles.crumb}>
                        <span className={styles.crumbTitle}>
                            <TooltipHost overflowMode={TooltipOverflowMode.Parent} content={value}>{value}</TooltipHost>
                        </span>
                        {index + 1 !== items.length && <Icon iconName='ChevronRight' className={styles.crumbDivider} />}
                    </li>
                );
            })}
        </ol>
    );
};
