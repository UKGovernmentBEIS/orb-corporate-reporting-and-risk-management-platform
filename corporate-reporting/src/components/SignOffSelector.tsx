import React from 'react';
import styles from '../styles/cr.module.scss';
import { IWebPartComponentProps } from '../types';
import { IWithErrorHandlingProps } from './withErrorHandling';
import { CrDropdown } from './cr/CrDropdown';
import { SignOffType } from '../refData/SignOffType';
import { IDropdownOption } from 'office-ui-fabric-react';
import { ReportTypeSelector } from './ReportTypeSelector';

interface ISignOffSelectorProps extends IWebPartComponentProps, IWithErrorHandlingProps {
    reportType: SignOffType;
    reportEntityId: number;
    reportId: number;
    directorates: IDropdownOption[];
    partnerOrganisations: IDropdownOption[];
    projects: IDropdownOption[];
    risks: IDropdownOption[];
    reports: IDropdownOption[];
    onChangeType: (type: SignOffType) => void;
    onChangeEntity: (entityId: number) => void;
    onChangeReport: (reportId: number) => void;
}

export const SignOffSelector = (props: ISignOffSelectorProps): React.ReactElement => {
    const { reportType, reportEntityId, reportId, directorates, partnerOrganisations, projects, risks, reports } = props;

    const typeOptions = [
        directorates?.length > 0 && SignOffType.Directorate,
        projects?.length > 0 && SignOffType.Project,
        partnerOrganisations?.length > 0 && SignOffType.PartnerOrganisation,
        risks?.length > 0 && SignOffType.Risk
    ].filter(t => t);

    let entityOptions: IDropdownOption[] = [];
    if (reportType === SignOffType.Project) entityOptions = projects;
    if (reportType === SignOffType.Directorate) entityOptions = directorates;
    if (reportType === SignOffType.PartnerOrganisation) entityOptions = partnerOrganisations;
    if (reportType === SignOffType.Risk) entityOptions = risks;

    const userHasSingleOption = directorates.length + partnerOrganisations.length + projects.length + risks.length === 1;

    return (
        <div className={styles.grid}>
            <div className={`${styles.gridRow} ${styles.crCommandBar}`}>
                <div className={`${styles.gridCol} ${styles.sm12} ${styles.xl4}`}>
                    <ReportTypeSelector
                        className={styles.commandBarDropdown}
                        disabled={userHasSingleOption}
                        placeholder="1. Select report type"
                        types={typeOptions}
                        selectedType={reportType}
                        onChange={props.onChangeType}
                    />
                </div>
                <div className={`${styles.gridCol} ${styles.sm12} ${styles.xl4}`}>
                    <CrDropdown
                        className={styles.commandBarDropdown}
                        disabled={userHasSingleOption}
                        options={entityOptions}
                        selectedKey={reportEntityId}
                        onChange={(_, o) => props.onChangeEntity(Number(o.key))}
                        placeholder="2. Select report subject"
                    />
                </div>
                <div className={`${styles.gridCol} ${styles.sm12} ${styles.xl4}`}>
                    <CrDropdown
                        className={styles.commandBarDropdown}
                        options={reports}
                        selectedKey={reportId}
                        onChange={(_, o) => props.onChangeReport(Number(o.key))}
                        placeholder={userHasSingleOption ? "Select a report" : "3. Select a report"}
                    />
                </div>
            </div>
        </div>
    );
};
