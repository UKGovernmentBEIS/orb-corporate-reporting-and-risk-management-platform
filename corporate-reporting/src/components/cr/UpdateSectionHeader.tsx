import React from 'react';
import styles from '../../styles/cr.module.scss';
import { Icon } from 'office-ui-fabric-react/lib/Icon';
import { TooltipHost, TooltipOverflowMode } from 'office-ui-fabric-react/lib/Tooltip';
import { CrBadge } from './CrBadge';

export interface IUpdateSectionHeaderProps {
    title: string;
    numberOfItems?: number;
    isOpen?: boolean;
    onClick?: () => void;
}

export const UpdateSectionHeader = ({ title, numberOfItems, isOpen, onClick }: IUpdateSectionHeaderProps): React.ReactElement => {
    return (
        <div className={`${styles.cr} ${styles.updateSectionHeader}`} onClick={onClick}>
            <Icon iconName={isOpen ? 'ChevronDown' : 'ChevronRight'} className={styles.msIcon} />
            <div className={styles.updateSectionHeaderTitle}>
                <TooltipHost overflowMode={TooltipOverflowMode.Parent} content={title}>
                    <span>{title} </span>
                    <CrBadge
                        text={numberOfItems?.toLocaleString()}
                        description={`There ${numberOfItems > 1 ? `are ${numberOfItems} items` : numberOfItems === 1 ? `is 1 item` : `are no items`} in this section`}
                        badgeClass={styles.badgeNeutralLight}
                    />
                </TooltipHost>
            </div>
        </div>
    );
};
