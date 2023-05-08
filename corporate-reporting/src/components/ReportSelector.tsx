import React from 'react';
import styles from '../styles/cr.module.scss';
import { Period } from '../refData/Period';
import { IWebPartComponentProps } from '../types';
import { IWithErrorHandlingProps } from './withErrorHandling';
import { CrUpdatePeriodPicker } from './cr/CrUpdatePeriodPicker';
import { CrDropdown } from './cr/CrDropdown';
import { SignOffType } from '../refData/SignOffType';
import { IDropdownOption } from 'office-ui-fabric-react';
import { ReportTypeSelector } from './ReportTypeSelector';

export interface IReportSelectorProps extends IWebPartComponentProps, IWithErrorHandlingProps {
    reportPeriod: Period;
    reportType: SignOffType;
    reportEntityId: number;
    directorates: IDropdownOption[];
    partnerOrganisations: IDropdownOption[];
    projects: IDropdownOption[];
    risks: IDropdownOption[];
    financialRisks: IDropdownOption[];
    onChangePeriod: (period: Period) => void;
    onChangeType: (type: SignOffType) => void;
    onChangeEntity: (entityId: number) => void;
}

export const ReportSelector = (props: IReportSelectorProps): React.ReactElement => {
    const { reportPeriod, reportType, reportEntityId, directorates, partnerOrganisations, projects, risks, financialRisks } = props;

    const typeOptions = [
        directorates?.length > 0 && SignOffType.Directorate,
        projects?.length > 0 && SignOffType.Project,
        partnerOrganisations?.length > 0 && SignOffType.PartnerOrganisation,
        risks?.length > 0 && SignOffType.Risk,
        financialRisks?.length > 0 && SignOffType.FinancialRisk
    ].filter(t => t);

    let entityOptions: IDropdownOption[] = [];
    if (reportType === SignOffType.Project) entityOptions = projects;
    if (reportType === SignOffType.Directorate) entityOptions = directorates;
    if (reportType === SignOffType.PartnerOrganisation) entityOptions = partnerOrganisations;
    if (reportType === SignOffType.Risk) entityOptions = risks;
    if (reportType === SignOffType.FinancialRisk) entityOptions = financialRisks;

    return (
        <div className={styles.grid}>
            <div className={`${styles.gridRow} ${styles.crCommandBar} ${styles.crCommandBarFloating}`}>
                <div className={`${styles.gridCol} ${styles.sm12} ${styles.xl4}`}>
                    <CrUpdatePeriodPicker
                        value={reportPeriod}
                        onChange={props.onChangePeriod}
                    />
                </div>
                <div className={`${styles.gridCol} ${styles.sm12} ${styles.xl4}`}>
                    {directorates?.length + partnerOrganisations?.length + projects?.length + risks?.length + financialRisks?.length !== 1 &&
                        <ReportTypeSelector
                            className={styles.commandBarDropdown}
                            placeholder="1. Select report type"
                            types={typeOptions}
                            selectedType={reportType}
                            onChange={props.onChangeType}
                        />
                    }
                </div>
                <div className={`${styles.gridCol} ${styles.sm12} ${styles.xl4}`}>
                    {directorates?.length + partnerOrganisations?.length + projects?.length + risks?.length + financialRisks?.length !== 1 &&
                        <CrDropdown
                            className={styles.commandBarDropdown}
                            options={entityOptions}
                            selectedKey={reportEntityId}
                            onChange={(_, o) => props.onChangeEntity(Number(o.key))}
                            placeholder="2. Select report subject"
                        />
                    }
                </div>
            </div>
        </div>
    );
};
