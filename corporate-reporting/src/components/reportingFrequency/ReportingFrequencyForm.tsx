import React, { useContext } from 'react';
import { IEntityValidations, EntityValidations, ISpecificEntityFormProps, IReportingFrequency } from '../../types';
import styles from '../../styles/cr.module.scss';
import { CrTextField } from '../cr/CrTextField';
import { EntityForm } from '../EntityForm';
import { Text } from 'office-ui-fabric-react';
import { ReportingFrequency } from '../../refData/ReportingFrequency';
import { CrSlider } from '../cr/CrSlider';
import { DataContext } from '../DataContext';

export const ReportingFrequencyForm = (props: ISpecificEntityFormProps): React.ReactElement => {
    const { dataServices: { reportingFrequencyService } } = useContext(DataContext);
    return (
        <EntityForm<IReportingFrequency, IEntityValidations>
            {...props}
            entityName="Reporting frequency"
            renderFormFields={(changeHandlers, formState) => {
                const { FormData: reportingFrequency } = formState;
                return (
                    <div>
                        <CrTextField
                            label="Name"
                            className={styles.formField}
                            value={reportingFrequency.Title}
                            disabled={true}
                        />
                        <div className={styles.formField}>
                            <CrSlider
                                label="Time before report is due to send reminders to authors"
                                min={0}
                                max={31}
                                valueFormat={v => `${v} days`}
                                value={reportingFrequency.RemindAuthorsDaysBeforeDue}
                                onChange={v => changeHandlers.changeNumberField(v, 'RemindAuthorsDaysBeforeDue')}
                            />
                            <Text>Set to 0 days if you do not want reminders for this reporting frequency</Text>
                        </div>
                        <div className={styles.formField}>
                            <CrSlider
                                label="Time before report is due to send reminders to approvers"
                                min={0}
                                max={31}
                                valueFormat={v => `${v} days`}
                                value={reportingFrequency.RemindApproverDaysBeforeDue}
                                onChange={v => changeHandlers.changeNumberField(v, 'RemindApproverDaysBeforeDue')}
                            />
                            <Text>Set to 0 days if you do not want reminders for this reporting frequency</Text>
                        </div>
                        <div className={styles.formField}>
                            <CrSlider
                                label="Time into a reporting period to warn users that their update is early"
                                min={0}
                                max={reportingFrequency.ID === ReportingFrequency.Weekly ? 6
                                    : reportingFrequency.ID === ReportingFrequency.Fortnightly ? 13
                                        : reportingFrequency.ID === ReportingFrequency.Monthly ? 27
                                            : reportingFrequency.ID === ReportingFrequency.MonthlyWeekday ? 27
                                                : reportingFrequency.ID === ReportingFrequency.Quarterly ? 85
                                                    : reportingFrequency.ID === ReportingFrequency.Biannually ? 180
                                                        : 360}
                                valueFormat={v => `${v} days`}
                                value={reportingFrequency.EarlyUpdateWarningDays}
                                onChange={v => changeHandlers.changeNumberField(v, 'EarlyUpdateWarningDays')}
                            />
                            <Text>Set to 0 days if a warning should never be shown</Text>
                        </div>
                    </div>
                );
            }}
            loadEntity={id => reportingFrequencyService.read(id, true, true)}
            loadNewEntity={() => ({ ID: null, Title: '', RemindAuthorsDaysBeforeDue: null, RemindApproverDaysBeforeDue: null, EarlyUpdateWarningDays: null })}
            loadEntityValidations={() => new EntityValidations()}
            onCreate={rf => reportingFrequencyService.create(rf)}
            onUpdate={rf => reportingFrequencyService.update(rf.ID, rf)}
        />
    );
};
