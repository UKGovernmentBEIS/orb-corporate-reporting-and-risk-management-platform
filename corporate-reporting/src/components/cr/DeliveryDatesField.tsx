import React from 'react';
import { DateService } from '../../services';
import styles from '../../styles/cr.module.scss';
import { CrLabel } from './CrLabel';

export const DeliveryDatesField = ({ baseline, forecast }: { baseline: Date, forecast: Date }): React.ReactElement => {
    return (
        <>
            {baseline &&
                <div className={styles.formField}>
                    <CrLabel>Baseline delivery date</CrLabel>
                    <div className={styles.formText}>{DateService.dateToUkDate(baseline)}</div>
                </div>
            }
            {forecast &&
                <div className={styles.formField}>
                    <CrLabel>Current forecast delivery date</CrLabel>
                    <div className={styles.formText}>{DateService.dateToUkDate(forecast)}</div>
                </div>
            }
        </>
    );
};