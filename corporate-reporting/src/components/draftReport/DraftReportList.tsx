import React, { useCallback, useContext, useEffect, useState } from 'react';
import styles from '../../styles/cr.module.scss';
import { LookupService } from '../../services';
import {
    IProject, IDirectorate, IPartnerOrganisation, IRisk,
    IReportDueDates, ReportDueDates, IFinancialRisk, IBaseComponentProps
} from '../../types';
import { SignOffType } from '../../refData/SignOffType';
import { DraftReportBuilder } from './DraftReportBuilder';
import { DropdownMenuItemType, IDropdownOption } from 'office-ui-fabric-react/lib/Dropdown';
import { CrLoadingOverlay } from '../cr/CrLoadingOverlay';
import { Period } from '../../refData/Period';
import { ReportSelector } from '../ReportSelector';
import { DataContext } from '../DataContext';

interface IDraftReportListProps extends IBaseComponentProps {
    emphasiseProjectsWithAttribute: string;
    emphasisedProjectsHeaderText: string;
    otherProjectsHeaderText: string;
}

export const DraftReportList = (props: IDraftReportListProps): React.ReactElement => {
    const { errorHandling: { onError } } = props;
    const { dataServices: { directorateService, projectService, partnerOrganisationService,
        corporateRiskService, financialRiskService, reportDueDatesService } } = useContext(DataContext);
    const [loading, setLoading] = useState(false);
    const [directorates, setDirectorates] = useState<IDirectorate[]>();
    const [projects, setProjects] = useState<IProject[]>();
    const [partnerOrgs, setPartnerOrgs] = useState<IPartnerOrganisation[]>();
    const [risks, setRisks] = useState<IRisk[]>();
    const [financialRisks, setFinancialRisks] = useState<IFinancialRisk[]>();
    const [period, setPeriod] = useState<Period>(Period.Current);
    const [report, setReport] = useState<{ type: SignOffType, entityId: number }>({ type: null, entityId: null });
    const [reportDates, setReportDates] = useState<IReportDueDates>(new ReportDueDates);
    const logError = useCallback(onError, [onError]);

    useEffect(() => {
        const loadEntities = async () => {
            setLoading(true);
            try {
                const proms = [
                    directorateService.readDraftReportDirectorates().then(setDirectorates),
                    projectService.readDraftReportProjects().then(setProjects),
                    partnerOrganisationService.readDraftReportPartnerOrganisations().then(setPartnerOrgs),
                    corporateRiskService.readDraftReportRisks().then(setRisks),
                    financialRiskService.readDraftReportRisks().then(setFinancialRisks)
                ];
                await Promise.all(proms);
            } catch (err) {
                logError(`Error loading draft report entities`, err.message);
            } finally {
                setLoading(false);
            }
        };
        loadEntities();
    }, [directorateService, projectService, partnerOrganisationService, corporateRiskService, financialRiskService, logError]);

    useEffect(() => {
        const loadReportDates = async () => {
            if (period && report.type && report.entityId) {
                setLoading(true);
                try {
                    if (report.type === SignOffType.Directorate) {
                        setReportDates(await reportDueDatesService.getDirectorateReportDueDates(report.entityId, new Date, period));
                    }
                    if (report.type === SignOffType.Project) {
                        setReportDates(await reportDueDatesService.getProjectReportDueDates(report.entityId, new Date, period));
                    }
                    if (report.type === SignOffType.PartnerOrganisation) {
                        setReportDates(await reportDueDatesService.getPartnerOrganisationReportDueDates(report.entityId, new Date, period));
                    }
                    if (report.type === SignOffType.Risk) {
                        const risk = risks.find(r => r.ID === report.entityId);
                        setReportDates(await reportDueDatesService.getDirectorateReportDueDates(risk.DirectorateID, new Date, period));
                    }
                    if (report.type === SignOffType.FinancialRisk) {
                        setReportDates(await reportDueDatesService.getFinancialRiskReportDueDates(report.entityId, new Date, period));
                    }
                } catch (err) {
                    logError(`Error loading report dates`, err);
                }
                finally { setLoading(false); }
            }
        };
        loadReportDates();
    }, [period, report.type, report.entityId, reportDueDatesService, risks, logError]);

    useEffect(() => {
        // If the user can access only one report, display it instead of showing the choices
        if (directorates && projects && partnerOrgs && risks && financialRisks) {
            if (directorates.length === 1 && projects.length === 0 && partnerOrgs.length === 0 && risks.length === 0 && financialRisks.length === 0) {
                setReport({ type: SignOffType.Directorate, entityId: directorates[0].ID });
            }
            if (directorates.length === 0 && projects.length === 1 && partnerOrgs.length === 0 && risks.length === 0 && financialRisks.length === 0) {
                setReport({ type: SignOffType.Project, entityId: projects[0].ID });
            }
            if (directorates.length === 0 && projects.length === 0 && partnerOrgs.length === 1 && risks.length === 0 && financialRisks.length === 0) {
                setReport({ type: SignOffType.PartnerOrganisation, entityId: partnerOrgs[0].ID });
            }
            if (directorates.length === 0 && projects.length === 0 && partnerOrgs.length === 0 && risks.length === 1 && financialRisks.length === 0) {
                setReport({ type: SignOffType.Risk, entityId: risks[0].ID });
            }
            if (directorates.length === 0 && projects.length === 0 && partnerOrgs.length === 0 && risks.length === 0 && financialRisks.length === 1) {
                setReport({ type: SignOffType.FinancialRisk, entityId: financialRisks[0].ID });
            }
        }
    }, [directorates, projects, partnerOrgs, risks, financialRisks]);

    useEffect(() => {
        // If only one report of type, select it automatically
        if (directorates && projects && partnerOrgs && risks) {
            if (report.type === SignOffType.Directorate && directorates.length === 1)
                setReport({ type: SignOffType.Directorate, entityId: directorates[0].ID });
            if (report.type === SignOffType.Project && projects.length === 1)
                setReport({ type: SignOffType.Project, entityId: projects[0].ID });
            if (report.type === SignOffType.PartnerOrganisation && partnerOrgs.length === 1)
                setReport({ type: SignOffType.PartnerOrganisation, entityId: partnerOrgs[0].ID });
            if (report.type === SignOffType.Risk && risks.length === 1)
                setReport({ type: SignOffType.Risk, entityId: risks[0].ID });
            if (report.type === SignOffType.FinancialRisk && financialRisks.length === 1) {
                setReport({ type: SignOffType.FinancialRisk, entityId: financialRisks[0].ID });
            }
        }
    }, [directorates, projects, partnerOrgs, risks, financialRisks, report.type]);

    const projectOptions = (): IDropdownOption[] => {
        if (projects) {
            const { emphasiseProjectsWithAttribute, emphasisedProjectsHeaderText, otherProjectsHeaderText } = props;
            const newProjectOptions: IDropdownOption[] = [];
            if (emphasiseProjectsWithAttribute) {
                const emphasisedProjects = projects
                    .filter(p => p.Attributes.filter(pa => pa.AttributeType.Title === emphasiseProjectsWithAttribute).length === 1);
                if (emphasisedProjects.length > 0) {
                    newProjectOptions.push({ key: 'emphasisedProjectsHeader', text: emphasisedProjectsHeaderText, itemType: DropdownMenuItemType.Header });
                    newProjectOptions.push(...LookupService.entitiesToSelectableOptions(emphasisedProjects));
                    newProjectOptions.push({ key: 'emphasisedProjectsDivider', text: '-', itemType: DropdownMenuItemType.Divider });
                    newProjectOptions.push({ key: 'otherProjectsHeader', text: otherProjectsHeaderText, itemType: DropdownMenuItemType.Header });
                }
            }
            const otherProjects = projects.filter(p => p.Attributes
                .filter(pa => pa.AttributeType.Title === emphasiseProjectsWithAttribute).length === 0);
            newProjectOptions.push(...LookupService.entitiesToSelectableOptions(otherProjects));
            return newProjectOptions;
        } return [];
    };

    return (
        <div className={`${styles.cr} ${styles.crList}`}>
            <CrLoadingOverlay isLoading={loading} />
            <ReportSelector
                {...props}
                reportPeriod={period}
                reportType={report.type}
                reportEntityId={report.entityId}
                directorates={LookupService.entitiesToSelectableOptions(directorates)}
                partnerOrganisations={LookupService.entitiesToSelectableOptions(partnerOrgs)}
                projects={projectOptions()}
                risks={LookupService.entitiesToSelectableOptions(risks, { optionText: r => `${r.RiskCode} - ${r.Title}` })}
                financialRisks={LookupService.entitiesToSelectableOptions(financialRisks, { optionText: r => `${r.RiskCode} - ${r.Title}` })}
                onChangePeriod={setPeriod}
                onChangeType={t => setReport({ type: t, entityId: null })}
                onChangeEntity={e => setReport(r => ({ ...r, entityId: e }))}
            />
            <DraftReportBuilder
                {...props}
                signOffType={report.type}
                signOffEntityId={report.entityId}
                period={period}
                reportDates={reportDates}
            />
        </div>
    );
};
