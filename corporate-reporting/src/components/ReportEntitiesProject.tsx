import React, { useContext, useEffect, useState } from 'react';
import styles from '../styles/cr.module.scss';
import { Period } from '../refData/Period';
import {
    IBenefit, ICustomReportingEntity, IDependency, IMilestone,
    IProject, IReportDueDates, IWebPartComponentProps, IWorkStream
} from '../types';
import { BenefitProgressUpdateForm } from './benefit/BenefitProgressUpdateForm';
import { CrLoadingOverlay } from './cr/CrLoadingOverlay';
import { UpdateSectionHeader } from './cr/UpdateSectionHeader';
import { DependencyProgressUpdateForm } from './dependency/DependencyProgressUpdateForm';
import { MilestoneProgressUpdateForm } from './milestone/MilestoneProgressUpdateForm';
import { ProgressUpdateList } from './ProgressUpdateList';
import { ProjectProgressUpdateForm } from './project/ProjectProgressUpdateForm';
import { IWithErrorHandlingProps } from './withErrorHandling';
import { WorkStreamProgressUpdateForm } from './workStream/WorkStreamProgressUpdateForm';
import { ReportingEntityProgressUpdateList } from './reportingEntities/ReportingEntityProgressUpdateList';
import { DataContext } from './DataContext';

export interface IReportEntitiesProjectProps extends IWebPartComponentProps, IWithErrorHandlingProps {
    project: IProject;
    projects: IProject[];
    workStreams: IWorkStream[];
    milestones: IMilestone[];
    dependencies: IDependency[];
    benefits: IBenefit[];
    reportingEntities: ICustomReportingEntity[];
    reportPeriod: Period;
    filters?: { text: string, dueBy: Date };
}

export const ReportEntitiesProject = (props: IReportEntitiesProjectProps): React.ReactElement => {
    const { project, projects, workStreams, milestones, dependencies, benefits, reportingEntities, reportPeriod, filters } = props;
    const { dataServices: { reportDueDatesService } } = useContext(DataContext);
    const [loading, setLoading] = useState(false);
    const [reportDates, setReportDates] = useState<IReportDueDates>({ Next: null, Previous: null });
    const [expand, setExpand] = useState(false);
    const reportingEntityTypeIds = new Set(reportingEntities.map(re => re.ReportingEntityTypeID));

    useEffect(() => {
        const loadReportDates = async (): Promise<void> => {
            try {
                setLoading(true);
                setReportDates(await reportDueDatesService.getProjectReportDueDates(project.ID, new Date(), reportPeriod));
            } finally { setLoading(false); }
        };

        loadReportDates();
    }, [project?.ID, reportPeriod, reportDueDatesService]);

    return (
        <>
            {projects.length + workStreams.length + milestones.length + dependencies.length + benefits.length > 0 &&
                <>
                    <CrLoadingOverlay isLoading={loading} />
                    {reportDates?.Next && (filters?.dueBy === undefined || filters?.dueBy === null || filters?.dueBy > reportDates.Next) &&
                        <>
                            <UpdateSectionHeader
                                title={project.Title}
                                isOpen={expand}
                                onClick={() => setExpand(e => !e)}
                            />
                            <div className={styles.updateList}>
                                {expand &&
                                    <>
                                        <ProgressUpdateList<IProject>
                                            listTitle="Project update"
                                            expandContent={true}
                                            entityName="user's project updates"
                                            {...props}
                                            entities={projects}
                                            reportDates={reportDates}
                                            renderProgressUpdateForm={p =>
                                                <ProjectProgressUpdateForm
                                                    {...props}
                                                    entityId={p.ID}
                                                    entity={p}
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
                                        <ProgressUpdateList<IWorkStream>
                                            listTitle="Work stream updates"
                                            expandContent={true}
                                            entityName="user's work stream updates"
                                            {...props}
                                            entities={workStreams}
                                            reportDates={reportDates}
                                            renderProgressUpdateForm={ws =>
                                                <WorkStreamProgressUpdateForm
                                                    {...props}
                                                    entityId={ws.ID}
                                                    entity={ws}
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
                                        <ProgressUpdateList<IDependency>
                                            listTitle="Dependency updates"
                                            expandContent={true}
                                            entityName="user's dependency updates"
                                            {...props}
                                            entities={dependencies}
                                            reportDates={reportDates}
                                            renderProgressUpdateForm={d =>
                                                <DependencyProgressUpdateForm
                                                    {...props}
                                                    entityId={d.ID}
                                                    entity={d}
                                                    reportDates={reportDates}
                                                />
                                            }
                                        />
                                        <ProgressUpdateList<IBenefit>
                                            listTitle="Benefit updates"
                                            expandContent={true}
                                            entityName="user's benefit updates"
                                            {...props}
                                            entities={benefits}
                                            reportDates={null} // Replaced by BenefitProgressUpdateForm for each benefit
                                            renderProgressUpdateForm={a =>
                                                <BenefitProgressUpdateForm
                                                    {...props}
                                                    entityId={a.ID}
                                                    entity={a}
                                                    reportDates={null} // Loaded by BenefitProgressUpdateForm for each benefit
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
