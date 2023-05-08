import React from 'react';
import styles from '../../styles/cr.module.scss';
import { CrBadges } from './CrBadges';

export interface IUpdateHeaderTitleProps {
    title: string;
    tags?: string[];
}

export const UpdateHeaderTitle = ({ title, tags }: IUpdateHeaderTitleProps): React.ReactElement => {
    return (
        <span>
            {title} {tags &&
                <CrBadges badges={tags.map(b => ({ text: b, badgeClass: styles.badgeSecondary }))} />
            }
        </span>
    );
};
