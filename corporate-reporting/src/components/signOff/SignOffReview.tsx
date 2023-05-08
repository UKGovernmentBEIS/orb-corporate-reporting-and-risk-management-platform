import React, { useCallback, useContext, useEffect, useState } from 'react';
import { ISignOff, IBaseComponentProps, IReportingEntity, ListDefaults, IMetricUpdate, IBenefitUpdate } from '../../types';
import styles from '../../styles/cr.module.scss';
import { DirectorateProgressUpdateReviewList } from '../directorate/DirectorateProgressUpdateReviewList';
import { ProjectProgressUpdateReviewList } from '../project/ProjectProgressUpdateReviewList';
import { PartnerOrganisationProgressUpdateReviewList } from '../partnerOrganisation/PartnerOrganisationProgressUpdateReviewList';
import { CrApprovalDetails } from '../cr/CrApprovalDetails';
import { PartnerOrganisationRiskProgressUpdateReviewList } from '../partnerOrganisationRisk/PartnerOrganisationRiskProgressUpdateReviewList';
import { CrExpandableTextDisplay } from '../cr/CrExpandableTextDisplay';
import { KeyWorkAreaProgressUpdateReviewList } from '../keyWorkArea/KeyWorkAreaProgressUpdateReviewList';
import { WorkStreamProgressUpdateReviewList } from '../workStream/WorkStreamProgressUpdateReviewList';
import { MilestoneProgressUpdateReviewList } from '../milestone/MilestoneProgressUpdateReviewList';
import { MetricProgressUpdateReviewList } from '../metric/MetricProgressUpdateReviewList';
import { CommitmentProgressUpdateReviewList } from '../commitment/CommitmentProgressUpdateReviewList';
import { BenefitProgressUpdateReviewList } from '../benefit/BenefitProgressUpdateReviewList';
import { DependencyProgressUpdateReviewList } from '../dependency/DependencyProgressUpdateReviewList';
import { ProjectProgressUpdateSummaryReviewList } from '../project/ProjectProgressUpdateSummaryReviewList';
import { EntityStatus } from '../../refData/EntityStatus';
import { ReportingEntityProgressUpdateReviewList } from '../reportingEntities/ReportingEntityProgressUpdateReviewList';
import { ReportTypes } from '../../refData/ReportTypes';
import { OrbUserContext } from '../OrbUserContext';
import { DataContext } from '../DataContext';
import { CrReportShimmer } from '../cr/CrReportShimmer';
import { DraftReportHeader } from '../draftReport/DraftReportHeader';

export interface ISignOffBuilderProps extends IBaseComponentProps {
    signOffId: number;
    directorateId?: number;
    projectId?: number;
    partnerOrganisationId?: number;
    reportPeriod: Date;
}

export const SignOffReview = (props: ISignOffBuilderProps): React.ReactElement => {
    const { errorHandling: { onError }, signOffId, directorateId, projectId, partnerOrganisationId, reportPeriod } = props;
    const { userContext, userPermissions } = useContext(OrbUserContext);
    const { dataServices: { signOffService, benefitUpdateService, metricUpdateService } } = useContext(DataContext);
    const [loading, setLoading] = useState(false);
    const [signOff, setSignOff] = useState<ISignOff>(null);
    const [previousSignOff, setPreviousSignOff] = useState<ISignOff>(null);
    const [previousMetricUpdates, setPreviousMetricUpdates] = useState<IMetricUpdate[]>([]);
    const [previousBenefitUpdates, setPreviousBenefitUpdates] = useState<IBenefitUpdate[]>([]);

    const logError = useCallback(onError, [onError]);

    const isOpen = (entity: IReportingEntity, updatesProp: string): boolean => entity.EntityStatusID === EntityStatus.Open || entity[updatesProp]?.length > 0;

    useEffect(() => {
        const loadSignOffs = async (): Promise<void> => {
            if (signOffId) {
                setSignOff(null);
                setLoading(true);
                try {
                    const loadSignOff = signOffService.readSignOff(signOffId);
                    let loadPreviousSignOff: Promise<ISignOff>;
                    if (directorateId) {
                        loadPreviousSignOff = signOffService.readPreviousDirectorateSignOff(directorateId, reportPeriod);
                        const so = await loadSignOff, pso = await loadPreviousSignOff;
                        const prevMetricUpdates = await Promise.all(
                            so.Metrics.map(async metric => {
                                if (metric?.ID && pso?.ReportMonth) {
                                    return await metricUpdateService.readLastSignedOffUpdateBeforeDate(metric.ID, pso.ReportMonth);
                                }
                            })
                        );
                        setPreviousMetricUpdates(prevMetricUpdates.filter(u => u));
                    }
                    if (projectId) {
                        loadPreviousSignOff = signOffService.readPreviousProjectSignOff(projectId, reportPeriod);
                        const so = await loadSignOff, pso = await loadPreviousSignOff;
                        const prevBenefitUpdates = await Promise.all(
                            so.Benefits.map(async benefit => {
                                if (benefit?.ID && pso?.ReportMonth) {
                                    return await benefitUpdateService.readLastSignedOffUpdateBeforeDate(benefit.ID, pso.ReportMonth);
                                }
                            })
                        );
                        setPreviousBenefitUpdates(prevBenefitUpdates.filter(u => u));
                    }
                    if (partnerOrganisationId) {
                        loadPreviousSignOff = signOffService.readPreviousPartnerOrganisationSignOff(partnerOrganisationId, reportPeriod);
                    }

                    setSignOff(await loadSignOff);
                    setPreviousSignOff(await loadPreviousSignOff);
                } catch (err) {
                    logError(`Error loading completed report`, err.message);
                } finally {
                    setLoading(false);
                }
            }
        };

        loadSignOffs();
    }, [signOffId, reportPeriod, directorateId, projectId, partnerOrganisationId, signOffService, benefitUpdateService, metricUpdateService, logError]);

    const listConfig = { ...ListDefaults, placeholders: { dataMissing: '[Missing]', dataTBC: '[Not completed]' } };

    if (signOff?.DirectorateID) {
        return (
            <div className={styles.cr}>
                <CrApprovalDetails
                    approverName={signOff.SignOffUser?.Title}
                    approvalDate={signOff.SignOffDate}
                />
                <DraftReportHeader
                    title={signOff.Directorate?.Title}
                    reportDate={signOff.ReportMonth}
                    attributes={signOff.Directorate?.Attributes?.map(a => a.AttributeType)}
                />
                {signOff.Directorate?.Objectives &&
                    <CrExpandableTextDisplay
                        label="Directorate objectives"
                        largeLabel={true}
                        shortenedCharCount={250}
                        text={signOff.Directorate?.Objectives}
                    />
                }
                <DirectorateProgressUpdateReviewList
                    {...props}
                    directorateUpdate={signOff.Directorate?.DirectorateUpdates?.[0]}
                    readOnly={true}
                    reportDates={{ Next: signOff.ReportMonth, Previous: previousSignOff?.ReportMonth }}
                />
                {signOff?.ReportingEntityTypes?.filter(ret => ret.IsHeadlineSection).map(ret => ret?.ReportingEntities?.length > 0 &&
                    <ReportingEntityProgressUpdateReviewList
                        key={ret.ID}
                        {...props}
                        reportDates={{ Next: signOff.ReportMonth, Previous: previousSignOff?.ReportMonth }}
                        entities={ret?.ReportingEntities}
                        previousEntities={previousSignOff?.ReportingEntityTypes?.find(t => t.ID === ret.ID)?.ReportingEntities}
                        readOnly={true}
                        entityType={ret}
                    />
                )}
                <KeyWorkAreaProgressUpdateReviewList
                    {...props}
                    reportDates={{ Next: signOff.ReportMonth, Previous: previousSignOff?.ReportMonth }}
                    entities={signOff.KeyWorkAreas?.filter(k => isOpen(k, 'KeyWorkAreaUpdates'))} // For now, only show items open at time of report
                    previousEntities={previousSignOff?.KeyWorkAreas}
                    readOnly={true}
                    listConfig={listConfig}
                />
                <ProjectProgressUpdateSummaryReviewList
                    {...props}
                    listTitle="Project progress updates"
                    progressUpdateFormTitle="Edit project progress update"
                    reportDates={{ Next: signOff.ReportMonth, Previous: previousSignOff?.ReportMonth }}
                    entities={signOff.Projects?.filter(p => isOpen(p, 'ProjectUpdates'))}
                    previousEntities={previousSignOff?.Projects}
                    readOnly={true}
                    listConfig={listConfig}
                />
                <MetricProgressUpdateReviewList
                    {...props}
                    reportDates={{ Next: signOff.ReportMonth, Previous: previousSignOff?.ReportMonth }}
                    entities={signOff.Metrics?.filter(m => isOpen(m, 'MetricUpdates'))}
                    previousEntities={previousSignOff?.Metrics}
                    previousMetricUpdates={previousMetricUpdates}
                    readOnly={true}
                    listConfig={listConfig}
                />
                <MilestoneProgressUpdateReviewList
                    {...props}
                    reportDates={{ Next: signOff.ReportMonth, Previous: previousSignOff?.ReportMonth }}
                    entities={signOff.Milestones?.filter(m => isOpen(m, 'MilestoneUpdates'))}
                    previousEntities={previousSignOff?.Milestones}
                    readOnly={true}
                    listConfig={listConfig}
                    reportType={ReportTypes.Directorate}
                />
                <CommitmentProgressUpdateReviewList
                    {...props}
                    reportDates={{ Next: signOff.ReportMonth, Previous: previousSignOff?.ReportMonth }}
                    entities={signOff.Commitments?.filter(c => isOpen(c, 'CommitmentUpdates'))}
                    previousEntities={previousSignOff?.Commitments}
                    readOnly={true}
                    listConfig={listConfig}
                />
                {signOff?.ReportingEntityTypes?.filter(ret => !ret.IsHeadlineSection).map(ret => ret?.ReportingEntities?.length > 0 &&
                    <ReportingEntityProgressUpdateReviewList
                        key={ret.ID}
                        {...props}
                        reportDates={{ Next: signOff.ReportMonth, Previous: previousSignOff?.ReportMonth }}
                        entities={ret?.ReportingEntities}
                        previousEntities={previousSignOff?.ReportingEntityTypes?.find(t => t.ID === ret.ID)?.ReportingEntities}
                        readOnly={true}
                        entityType={ret}
                    />
                )}
            </div>
        );
    }
    if (signOff?.ProjectID) {
        return (
            <div className={styles.cr}>
                <CrApprovalDetails
                    approverName={signOff.SignOffUser?.Title}
                    approvalDate={signOff.SignOffDate}
                />
                <DraftReportHeader
                    title={signOff.Project?.Title}
                    reportDate={signOff.ReportMonth}
                    attributes={signOff?.Project?.Attributes?.map(a => a.AttributeType)}
                />
                {signOff?.Project?.Objectives &&
                    <CrExpandableTextDisplay
                        label="Project objectives"
                        largeLabel={true}
                        shortenedCharCount={250}
                        text={signOff?.Project?.Objectives}
                    />
                }
                <ProjectProgressUpdateReviewList
                    {...props}
                    projectUpdate={signOff?.Project?.ProjectUpdates?.[0]}
                    reportDates={{ Next: signOff.ReportMonth, Previous: previousSignOff?.ReportMonth }}
                    readOnly={true}
                />
                {signOff?.ReportingEntityTypes?.filter(ret => ret.IsHeadlineSection).map(ret => ret?.ReportingEntities?.length > 0 &&
                    <ReportingEntityProgressUpdateReviewList
                        key={ret.ID}
                        {...props}
                        reportDates={{ Next: signOff.ReportMonth, Previous: previousSignOff?.ReportMonth }}
                        entities={ret?.ReportingEntities}
                        previousEntities={previousSignOff?.ReportingEntityTypes?.find(t => t.ID === ret.ID)?.ReportingEntities}
                        readOnly={true}
                        entityType={ret}
                    />
                )}
                <WorkStreamProgressUpdateReviewList
                    {...props}
                    reportDates={{ Next: signOff.ReportMonth, Previous: previousSignOff?.ReportMonth }}
                    entities={signOff.WorkStreams?.filter(w => isOpen(w, 'WorkStreamUpdates'))}
                    previousEntities={previousSignOff?.WorkStreams}
                    readOnly={true}
                    listConfig={listConfig}
                />
                <BenefitProgressUpdateReviewList
                    {...props}
                    reportDates={{ Next: signOff.ReportMonth, Previous: previousSignOff?.ReportMonth }}
                    entities={signOff.Benefits?.filter(b => isOpen(b, 'BenefitUpdates'))}
                    previousEntities={previousSignOff?.Benefits}
                    previousBenefitUpdates={previousBenefitUpdates}
                    readOnly={true}
                    listConfig={listConfig}
                />
                <MilestoneProgressUpdateReviewList
                    {...props}
                    reportDates={{ Next: signOff.ReportMonth, Previous: previousSignOff?.ReportMonth }}
                    entities={signOff.Milestones?.filter(m => isOpen(m, 'MilestoneUpdates'))}
                    previousEntities={previousSignOff?.Milestones}
                    readOnly={true}
                    listConfig={listConfig}
                    reportType={ReportTypes.Project}
                />
                <DependencyProgressUpdateReviewList
                    {...props}
                    reportDates={{ Next: signOff.ReportMonth, Previous: previousSignOff?.ReportMonth }}
                    entities={signOff.Dependencies?.filter(d => isOpen(d, 'DependencyUpdates'))}
                    previousEntities={previousSignOff?.Dependencies}
                    readOnly={true}
                    listConfig={listConfig}
                />
                <ProjectProgressUpdateSummaryReviewList
                    {...props}
                    listTitle="Project progress updates"
                    progressUpdateFormTitle="Edit project progress update"
                    reportDates={{ Next: signOff.ReportMonth, Previous: previousSignOff?.ReportMonth }}
                    entities={signOff.Projects?.filter(p => isOpen(p, 'ProjectUpdates'))}
                    previousEntities={previousSignOff?.Projects}
                    readOnly={true}
                    listConfig={listConfig}
                />
                {signOff?.ReportingEntityTypes?.filter(ret => !ret.IsHeadlineSection).map(ret => ret?.ReportingEntities?.length > 0 &&
                    <ReportingEntityProgressUpdateReviewList
                        key={ret.ID}
                        {...props}
                        reportDates={{ Next: signOff.ReportMonth, Previous: previousSignOff?.ReportMonth }}
                        entities={ret?.ReportingEntities}
                        previousEntities={previousSignOff?.ReportingEntityTypes?.find(t => t.ID === ret.ID)?.ReportingEntities}
                        readOnly={true}
                        entityType={ret}
                    />
                )}
            </div>
        );
    }
    if (signOff?.PartnerOrganisationID) {
        const userPartnerOrg = userContext.UserEntities?.UserPartnerOrganisations?.find(upo => upo.PartnerOrganisationID === signOff.PartnerOrganisationID);

        return (
            <div className={styles.cr}>
                <CrApprovalDetails
                    approverName={signOff.SignOffUser?.Title}
                    approvalDate={signOff.SignOffDate}
                />
                <DraftReportHeader
                    title={signOff.PartnerOrganisation?.Title}
                    reportDate={signOff.ReportMonth}
                    attributes={signOff?.PartnerOrganisation?.Attributes?.map(a => a.AttributeType)}
                />
                {(userPermissions.UserIsPartnerOrganisationAdmin() || (userPartnerOrg && !userPartnerOrg.HideHeadlines)) &&
                    <PartnerOrganisationProgressUpdateReviewList
                        {...props}
                        reportDates={{ Next: signOff.ReportMonth, Previous: previousSignOff?.ReportMonth }}
                        partnerOrganisation={signOff.PartnerOrganisation}
                        partnerOrganisationUpdate={signOff.PartnerOrganisation?.PartnerOrganisationUpdates?.[0]}
                        readOnly={true}
                    />
                }
                {(userPermissions.UserIsPartnerOrganisationAdmin() || (userPartnerOrg && !userPartnerOrg.HideCustomSections)) &&
                    signOff?.ReportingEntityTypes?.filter(ret => ret.IsHeadlineSection).map(ret => ret?.ReportingEntities?.length > 0 &&
                        <ReportingEntityProgressUpdateReviewList
                            key={ret.ID}
                            {...props}
                            reportDates={{ Next: signOff.ReportMonth, Previous: previousSignOff?.ReportMonth }}
                            entities={ret?.ReportingEntities}
                            previousEntities={previousSignOff?.ReportingEntityTypes?.find(t => t.ID === ret.ID)?.ReportingEntities}
                            readOnly={true}
                            entityType={ret}
                        />
                    )
                }
                {(userPermissions.UserIsPartnerOrganisationAdmin() || (userPartnerOrg && !userPartnerOrg.HideMilestones)) &&
                    <MilestoneProgressUpdateReviewList
                        {...props}
                        reportDates={{ Next: signOff.ReportMonth, Previous: previousSignOff?.ReportMonth }}
                        entities={signOff.Milestones?.filter(m => isOpen(m, 'MilestoneUpdates'))}
                        previousEntities={previousSignOff?.Milestones}
                        readOnly={true}
                        listConfig={listConfig}
                        reportType={ReportTypes.PartnerOrganisation}
                    />
                }
                {(userPermissions.UserIsPartnerOrganisationAdmin() || (userPartnerOrg && !userPartnerOrg.HideCustomSections)) &&
                    signOff?.ReportingEntityTypes?.filter(ret => !ret.IsHeadlineSection).map(ret => ret?.ReportingEntities?.length > 0 &&
                        <ReportingEntityProgressUpdateReviewList
                            key={ret.ID}
                            {...props}
                            reportDates={{ Next: signOff.ReportMonth, Previous: previousSignOff?.ReportMonth }}
                            entities={ret?.ReportingEntities}
                            previousEntities={previousSignOff?.ReportingEntityTypes?.find(t => t.ID === ret.ID)?.ReportingEntities}
                            readOnly={true}
                            entityType={ret}
                        />
                    )
                }
                <PartnerOrganisationRiskProgressUpdateReviewList
                    {...props}
                    entities={signOff.PartnerOrganisationRisks?.filter(r => isOpen(r, 'PartnerOrganisationRiskUpdates'))}
                    previousEntities={previousSignOff?.PartnerOrganisationRisks}
                    listTitle="Risk updates"
                    reportDates={{ Next: signOff.ReportMonth, Previous: previousSignOff?.ReportMonth }}
                    listConfig={listConfig}
                    riskMitigationActions={signOff.PartnerOrganisationRiskMitigationActions?.filter(a => isOpen(a, 'PartnerOrganisationRiskMitigationActionUpdates'))}
                    previousRiskMitigationActions={previousSignOff?.PartnerOrganisationRiskMitigationActions}
                    readOnly={true}
                />
            </div>
        );
    }
    return (
        <CrReportShimmer disableAnimation={!loading}>
            <div className={styles.fontSize18}>
                {loading ?
                    <span>Loading...</span>
                    :
                    <span>Please select a report above</span>
                }
            </div>
        </CrReportShimmer>
    );
};
