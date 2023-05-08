import React, { useCallback, useContext, useEffect, useState } from 'react';
import { LookupService } from '../../services';
import {
    IProject, IDirectorate, IPartnerOrganisation, IRisk,
    IReportDueDates, ReportDueDates, IFinancialRisk, IBaseComponentProps
} from '../../types';
import styles from '../../styles/cr.module.scss';
import { SignOffType } from '../../refData/SignOffType';
import { SignOffBuilder } from './SignOffBuilder';
import { CrLoadingOverlay } from '../cr/CrLoadingOverlay';
import { Period } from '../../refData/Period';
import { ReportSelector } from '../ReportSelector';
import { DataContext } from '../DataContext';

export const SignOffList = (props: IBaseComponentProps): React.ReactElement => {
    const { errorHandling: { onError } } = props;
    const { dataServices: { directorateService, projectService, partnerOrganisationService,
        corporateRiskService, financialRiskService, reportDueDatesService } } = useContext(DataContext);
    const [loading, setLoading] = useState(false);
    const [directorates, setDirectorates] = useState<IDirectorate[]>(null);
    const [projects, setProjects] = useState<IProject[]>(null);
    const [partnerOrgs, setPartnerOrgs] = useState<IPartnerOrganisation[]>(null);
    const [risks, setRisks] = useState<IRisk[]>(null);
    const [financialRisks, setFinancialRisks] = useState<IFinancialRisk[]>(null);
    const [selectedSignOff, setSelectedSignOff] = useState<{ type: SignOffType, id: number }>({ type: null, id: null });
    const [selectedReportPeriod, setSelectedReportPeriod] = useState<Period>(Period.Current);
    const [selectedSignOffDates, setSelectedSignOffDates] = useState<IReportDueDates>(new ReportDueDates);

    const logError = useCallback(onError, [onError]);

    useEffect(() => {
        const loadSignOffs = async (): Promise<void> => {
            setLoading(true);
            try {
                await Promise.all([
                    directorateService.readMyDirectorates().then(setDirectorates),
                    projectService.readMyProjects().then(setProjects),
                    partnerOrganisationService.readMyPartnerOrganisations().then(setPartnerOrgs),
                    corporateRiskService.readMyRisks().then(setRisks),
                    financialRiskService.readMyRisks().then(setFinancialRisks)
                ]);
            } catch (err) {
                logError(`Error loading sign off options`, err.message);
            } finally {
                setLoading(false);
            }
        };
        loadSignOffs();
    }, [directorateService, projectService, partnerOrganisationService, corporateRiskService, financialRiskService, logError]);

    useEffect(() => {
        // If only one report of any type, select it automatically
        if (directorates && projects && partnerOrgs && risks && financialRisks) {
            if (directorates.length === 1 && projects.length === 0 && partnerOrgs.length === 0 && risks.length === 0 && financialRisks.length === 0)
                setSelectedSignOff({ type: SignOffType.Directorate, id: directorates[0].ID });
            if (directorates.length === 0 && projects.length === 1 && partnerOrgs.length === 0 && risks.length === 0 && financialRisks.length === 0)
                setSelectedSignOff({ type: SignOffType.Project, id: projects[0].ID });
            if (directorates.length === 0 && projects.length === 0 && partnerOrgs.length === 1 && risks.length === 0 && financialRisks.length === 0)
                setSelectedSignOff({ type: SignOffType.PartnerOrganisation, id: partnerOrgs[0].ID });
            if (directorates.length === 0 && projects.length === 0 && partnerOrgs.length === 0 && risks.length === 1 && financialRisks.length === 0)
                setSelectedSignOff({ type: SignOffType.Risk, id: risks[0].ID });
            if (directorates.length === 0 && projects.length === 0 && partnerOrgs.length === 0 && risks.length === 0 && financialRisks.length === 1)
                setSelectedSignOff({ type: SignOffType.FinancialRisk, id: financialRisks[0].ID });
        }
    }, [directorates, projects, partnerOrgs, risks, financialRisks]);

    useEffect(() => {
        // If only one report of type, select it automatically
        if (directorates && projects && partnerOrgs && risks && financialRisks) {
            if (selectedSignOff.type === SignOffType.Directorate && directorates.length === 1)
                setSelectedSignOff({ type: SignOffType.Directorate, id: directorates[0].ID });
            if (selectedSignOff.type === SignOffType.Project && projects.length === 1)
                setSelectedSignOff({ type: SignOffType.Project, id: projects[0].ID });
            if (selectedSignOff.type === SignOffType.PartnerOrganisation && partnerOrgs.length === 1)
                setSelectedSignOff({ type: SignOffType.PartnerOrganisation, id: partnerOrgs[0].ID });
            if (selectedSignOff.type === SignOffType.Risk && risks.length === 1)
                setSelectedSignOff({ type: SignOffType.Risk, id: risks[0].ID });
            if (selectedSignOff.type === SignOffType.FinancialRisk && financialRisks.length === 1)
                setSelectedSignOff({ type: SignOffType.FinancialRisk, id: financialRisks[0].ID });
        }
    }, [directorates, projects, partnerOrgs, risks, financialRisks, selectedSignOff.type]);

    useEffect(() => {
        const getReportDates = async () => {
            if (selectedSignOff.type === SignOffType.Directorate) {
                setSelectedSignOffDates(await reportDueDatesService.getDirectorateReportDueDates(selectedSignOff.id, new Date(), selectedReportPeriod));
            }
            if (selectedSignOff.type === SignOffType.Project) {
                setSelectedSignOffDates(await reportDueDatesService.getProjectReportDueDates(selectedSignOff.id, new Date(), selectedReportPeriod));
            }
            if (selectedSignOff.type === SignOffType.PartnerOrganisation) {
                setSelectedSignOffDates(await reportDueDatesService.getPartnerOrganisationReportDueDates(selectedSignOff.id, new Date(), selectedReportPeriod));
            }
            if (selectedSignOff.type === SignOffType.Risk && risks) {
                const risk = risks.find(r => r.ID === selectedSignOff.id);
                if (risk) {
                    setSelectedSignOffDates(await reportDueDatesService.getDirectorateReportDueDates(risk.DirectorateID, new Date(), selectedReportPeriod));
                }
            }
            if (selectedSignOff.type === SignOffType.FinancialRisk) {
                setSelectedSignOffDates(await reportDueDatesService.getFinancialRiskReportDueDates(selectedSignOff.id, new Date(), selectedReportPeriod));
            }
        };
        getReportDates();
    }, [selectedSignOff.type, selectedSignOff.id, selectedReportPeriod, risks, reportDueDatesService]);

    return (
        <div className={`${styles.cr} ${styles.crList}`}>
            <CrLoadingOverlay isLoading={loading} opaque={true} />
            <ReportSelector
                {...props}
                reportPeriod={selectedReportPeriod}
                reportType={selectedSignOff.type}
                reportEntityId={selectedSignOff.id}
                directorates={LookupService.entitiesToSelectableOptions(directorates)}
                partnerOrganisations={LookupService.entitiesToSelectableOptions(partnerOrgs)}
                projects={LookupService.entitiesToSelectableOptions(projects)}
                risks={LookupService.entitiesToSelectableOptions(risks, { optionText: r => `${r.RiskCode} - ${r.Title}` })}
                financialRisks={LookupService.entitiesToSelectableOptions(financialRisks, { optionText: r => `${r.RiskCode} - ${r.Title}` })}
                onChangePeriod={setSelectedReportPeriod}
                onChangeType={t => setSelectedSignOff({ type: t, id: null })}
                onChangeEntity={e => setSelectedSignOff(sso => ({ type: sso.type, id: e }))}
            />
            <SignOffBuilder
                {...props}
                signOffType={selectedSignOff.type}
                signOffEntityId={selectedSignOff.id}
                period={selectedReportPeriod}
                reportDates={selectedSignOffDates}
            />
        </div>
    );
};
