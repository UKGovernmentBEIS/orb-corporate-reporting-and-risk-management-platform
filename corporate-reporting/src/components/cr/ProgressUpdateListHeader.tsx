import React from 'react';
import styles from '../../styles/cr.module.scss';
import { TooltipHost, TooltipOverflowMode } from 'office-ui-fabric-react/lib/Tooltip';
import { CrBadge } from './CrBadge';

export interface IProgressUpdateListHeaderProps {
    title: string;
    numberOfItems?: number;
}

export const ProgressUpdateListHeader = ({ title, numberOfItems }: IProgressUpdateListHeaderProps): React.ReactElement => {
    return (
        <div className={`${styles.cr} ${styles.updateSectionHeader}`}>
            <div className={styles.fontSize16}>
                <TooltipHost overflowMode={TooltipOverflowMode.Parent} content={title}>
                    <span>{title} </span>
                    <CrBadge
                        text={numberOfItems && numberOfItems.toLocaleString()}
                        description={`There ${numberOfItems > 1 ? `are ${numberOfItems} items` : numberOfItems === 1 ? `is 1 item` : `are no items`} in this section`}
                        badgeClass={styles.badgeNeutralLight}
                    />
                </TooltipHost>
            </div>
        </div>
    );
};
