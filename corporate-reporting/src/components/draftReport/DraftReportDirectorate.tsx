import React, { useContext, useEffect, useState } from 'react';
import { ISignOff, IReportDueDates, IReportingEntity, IBaseComponentProps, IMetricUpdate } from '../../types';
import { DirectorateProgressUpdateReviewList } from '../directorate/DirectorateProgressUpdateReviewList';
import { CrExpandableTextDisplay } from '../cr/CrExpandableTextDisplay';
import { KeyWorkAreaProgressUpdateReviewList } from '../keyWorkArea/KeyWorkAreaProgressUpdateReviewList';
import { MilestoneProgressUpdateReviewList } from '../milestone/MilestoneProgressUpdateReviewList';
import { MetricProgressUpdateReviewList } from '../metric/MetricProgressUpdateReviewList';
import { CommitmentProgressUpdateReviewList } from '../commitment/CommitmentProgressUpdateReviewList';
import { ProjectProgressUpdateSummaryReviewList } from '../project/ProjectProgressUpdateSummaryReviewList';
import { EntityStatus } from '../../refData/EntityStatus';
import { ReportingEntityProgressUpdateReviewList } from '../reportingEntities/ReportingEntityProgressUpdateReviewList';
import { ReportTypes } from '../../refData/ReportTypes';
import { DataContext } from '../DataContext';
import { DraftReportHeader } from './DraftReportHeader';

interface IDraftReportDirectorateProps extends IBaseComponentProps {
    reportDates: IReportDueDates;
    report: Partial<ISignOff>;
    previousReport: ISignOff;
    previousMetricUpdates: IMetricUpdate[];
    loadReport: () => void;
}

export const DraftReportDirectorate = (props: IDraftReportDirectorateProps): React.ReactElement => {
    const { report, reportDates, previousReport, previousMetricUpdates, loadReport } = props;
    const { dataServices: { projectService, metricService } } = useContext(DataContext);
    const [totalOpenProjects, setTotalOpenProjects] = useState(0);
    const [totalOpenMetrics, setTotalOpenMetrics] = useState(0);

    useEffect(() => {
        const loadProjectTotal = async () => {
            setTotalOpenProjects(await projectService.readDirectorateOpenProjectsCount(report?.Directorate?.ID));
        };

        loadProjectTotal();
    }, [report?.Directorate?.ID, projectService]);

    useEffect(() => {
        const loadMetricTotal = async () => {
            setTotalOpenMetrics(await metricService.readDirectorateOpenMetricsCount(report?.Directorate?.ID));
        };

        loadMetricTotal();
    }, [report?.Directorate?.ID, metricService]);

    const isOpen = (entity: IReportingEntity, updatesProp: string): boolean => entity.EntityStatusID === EntityStatus.Open || entity[updatesProp]?.length > 0;

    return (
        <div>
            <DraftReportHeader
                title={report?.Directorate?.Title}
                reportDate={reportDates?.Next}
            />
            {report?.Directorate?.Objectives &&
                <CrExpandableTextDisplay
                    label="Directorate objectives"
                    largeLabel={true}
                    shortenedCharCount={250}
                    text={report?.Directorate?.Objectives}
                />
            }
            <DirectorateProgressUpdateReviewList
                {...props}
                directorate={report?.Directorate}
                directorateUpdate={report?.Directorate?.DirectorateUpdates?.[0]}
                onChange={loadReport}
            />
            {report?.ReportingEntityTypes?.filter(ret => ret.IsHeadlineSection).map(ret => ret?.ReportingEntities?.length > 0 &&
                <ReportingEntityProgressUpdateReviewList
                    key={ret.ID}
                    {...props}
                    entities={ret?.ReportingEntities}
                    previousEntities={previousReport?.ReportingEntityTypes?.find(t => t.ID === ret.ID)?.ReportingEntities}
                    onChange={loadReport}
                    entityType={ret}
                />
            )}
            <KeyWorkAreaProgressUpdateReviewList
                {...props}
                entities={report?.KeyWorkAreas?.filter(k => isOpen(k, 'KeyWorkAreaUpdates'))}
                previousEntities={previousReport?.KeyWorkAreas}
                onChange={loadReport}
            />
            <ProjectProgressUpdateSummaryReviewList
                {...props}
                listTitle="Project progress updates"
                entities={report?.Projects?.filter(p => isOpen(p, 'ProjectUpdates'))}
                previousEntities={previousReport?.Projects}
                onChange={loadReport}
                directorateOpenProjectCount={totalOpenProjects}
            />
            <MetricProgressUpdateReviewList
                {...props}
                entities={report?.Metrics?.filter(m => isOpen(m, 'MetricUpdates'))}
                previousEntities={previousReport?.Metrics}
                previousMetricUpdates={previousMetricUpdates}
                onChange={loadReport}
                directorateOpenMetricCount={totalOpenMetrics}
            />
            <MilestoneProgressUpdateReviewList
                {...props}
                entities={report?.Milestones?.filter(m => isOpen(m, 'MilestoneUpdates'))}
                previousEntities={previousReport?.Milestones}
                onChange={loadReport}
                reportType={ReportTypes.Directorate}
            />
            <CommitmentProgressUpdateReviewList
                {...props}
                entities={report?.Commitments?.filter(c => isOpen(c, 'CommitmentUpdates'))}
                previousEntities={previousReport?.Commitments}
                onChange={loadReport}
            />
            {report?.ReportingEntityTypes?.filter(ret => !ret.IsHeadlineSection).map(ret => ret?.ReportingEntities?.length > 0 &&
                <ReportingEntityProgressUpdateReviewList
                    key={ret.ID}
                    {...props}
                    entities={ret?.ReportingEntities}
                    previousEntities={previousReport?.ReportingEntityTypes?.find(t => t.ID === ret.ID)?.ReportingEntities}
                    onChange={loadReport}
                    entityType={ret}
                />
            )}
        </div>
    );
};
