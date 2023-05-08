import React, { useCallback, useContext, useEffect, useState } from 'react';
import { DateService, LookupService } from '../../services';
import { ISignOff, IDirectorate, IProject, IPartnerOrganisation, IBaseComponentProps } from '../../types';
import styles from '../../styles/cr.module.scss';
import { format, sub } from 'date-fns';
import { SignOffReview } from './SignOffReview';
import { SignOffType } from '../../refData/SignOffType';
import { CrLoadingOverlay } from '../cr/CrLoadingOverlay';
import { SignOffSelector } from '../SignOffSelector';
import { DataContext } from '../DataContext';

export const SignOffReviewList = (props: IBaseComponentProps): React.ReactElement => {
    const { errorHandling: { onError }, isFullPage } = props;
    const { dataServices: { signOffService, directorateService, projectService, partnerOrganisationService } } = useContext(DataContext);
    const [loading, setLoading] = useState(false);
    const [selectedReport, setSelectedReport] = useState<{ type: SignOffType, entity: number, report: number }>({ type: null, entity: null, report: null });
    const [reportEntitySignOffs, setReportEntitySignOffs] = useState<ISignOff[]>([]);
    const [reportEntities, setReportEntities] = useState<{ directorates: IDirectorate[], projects: IProject[], partnerOrgs: IPartnerOrganisation[] }>({ directorates: [], projects: [], partnerOrgs: [] });

    const logError = useCallback(onError, [onError]);

    useEffect(() => {
        const loadReportEntities = async () => {
            const [directorates, projects, partnerOrgs] = await Promise.all([
                directorateService.readAllForLookup(),
                projectService.readAllForLookup(),
                partnerOrganisationService.readAllForLookup()
            ]);
            setReportEntities({ directorates: directorates, projects: projects, partnerOrgs: partnerOrgs });

            // If only one report entity of any type, select it automatically
            if (directorates && projects && partnerOrgs) {
                if (directorates.length === 1 && projects.length === 0 && partnerOrgs.length === 0)
                    setSelectedReport({ type: SignOffType.Directorate, entity: directorates[0].ID, report: null });
                if (directorates.length === 0 && projects.length === 1 && partnerOrgs.length === 0)
                    setSelectedReport({ type: SignOffType.Project, entity: projects[0].ID, report: null });
                if (directorates.length === 0 && projects.length === 0 && partnerOrgs.length === 1)
                    setSelectedReport({ type: SignOffType.PartnerOrganisation, entity: partnerOrgs[0].ID, report: null });
            }
        };
        loadReportEntities();
    }, [directorateService, partnerOrganisationService, projectService]);

    useEffect(() => {
        // If only one report entity of selected type, select it automatically
        if (reportEntities.directorates && reportEntities.projects && reportEntities.partnerOrgs) {
            if (selectedReport.type === SignOffType.Directorate && reportEntities.directorates.length === 1)
                setSelectedReport({ type: SignOffType.Directorate, entity: reportEntities.directorates[0].ID, report: null });
            if (selectedReport.type === SignOffType.Project && reportEntities.projects.length === 1)
                setSelectedReport({ type: SignOffType.Project, entity: reportEntities.projects[0].ID, report: null });
            if (selectedReport.type === SignOffType.PartnerOrganisation && reportEntities.partnerOrgs.length === 1)
                setSelectedReport({ type: SignOffType.PartnerOrganisation, entity: reportEntities.partnerOrgs[0].ID, report: null });
        }
    }, [reportEntities.directorates, reportEntities.projects, reportEntities.partnerOrgs, selectedReport.type]);

    useEffect(() => {
        const loadReportEntitySignOffs = async () => {
            if (selectedReport.type && selectedReport.entity) {
                try {
                    setLoading(true);
                    const sixMonthsAgo = sub(new Date(), { months: 6 });
                    if (selectedReport.type === SignOffType.Directorate) {
                        setReportEntitySignOffs(await signOffService.readDirectorateReportsSince(selectedReport.entity, sixMonthsAgo));
                    }
                    if (selectedReport.type === SignOffType.Project) {
                        setReportEntitySignOffs(await signOffService.readProjectReportsSince(selectedReport.entity, sixMonthsAgo));
                    }
                    if (selectedReport.type === SignOffType.PartnerOrganisation) {
                        setReportEntitySignOffs(await signOffService.readPartnerOrganisationReportsSince(selectedReport.entity, sixMonthsAgo));
                    }
                } catch (err) {
                    logError(`Error loading sign-offs`, err.message);
                } finally { setLoading(false); }
            }
        };
        loadReportEntitySignOffs();
    }, [signOffService, selectedReport.type, selectedReport.entity, logError]);

    const selectedSignOff = reportEntitySignOffs.find(so => so.ID === selectedReport.report);

    return (
        <div className={`${styles.cr} ${isFullPage ? styles.crFullPage : ''}`} style={{ position: 'relative' }}>
            <CrLoadingOverlay isLoading={loading} opaque={true} />
            <SignOffSelector
                {...props}
                reportType={selectedReport.type}
                reportEntityId={selectedReport.entity}
                reportId={selectedReport.report}
                directorates={LookupService.entitiesToSelectableOptions(reportEntities.directorates)}
                partnerOrganisations={LookupService.entitiesToSelectableOptions(reportEntities.partnerOrgs)}
                projects={LookupService.entitiesToSelectableOptions(reportEntities.projects)}
                risks={[]} // Risk reports are viewed in Risk Register
                reports={reportEntitySignOffs.length === 0 ? [{ key: null, text: 'There are no reports in the last six month' }]
                    : LookupService.entitiesToSelectableOptions(reportEntitySignOffs, { optionText: e => format(e.ReportMonth, DateService.ukLongDateFormat) })}
                onChangeType={t => setSelectedReport({ type: t, entity: null, report: null })}
                onChangeEntity={e => setSelectedReport(s => ({ ...s, entity: e, report: null }))}
                onChangeReport={r => setSelectedReport(s => ({ ...s, report: r }))}
            />
            <div data-is-scrollable={props.isFullPage ? 'true' : 'false'} className={styles.crFullPageContentWithCommandBar}>
                <SignOffReview
                    {...props}
                    signOffId={selectedReport?.report}
                    reportPeriod={selectedSignOff?.ReportMonth}
                    directorateId={selectedSignOff?.DirectorateID}
                    projectId={selectedSignOff?.ProjectID}
                    partnerOrganisationId={selectedSignOff?.PartnerOrganisationID}
                />
            </div>
        </div>
    );
};
