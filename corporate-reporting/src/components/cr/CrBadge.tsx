import React, { ReactNode } from 'react';
import styles from '../../styles/cr-badge.module.scss';

export interface ICrBadgeProps {
    text?: string;
    description?: string;
    badgeClass?: string;
    children?: ReactNode;
}

export const CrBadge = ({ text, description, badgeClass, children }: ICrBadgeProps): React.ReactElement =>
    <span className={`${styles.badge} ${badgeClass}`} title={description || text}>{text || children}</span>;
