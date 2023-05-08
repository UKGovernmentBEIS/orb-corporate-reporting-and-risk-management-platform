import React, { useContext } from 'react';
import { ISignOff, IReportDueDates, ListDefaults, IReportingEntity, IBaseComponentProps } from '../../types';
import { PartnerOrganisationProgressUpdateReviewList } from '../partnerOrganisation/PartnerOrganisationProgressUpdateReviewList';
import { PartnerOrganisationRiskProgressUpdateReviewList } from '../partnerOrganisationRisk/PartnerOrganisationRiskProgressUpdateReviewList';
import { MilestoneProgressUpdateReviewList } from '../milestone/MilestoneProgressUpdateReviewList';
import { EntityStatus } from '../../refData/EntityStatus';
import { ReportingEntityProgressUpdateReviewList } from '../reportingEntities/ReportingEntityProgressUpdateReviewList';
import { ReportTypes } from '../../refData/ReportTypes';
import { OrbUserContext } from '../OrbUserContext';
import { DraftReportHeader } from './DraftReportHeader';

interface IDraftReportPartnerOrganisationProps extends IBaseComponentProps {
    reportDates: IReportDueDates;
    report: Partial<ISignOff>;
    previousReport: ISignOff;
    loadReport: () => void;
}

export const DraftReportPartnerOrganisation = (props: IDraftReportPartnerOrganisationProps): React.ReactElement => {
    const { report, reportDates, previousReport, loadReport } = props;
    const { userContext, userPermissions } = useContext(OrbUserContext);

    const isOpen = (entity: IReportingEntity, updatesProp: string): boolean => entity.EntityStatusID === EntityStatus.Open || entity[updatesProp]?.length > 0;
    const userPartnerOrg = userContext.UserEntities?.UserPartnerOrganisations?.find(upo => upo.PartnerOrganisationID === report.PartnerOrganisation?.ID);

    return (
        <div>
            <DraftReportHeader
                title={report?.PartnerOrganisation?.Title}
                reportDate={reportDates?.Next}
            />
            {(userPermissions.UserIsPartnerOrganisationAdmin() || (userPartnerOrg && !userPartnerOrg.HideHeadlines)) &&
                <PartnerOrganisationProgressUpdateReviewList
                    {...props}
                    partnerOrganisation={report.PartnerOrganisation}
                    partnerOrganisationUpdate={report.PartnerOrganisation?.PartnerOrganisationUpdates?.[0]}
                    onChange={loadReport}
                />
            }
            {(userPermissions.UserIsPartnerOrganisationAdmin() || (userPartnerOrg && !userPartnerOrg.HideCustomSections)) &&
                report?.ReportingEntityTypes?.filter(ret => ret.IsHeadlineSection).map(ret => ret?.ReportingEntities?.length > 0 &&
                    <ReportingEntityProgressUpdateReviewList
                        key={ret.ID}
                        {...props}
                        entities={ret?.ReportingEntities}
                        previousEntities={previousReport?.ReportingEntityTypes?.find(t => t.ID === ret.ID)?.ReportingEntities}
                        onChange={loadReport}
                        entityType={ret}
                    />
                )
            }
            {(userPermissions.UserIsPartnerOrganisationAdmin() || (userPartnerOrg && !userPartnerOrg.HideMilestones)) &&
                <MilestoneProgressUpdateReviewList
                    {...props}
                    entities={report.Milestones?.filter(m => isOpen(m, 'MilestoneUpdates'))}
                    previousEntities={previousReport?.Milestones}
                    onChange={loadReport}
                    reportType={ReportTypes.PartnerOrganisation}
                />
            }
            {(userPermissions.UserIsPartnerOrganisationAdmin() || (userPartnerOrg && !userPartnerOrg.HideCustomSections)) &&
                report?.ReportingEntityTypes?.filter(ret => !ret.IsHeadlineSection).map(ret => ret?.ReportingEntities?.length > 0 &&
                    <ReportingEntityProgressUpdateReviewList
                        key={ret.ID}
                        {...props}
                        entities={ret?.ReportingEntities}
                        previousEntities={previousReport?.ReportingEntityTypes?.find(t => t.ID === ret.ID)?.ReportingEntities}
                        onChange={loadReport}
                        entityType={ret}
                    />
                )
            }
            <PartnerOrganisationRiskProgressUpdateReviewList
                {...props}
                entities={report.PartnerOrganisationRisks?.filter(r => isOpen(r, 'PartnerOrganisationRiskUpdates'))}
                previousEntities={previousReport?.PartnerOrganisationRisks}
                listTitle="Risk updates"
                listConfig={ListDefaults}
                riskMitigationActions={report.PartnerOrganisationRiskMitigationActions?.filter(a => isOpen(a, 'PartnerOrganisationRiskMitigationActionUpdates'))}
                previousRiskMitigationActions={previousReport?.PartnerOrganisationRiskMitigationActions}
                onChange={loadReport}
            />
        </div>
    );
};
