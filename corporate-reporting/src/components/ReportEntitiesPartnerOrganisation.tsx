import React, { useContext, useEffect, useState } from 'react';
import styles from '../styles/cr.module.scss';
import { Period } from '../refData/Period';
import {
    ICustomReportingEntity, IMilestone, IPartnerOrganisation, IPartnerOrganisationRisk,
    IPartnerOrganisationRiskMitigationAction, IReportDueDates, IWebPartComponentProps
} from '../types';
import { CrLoadingOverlay } from './cr/CrLoadingOverlay';
import { UpdateSectionHeader } from './cr/UpdateSectionHeader';
import { MilestoneProgressUpdateForm } from './milestone/MilestoneProgressUpdateForm';
import { PartnerOrganisationProgressUpdateForm } from './partnerOrganisation/PartnerOrganisationProgressUpdateForm';
import { PartnerOrganisationRiskProgressUpdateForm } from './partnerOrganisationRisk/PartnerOrganisationRiskProgressUpdateForm';
import { PartnerOrganisationRiskMitigationActionProgressUpdateForm } from './partnerOrganisationRiskMitigationAction/PartnerOrganisationRiskMitigationActionProgressUpdateForm';
import { ProgressUpdateList } from './ProgressUpdateList';
import { IWithErrorHandlingProps } from './withErrorHandling';
import { ReportingEntityProgressUpdateList } from './reportingEntities/ReportingEntityProgressUpdateList';
import { DataContext } from './DataContext';

export interface IReportEntitiesPartnerOrganisationProps extends IWebPartComponentProps, IWithErrorHandlingProps {
    partnerOrganisation: IPartnerOrganisation;
    partnerOrganisations: IPartnerOrganisation[];
    milestones: IMilestone[];
    reportingEntities: ICustomReportingEntity[];
    risks: IPartnerOrganisationRisk[];
    riskActions: IPartnerOrganisationRiskMitigationAction[];
    reportPeriod: Period;
    filters?: { text: string, dueBy: Date };
}

export const ReportEntitiesPartnerOrganisation = (props: IReportEntitiesPartnerOrganisationProps): React.ReactElement => {
    const { partnerOrganisation, partnerOrganisations, milestones, reportingEntities, risks, riskActions, reportPeriod, filters } = props;
    const { dataServices: { reportDueDatesService } } = useContext(DataContext);
    const [loading, setLoading] = useState(false);
    const [reportDates, setReportDates] = useState<IReportDueDates>();
    const [expand, setExpand] = useState(false);
    const reportingEntityTypeIds = new Set(reportingEntities.map(re => re.ReportingEntityTypeID));

    useEffect(() => {
        const loadReportDates = async (): Promise<void> => {
            try {
                setLoading(true);
                setReportDates(await reportDueDatesService.getPartnerOrganisationReportDueDates(partnerOrganisation.ID, new Date(), reportPeriod));
            } finally { setLoading(false); }
        };

        loadReportDates();
    }, [partnerOrganisation?.ID, reportPeriod, reportDueDatesService]);

    return (
        <>
            {partnerOrganisations.length + milestones.length + risks.length + riskActions.length > 0 &&
                <>
                    <CrLoadingOverlay isLoading={loading} />
                    {reportDates?.Next && (filters?.dueBy === undefined || filters?.dueBy === null || filters?.dueBy > reportDates.Next) &&
                        <>
                            <UpdateSectionHeader
                                title={partnerOrganisation.Title}
                                isOpen={expand}
                                onClick={() => setExpand(e => !e)}
                            />
                            <div className={styles.updateList}>
                                {expand &&
                                    <>
                                        <ProgressUpdateList<IPartnerOrganisation>
                                            listTitle="Partner organisation update"
                                            expandContent={true}
                                            entityName="user's partner organistion updates"
                                            {...props}
                                            entities={partnerOrganisations}
                                            reportDates={reportDates}
                                            renderProgressUpdateForm={po =>
                                                <PartnerOrganisationProgressUpdateForm
                                                    {...props}
                                                    entityId={po.ID}
                                                    entity={po}
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
                                        <ProgressUpdateList<IPartnerOrganisationRiskMitigationAction>
                                            listTitle="Risk mitigating action updates"
                                            expandContent={true}
                                            entityName="user's risk mitigation action updates"
                                            {...props}
                                            entities={riskActions}
                                            reportDates={reportDates}
                                            renderProgressUpdateForm={rma =>
                                                <PartnerOrganisationRiskMitigationActionProgressUpdateForm
                                                    {...props}
                                                    entityId={rma.ID}
                                                    entity={rma}
                                                    reportDates={reportDates}
                                                />
                                            }
                                        />
                                        <ProgressUpdateList<IPartnerOrganisationRisk>
                                            listTitle="Risk assessments"
                                            expandContent={true}
                                            entityName="user's risk updates"
                                            {...props}
                                            entities={risks}
                                            reportDates={reportDates}
                                            renderProgressUpdateForm={r =>
                                                <PartnerOrganisationRiskProgressUpdateForm
                                                    {...props}
                                                    entityId={r.ID}
                                                    entity={r}
                                                    reportDates={reportDates}
                                                />
                                            }
                                        />
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
