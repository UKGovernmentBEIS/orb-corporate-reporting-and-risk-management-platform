import React from 'react';
import styles from '../../styles/cr.module.scss';
import { ListDefaults as ld } from '../../types';
import { RagIndicator } from '../cr/RagIndicator';

export interface IProjectHeadlineRagAndCommentsProps {
    className?: string;
    rag: number;
    progressUpdate: string;
    futureActions: string;
    escalations: string;
}

export const ProjectHeadlineRagAndComments = ({ rag, progressUpdate, futureActions, escalations, ...other }: IProjectHeadlineRagAndCommentsProps): React.ReactElement => {
    return (
        <div {...other}>
            <div className={`${styles.gridRow} ${styles.signOffGridRow}`}>
                <div className={`${styles.gridCol} ${styles.sm12}`}>
                    <RagIndicator rag={rag} />
                </div>
            </div>
            <div className={`${styles.gridRow} ${styles.signOffGridRow}`}>
                <div className={`${styles.gridCol} ${styles.sm12} ${styles.xl4}`}>
                    <div className={styles.content}>
                        <div className={styles.reviewListTitle}>Delivery confidence</div>
                        <p>{progressUpdate || ld.placeholders.dataTBC}</p>
                    </div>
                </div>
                <div className={`${styles.gridCol} ${styles.sm12} ${styles.xl4}`}>
                    <div className={styles.content}>
                        <div className={styles.reviewListTitle}>Future actions</div>
                        <p>{futureActions || ld.placeholders.dataTBC}</p>
                    </div>
                </div>
                <div className={`${styles.gridCol} ${styles.sm12} ${styles.xl4}`}>
                    <div className={styles.content}>
                        <div className={styles.reviewListTitle}>Escalations for senior leader action</div>
                        <p>{escalations || ld.placeholders.dataTBC}</p>
                    </div>
                </div>
            </div>
        </div>
    );
};
