import React from 'react';
import styles from '../../styles/cr.module.scss';
import { DateService } from '../../services/DateService';

export interface ICrApprovalDetailsProps {
    approverName: string;
    approvalDate: Date;
    className?: string;
}

export const CrApprovalDetails = ({ approverName, approvalDate, className }: ICrApprovalDetailsProps): React.ReactElement =>
    <p className={`${styles.fontColorNeutralSecondary} ${className}`}>
        Approved by {approverName || `[unknown]`} on {DateService.dateToUkDate(approvalDate)}
    </p>;
