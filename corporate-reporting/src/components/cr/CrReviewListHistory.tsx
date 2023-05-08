import React from 'react';
import styles from '../../styles/CrReviewListHistory.module.scss';

export interface ICrReviewListHistoryProps {
    value?: string;
}

export const CrReviewListHistory = ({ value }: ICrReviewListHistoryProps): React.ReactElement => {
    return (
        <div className={styles.crReviewListHistory}>
            <div className={styles.history}>
                <div>Last reporting period:</div>
                <div>{value}</div>
            </div>
        </div>
    );
};
