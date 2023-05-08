import React, { useContext, useEffect, useState } from 'react';
import styles from '../styles/cr.module.scss';
import { Period } from '../refData/Period';
import { ICorporateRisk, ICorporateRiskMitigationAction, IDirectorate, IReportDueDates, IRisk, IWebPartComponentProps } from '../types';
import { CrLoadingOverlay } from './cr/CrLoadingOverlay';
import { UpdateSectionHeader } from './cr/UpdateSectionHeader';
import { ProgressUpdateList } from './ProgressUpdateList';
import { RiskProgressUpdateForm } from './risk/RiskProgressUpdateForm';
import { RiskMitigationActionProgressUpdateForm } from './riskMitigationAction/RiskMitigationActionProgressUpdateForm';
import { IWithErrorHandlingProps } from './withErrorHandling';
import { DataContext } from './DataContext';

interface IReportEntitiesDirectorateRisksProps extends IWebPartComponentProps, IWithErrorHandlingProps {
    directorate: IDirectorate;
    risks: ICorporateRisk[];
    riskActions: ICorporateRiskMitigationAction[];
    reportPeriod: Period;
    filters?: { text: string, dueBy: Date };
}

export const ReportEntitiesDirectorateRisks = (props: IReportEntitiesDirectorateRisksProps): React.ReactElement => {
    const { directorate, risks, riskActions, reportPeriod, filters } = props;
    const { dataServices: { reportDueDatesService, corporateRiskService,
        corporateRiskMitigationActionService, corporateRiskMitigationActionUpdateService } } = useContext(DataContext);
    const [loading, setLoading] = useState(false);
    const [reportDates, setReportDates] = useState<IReportDueDates>({ Next: null, Previous: null });
    const [expand, setExpand] = useState(false);

    useEffect(() => {
        const loadReportDates = async (): Promise<void> => {
            try {
                setLoading(true);
                setReportDates(await reportDueDatesService.getDirectorateReportDueDates(directorate.ID, new Date(), reportPeriod));
            }
            finally { setLoading(false); }
        };

        loadReportDates();
    }, [directorate.ID, reportPeriod, reportDueDatesService]);

    return (
        <>
            {risks.length + riskActions.length > 0 &&
                <>
                    <CrLoadingOverlay isLoading={loading} />
                    {reportDates?.Next && (filters?.dueBy === undefined || filters?.dueBy === null || filters.dueBy > reportDates.Next) &&
                        <>
                            <UpdateSectionHeader
                                title={`${directorate.Title} risk assessments`}
                                isOpen={expand}
                                onClick={() => setExpand(e => !e)}
                            />
                            <div className={styles.updateList}>
                                {expand &&
                                    <>
                                        <ProgressUpdateList<ICorporateRiskMitigationAction>
                                            listTitle="Risk mitigating action updates"
                                            expandContent={true}
                                            entityName="user's risk mitigation action updates"
                                            {...props}
                                            entities={riskActions}
                                            reportDates={reportDates}
                                            renderProgressUpdateForm={a =>
                                                <RiskMitigationActionProgressUpdateForm<ICorporateRiskMitigationAction>
                                                    {...props}
                                                    title={rma => {
                                                        const title = [];
                                                        if (rma.Title) {
                                                            if (rma.Risk?.RiskCode)
                                                                title.push(rma.Risk.RiskCode);
                                                            title.push(rma.Title);
                                                            return title.join(' - ');
                                                        }
                                                    }}
                                                    parents={rma => rma?.Risk ? [rma.Risk.Title] : []}
                                                    entityId={a.ID}
                                                    entity={a}
                                                    reportDates={reportDates}
                                                    riskService={corporateRiskService}
                                                    riskActionService={corporateRiskMitigationActionService}
                                                    riskActionUpdateService={corporateRiskMitigationActionUpdateService}
                                                />
                                            }
                                        />
                                        <ProgressUpdateList<IRisk>
                                            listTitle="Risk assessments"
                                            expandContent={true}
                                            entityName="user's risk assessments"
                                            {...props}
                                            entities={risks}
                                            reportDates={reportDates}
                                            renderProgressUpdateForm={r =>
                                                <RiskProgressUpdateForm
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
