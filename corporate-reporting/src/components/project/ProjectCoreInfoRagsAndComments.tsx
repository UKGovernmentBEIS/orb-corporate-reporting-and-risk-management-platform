import React from 'react';
import styles from '../../styles/cr.module.scss';
import { ListDefaults as ld } from '../../types';
import { RagIndicator } from '../cr/RagIndicator';

export interface IProjectCoreInfoRagsAndCommentsProps {
    className?: string;
    finance: { rag: number, comment: string };
    people: { rag: number, comment: string };
    milestones: { rag: number, comment: string };
    benefits: { rag: number, comment: string };
}

export const ProjectCoreInfoRagsAndComments = ({ finance, people, milestones, benefits, ...other }: IProjectCoreInfoRagsAndCommentsProps): React.ReactElement => {
    return (
        <div {...other}>
            <div className={`${styles.gridRow} ${styles.signOffGridRow}`}>
                <div className={`${styles.gridCol} ${styles.sm12} ${styles.xl3}`}>
                    <div className={styles.content}>
                        <div className={styles.reviewListTitle}>Finance</div>
                        <RagIndicator rag={finance.rag} />
                        <p>{finance.comment || ld.placeholders.dataTBC}</p>
                    </div>
                </div>
                <div className={`${styles.gridCol} ${styles.sm12} ${styles.xl3}`}>
                    <div className={styles.content}>
                        <div className={styles.reviewListTitle}>People</div>
                        <RagIndicator rag={people.rag} />
                        <p>{people.comment || ld.placeholders.dataTBC}</p>
                    </div>
                </div>
                <div className={`${styles.gridCol} ${styles.sm12} ${styles.xl3}`}>
                    <div className={styles.content}>
                        <div className={styles.reviewListTitle}>Milestones</div>
                        <RagIndicator rag={milestones.rag} />
                        <p>{milestones.comment || ld.placeholders.dataTBC}</p>
                    </div>
                </div>
                <div className={`${styles.gridCol} ${styles.sm12} ${styles.xl3}`}>
                    <div className={styles.content}>
                        <div className={styles.reviewListTitle}>Benefits</div>
                        <RagIndicator rag={benefits.rag} />
                        <p>{benefits.comment || ld.placeholders.dataTBC}</p>
                    </div>
                </div>
            </div>
        </div>
    );
};
