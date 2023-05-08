import { addYears, format } from 'date-fns';
import { Text } from 'office-ui-fabric-react';
import React from 'react';
import styles from "../../styles/cr.module.scss";
import { ISpendProfile } from '../../types';
import { CrLabel } from '../cr/CrLabel';
import { CrNumberTextField } from "../cr/CrNumberTextField";
import { FieldErrorMessage } from '../cr/FieldDecorators';

interface ISpendProfileFieldProps {
    className?: string;
    disabled?: boolean;
    reportDate: Date;
    value: ISpendProfile;
    onChange?: (spendProfile: ISpendProfile) => void;
    errorMessage?: string;
}

export const SpendProfileField = ({ className, disabled, reportDate, value, onChange, errorMessage }: ISpendProfileFieldProps): React.ReactElement => {
    const finYear = (date: Date): string => date && `${format(date, 'yyyy')}-${format(addYears(date, 1), 'yy')}`;

    return (
        <div className={className}>
            <CrLabel text="Spend/income profile" icon="Money" />
            <div className={styles.grid}>
                <div className={styles.gridRow}>
                    {reportDate && [0, 1, 2, 3, 4].map(i =>
                        <div key={i} className={`${styles.gridCol} ${styles.sm12} ${styles.xl2}`}>
                            <CrNumberTextField
                                label={finYear(addYears(reportDate, i))}
                                disabled={disabled}
                                suffix="£m"
                                value={value?.[`FinancialYear${i}`]?.toString()}
                                onChange={v => onChange?.({
                                    FinancialYear0: i === 0 ? v : value?.FinancialYear0,
                                    FinancialYear1: i === 1 ? v : value?.FinancialYear1,
                                    FinancialYear2: i === 2 ? v : value?.FinancialYear2,
                                    FinancialYear3: i === 3 ? v : value?.FinancialYear3,
                                    FinancialYear4: i === 4 ? v : value?.FinancialYear4
                                })}
                            />
                        </div>
                    ) ||
                        <Text>No spend/income profile entered</Text>
                    }
                </div>
            </div>
            {errorMessage &&
                <FieldErrorMessage value={errorMessage} />
            }
        </div>
    );
};