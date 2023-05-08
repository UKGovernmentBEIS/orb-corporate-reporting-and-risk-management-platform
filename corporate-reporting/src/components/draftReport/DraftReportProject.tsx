import React, { useState } from 'react';
import { ISignOff, IReportDueDates, IReportingEntity, IBaseComponentProps, IBenefitUpdate } from '../../types';
import { ProjectProgressUpdateReviewList } from '../project/ProjectProgressUpdateReviewList';
import { CrExpandableTextDisplay } from '../cr/CrExpandableTextDisplay';
import { Label } from 'office-ui-fabric-react/lib/Label';
import { WorkStreamProgressUpdateReviewList } from '../workStream/WorkStreamProgressUpdateReviewList';
import { MilestoneProgressUpdateReviewList } from '../milestone/MilestoneProgressUpdateReviewList';
import { BenefitProgressUpdateReviewList } from '../benefit/BenefitProgressUpdateReviewList';
import { DependencyProgressUpdateReviewList } from '../dependency/DependencyProgressUpdateReviewList';
import { ProjectProgressUpdateSummaryReviewList } from '../project/ProjectProgressUpdateSummaryReviewList';
import { Toggle } from 'office-ui-fabric-react/lib/Toggle';
import { EntityStatus } from '../../refData/EntityStatus';
import { ReportingEntityProgressUpdateReviewList } from '../reportingEntities/ReportingEntityProgressUpdateReviewList';
import { ReportTypes } from '../../refData/ReportTypes';
import { DraftReportHeader } from './DraftReportHeader';

interface IDraftReportProjectProps extends IBaseComponentProps {
    reportDates: IReportDueDates;
    report: Partial<ISignOff>;
    previousReport: ISignOff;
    previousBenefitUpdates: IBenefitUpdate[];
    loadReport: () => void;
}

export const DraftReportProject = (props: IDraftReportProjectProps): React.ReactElement => {
    const { report, reportDates, previousReport, previousBenefitUpdates, loadReport } = props;
    const [showPreviousProjectReport, setShowPreviousProjectReport] = useState(false);

    const isOpen = (entity: IReportingEntity, updatesProp: string): boolean => entity.EntityStatusID === EntityStatus.Open || entity[updatesProp]?.length > 0;

    return (
        <div>
            <DraftReportHeader
                title={report?.Project?.Title}
                reportDate={reportDates?.Next}
                attributes={report?.Project?.Attributes?.filter(a => a.AttributeType?.Display).map(a => a.AttributeType)}
            />
            <Label>Show previous period&apos;s comments</Label>
            <div style={{ display: 'flex', alignItems: 'center' }}>
                <Toggle
                    checked={showPreviousProjectReport}
                    onChange={(_, checked) => setShowPreviousProjectReport(checked)}
                    style={{ marginBottom: '0px' }}
                />
            </div>
            <CrExpandableTextDisplay
                label="Project objectives"
                largeLabel={true}
                shortenedCharCount={250}
                text={report.Project?.Objectives}
            />
            <ProjectProgressUpdateReviewList
                {...props}
                project={report.Project}
                projectUpdate={report.Project?.ProjectUpdates?.[0]}
                previousProjectUpdate={previousReport?.Project?.ProjectUpdates?.[0]}
                showPreviousUpdate={showPreviousProjectReport}
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
            <WorkStreamProgressUpdateReviewList
                {...props}
                entities={report.WorkStreams?.filter(w => isOpen(w, 'WorkStreamUpdates'))}
                previousEntities={previousReport?.WorkStreams}
                showPreviousUpdate={showPreviousProjectReport}
                onChange={loadReport}
            />
            <BenefitProgressUpdateReviewList
                {...props}
                entities={report.Benefits?.filter(b => isOpen(b, 'BenefitUpdates'))}
                previousEntities={previousReport?.Benefits}
                previousBenefitUpdates={previousBenefitUpdates}
                showPreviousUpdate={showPreviousProjectReport}
                onChange={loadReport}
            />
            <MilestoneProgressUpdateReviewList
                {...props}
                entities={report.Milestones?.filter(m => isOpen(m, 'MilestoneUpdates'))}
                previousEntities={previousReport?.Milestones}
                showPreviousUpdate={showPreviousProjectReport}
                onChange={loadReport}
                reportType={ReportTypes.Project}
            />
            <DependencyProgressUpdateReviewList
                {...props}
                entities={report.Dependencies?.filter(d => isOpen(d, 'DependencyUpdates'))}
                previousEntities={previousReport?.Dependencies}
                showPreviousUpdate={showPreviousProjectReport}
                onChange={loadReport}
            />
            <ProjectProgressUpdateSummaryReviewList
                {...props}
                listTitle="Project progress updates"
                entities={report.Projects?.filter(p => isOpen(p, 'ProjectUpdates'))}
                previousEntities={previousReport?.Projects}
                showPreviousUpdate={showPreviousProjectReport}
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
