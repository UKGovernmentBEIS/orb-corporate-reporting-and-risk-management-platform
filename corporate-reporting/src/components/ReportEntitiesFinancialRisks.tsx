import React, { useCallback, useContext, useEffect, useState } from 'react';
import styles from '../styles/cr.module.scss';
import { Period } from '../refData/Period';
import { IFinancialRisk, IFinancialRiskMitigationAction, IReportDueDates, IWebPartComponentProps } from '../types';
import { UpdateSectionHeader } from './cr/UpdateSectionHeader';
import { ProgressUpdateList } from './ProgressUpdateList';
import { IWithErrorHandlingProps } from './withErrorHandling';
import { FinancialRiskProgressUpdateForm } from './financialRisk/FinancialRiskProgressUpdateForm';
import { CrLoadingOverlay } from './cr/CrLoadingOverlay';
import { RiskMitigationActionProgressUpdateForm } from './riskMitigationAction/RiskMitigationActionProgressUpdateForm';
import { DataContext } from './DataContext';

interface IReportEntitiesFinancialRisksProps extends IWebPartComponentProps, IWithErrorHandlingProps {
    risks: IFinancialRisk[];
    riskActions: IFinancialRiskMitigationAction[];
    reportPeriod: Period;
    filters?: { text: string, dueBy: Date };
}

export const ReportEntitiesFinancialRisks = (props: IReportEntitiesFinancialRisksProps): React.ReactElement => {
    const { errorHandling: { onError }, risks, riskActions, reportPeriod, filters } = props;
    const { dataServices } = useContext(DataContext);
    const [loadingRiskDates, setLoadingRiskDates] = useState(false);
    const [loadingActionDates, setLoadingActionDates] = useState(false);
    const [expand, setExpand] = useState(false);
    const [riskReportDates, setRiskReportDates] = useState<{ riskId: number, dates: IReportDueDates }[]>([]);
    const [actionReportDates, setActionReportDates] = useState<{ riskId: number, dates: IReportDueDates }[]>([]);

    const logError = useCallback(onError, [onError]);

    useEffect(() => {
        const loadReportDates = async (): Promise<void> => {
            try {
                setLoadingRiskDates(true);
                setRiskReportDates(await Promise.all(
                    risks.map(async risk => ({
                        riskId: risk.ID,
                        dates: await dataServices.reportDueDatesService.getFinancialRiskReportDueDates(risk.ID, new Date(), reportPeriod)
                    }))
                ));
            } catch (err) {
                logError('Error loading financial risk report dates', err.Message);
            }
            finally { setLoadingRiskDates(false); }
        };

        loadReportDates();
    }, [reportPeriod, risks, dataServices.reportDueDatesService, logError]);

    useEffect(() => {
        const loadReportDates = async (): Promise<void> => {
            try {
                setLoadingActionDates(true);
                setActionReportDates(await Promise.all(
                    riskActions.map(async action => ({
                        riskId: action.RiskID,
                        dates: await dataServices.reportDueDatesService.getFinancialRiskReportDueDates(action.RiskID, new Date(), reportPeriod)
                    }))
                ));
            } catch (err) {
                logError('Error loading financial risk report dates', err.Message);
            }
            finally { setLoadingActionDates(false); }
        };

        loadReportDates();
    }, [reportPeriod, riskActions, dataServices.reportDueDatesService, logError]);

    const filteredRiskActions = filters?.dueBy == null ? riskActions : riskActions.filter(a =>
        actionReportDates.find(rd => rd.riskId === a.RiskID)?.dates?.Next < filters.dueBy
    );

    const filteredRisks = filters?.dueBy == null ? risks : risks.filter(r =>
        riskReportDates.find(rd => rd.riskId === r.ID)?.dates?.Next < filters.dueBy
    );

    return (
        <>
            <CrLoadingOverlay isLoading={loadingRiskDates || loadingActionDates} />
            {filteredRisks.length > 0 &&
                <>
                    <UpdateSectionHeader
                        title={`Financial risk assessments`}
                        isOpen={expand}
                        onClick={() => setExpand(e => !e)}
                    />
                    <div className={styles.updateList}>
                        {expand &&
                            <>
                                <ProgressUpdateList<IFinancialRiskMitigationAction>
                                    listTitle="Financial risk mitigating action updates"
                                    expandContent={true}
                                    entityName="user's financial risk mitigation action updates"
                                    {...props}
                                    entities={filteredRiskActions}
                                    reportDates={null}
                                    renderProgressUpdateForm={a =>
                                        <RiskMitigationActionProgressUpdateForm<IFinancialRiskMitigationAction>
                                            {...props}
                                            title={rma => {
                                                const title = [];
                                                if (rma.Title) {
                                                    if (rma.FinancialRisk?.RiskCode)
                                                        title.push(rma.FinancialRisk.RiskCode);
                                                    title.push(rma.Title);
                                                    return title.join(' - ');
                                                }
                                            }}
                                            parents={rma => rma?.FinancialRisk ? [rma.FinancialRisk.Title] : []}
                                            entityId={a.ID}
                                            entity={a}
                                            reportDates={actionReportDates.find(rd => rd.riskId === a.RiskID)?.dates}
                                            riskService={dataServices.financialRiskService}
                                            riskActionService={dataServices.financialRiskMitigationActionService}
                                            riskActionUpdateService={dataServices.financialRiskMitigationActionUpdateService}
                                            maxNarrativeLength={500}
                                        />
                                    }
                                />
                                <ProgressUpdateList<IFinancialRisk>
                                    listTitle="Financial risk assessments"
                                    expandContent={true}
                                    entityName="user's financial risk assessments"
                                    {...props}
                                    entities={filteredRisks}
                                    reportDates={null} // Replaced by FinancialRiskProgressUpdateForm for each risk
                                    renderProgressUpdateForm={a =>
                                        <FinancialRiskProgressUpdateForm
                                            {...props}
                                            entityId={a.ID}
                                            entity={a}
                                            reportDates={riskReportDates.find(rd => rd.riskId === a.ID)?.dates}
                                        />
                                    }
                                />
                            </>
                        }
                    </div>
                </>
            }
        </>
    );
};
