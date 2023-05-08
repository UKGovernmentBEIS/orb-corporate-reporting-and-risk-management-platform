import React from 'react';
import styles from '../../styles/cr.module.scss';
import { DateService } from '../../services/DateService';

export interface ICrLastEditProps {
    author: string;
    editDate: Date;
}

export const CrLastEdit = ({ author, editDate }: ICrLastEditProps): React.ReactElement =>
    <div className={styles.fontColorNeutralTertiary}>
        {author && editDate &&
            <span>Last edited by {author} at {DateService.dateToUkTime(editDate)} on {DateService.dateToUkDate(editDate)}</span>
        }
    </div>;
