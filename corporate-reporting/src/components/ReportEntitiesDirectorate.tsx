import React, { useContext, useEffect, useState } from 'react';
import styles from '../styles/cr.module.scss';
import { Period } from '../refData/Period';
import { ICommitment, ICustomReportingEntity, IDirectorate, IKeyWorkArea, IMetric, IMilestone, IReportDueDates, IWebPartComponentProps } from '../types';
import { CommitmentProgressUpdateForm } from './commitment/CommitmentProgressUpdateForm';
import { CrLoadingOverlay } from './cr/CrLoadingOverlay';
import { UpdateSectionHeader } from './cr/UpdateSectionHeader';
import { DirectorateProgressUpdateForm } from './directorate/DirectorateProgressUpdateForm';
import { KeyWorkAreaProgressUpdateForm } from './keyWorkArea/KeyWorkAreaProgressUpdateForm';
import { MilestoneProgressUpdateForm } from './milestone/MilestoneProgressUpdateForm';
import { ProgressUpdateList } from './ProgressUpdateList';
import { IWithErrorHandlingProps } from './withErrorHandling';
import { ReportingEntityProgressUpdateList } from './reportingEntities/ReportingEntityProgressUpdateList';
import { MetricProgressUpdateForm } from './metric/MetricProgressUpdateForm';
import { DataContext } from './DataContext';

export interface IReportEntitiesDirectorateProps extends IWebPartComponentProps, IWithErrorHandlingProps {
    directorate: IDirectorate;
    directorates: IDirectorate[];
    keyWorkAreas: IKeyWorkArea[];
    milestones: IMilestone[];
    commitments: ICommitment[];
    metrics: IMetric[];
    reportingEntities: ICustomReportingEntity[];
    reportPeriod: Period;
    filters?: { text: string, dueBy: Date };
}

export const ReportEntitiesDirectorate = (props: IReportEntitiesDirectorateProps): React.ReactElement => {
    const { directorate, directorates, keyWorkAreas, milestones, commitments, metrics, reportingEntities, reportPeriod, filters } = props;
    const { dataServices: { reportDueDatesService } } = useContext(DataContext);
    const [loading, setLoading] = useState(false);
    const [reportDates, setReportDates] = useState<IReportDueDates>({ Next: null, Previous: null });
    const [expand, setExpand] = useState(false);
    const reportingEntityTypeIds = new Set(reportingEntities.map(re => re.ReportingEntityTypeID));

    useEffect(() => {
        const loadReportDates = async (): Promise<void> => {
            try {
                setLoading(true);
                setReportDates(await reportDueDatesService.getDirectorateReportDueDates(directorate.ID, new Date(), reportPeriod));
            }
            finally { setLoading(false); }
        };

        loadReportDates();
    }, [reportPeriod, reportDueDatesService, directorate?.ID]);

    return (
        <>
            {directorates.length + keyWorkAreas.length + milestones.length + commitments.length + metrics.length > 0 &&
                <>
                    <CrLoadingOverlay isLoading={loading} />
                    {reportDates?.Next && (filters?.dueBy === undefined || filters?.dueBy === null || filters?.dueBy > reportDates.Next) &&
                        <>
                            <UpdateSectionHeader
                                title={directorate.Title}
                                isOpen={expand}
                                onClick={() => setExpand(e => !e)}
                            />
                            <div className={styles.updateList}>
                                {expand &&
                                    <>
                                        <ProgressUpdateList<IDirectorate>
                                            listTitle="Directorate update"
                                            expandContent={true}
                                            entityName="user's directorate updates"
                                            {...props}
                                            entities={directorates}
                                            reportDates={reportDates}
                                            renderProgressUpdateForm={d =>
                                                <DirectorateProgressUpdateForm
                                                    {...props}
                                                    entityId={d.ID}
                                                    entity={d}
                                                    reportDates={reportDates}
                                                />
                                            }
                                        />
                                        {[...reportingEntityTypeIds].map(id => {
                                            const type = reportingEntities.find(re => re.ReportingEntityTypeID === id)?.ReportingEntityType;
                                            if (type.IsHeadlineSection) {
                                                const entitiesOfType = reportingEntities.filter(re => re.ReportingEntityTypeID === id);
                                                return (
                                                    <ReportingEntityProgressUpdateList
                                                        {...props}
                                                        type={type}
                                                        entities={entitiesOfType}
                                                        reportDates={reportDates}
                                                    />
                                                );
                                            }
                                        })}
                                        <ProgressUpdateList<IKeyWorkArea>
                                            listTitle="Key work area updates"
                                            expandContent={true}
                                            entityName="user's key work area updates"
                                            {...props}
                                            entities={keyWorkAreas}
                                            reportDates={reportDates}
                                            renderProgressUpdateForm={kwa =>
                                                <KeyWorkAreaProgressUpdateForm
                                                    {...props}
                                                    entityId={kwa.ID}
                                                    entity={kwa}
                                                    reportDates={reportDates}
                                                />
                                            }
                                        />
                                        <ProgressUpdateList<IMilestone>
                                            listTitle="Milestone updates"
                                            expandContent={true}
                                            entityName="user's milestone updates"
                                            {...props}
                                            entities={milestones}
                                            reportDates={reportDates}
                                            renderProgressUpdateForm={ms =>
                                                <MilestoneProgressUpdateForm
                                                    {...props}
                                                    entityId={ms.ID}
                                                    entity={ms}
                                                    reportDates={reportDates}
                                                />
                                            }
                                        />
                                        <ProgressUpdateList<ICommitment>
                                            listTitle="Commitment updates"
                                            expandContent={true}
                                            entityName="user's commitment updates"
                                            {...props}
                                            entities={commitments}
                                            reportDates={reportDates}
                                            renderProgressUpdateForm={c =>
                                                <CommitmentProgressUpdateForm
                                                    {...props}
                                                    entityId={c.ID}
                                                    entity={c}
                                                    reportDates={reportDates}
                                                />
                                            }
                                        />
                                        <ProgressUpdateList<IMetric>
                                            listTitle="Metric updates"
                                            expandContent={true}
                                            entityName="user's metric updates"
                                            {...props}
                                            entities={metrics}
                                            reportDates={null} // Replaced by MetricProgressUpdateForm for each metric
                                            renderProgressUpdateForm={a =>
                                                <MetricProgressUpdateForm
                                                    {...props}
                                                    entityId={a.ID}
                                                    entity={a}
                                                    reportDates={null} // Loaded by MetricProgressUpdateForm for each metric
                                                />
                                            }
                                        />
                                        {[...reportingEntityTypeIds].map(id => {
                                            const type = reportingEntities.find(re => re.ReportingEntityTypeID === id)?.ReportingEntityType;
                                            if (!type.IsHeadlineSection) {
                                                const entitiesOfType = reportingEntities.filter(re => re.ReportingEntityTypeID === id);
                                                return (
                                                    <ReportingEntityProgressUpdateList
                                                        {...props}
                                                        type={type}
                                                        entities={entitiesOfType}
                                                        reportDates={reportDates}
                                                    />
                                                );
                                            }
                                        })}
                                    </>
                                }
                            </div>
                        </>
                    }
                </>
            }
        </>
    );
};
