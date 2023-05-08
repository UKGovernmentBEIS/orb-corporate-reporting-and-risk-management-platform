import React, { useCallback, useContext, useEffect, useState } from "react";
import styles from '../../styles/cr.module.scss';
import { Period } from "../../refData/Period";
import { IBaseComponentProps, IFinancialRisk, IReportDueDates, ISignOff } from "../../types";
import { CrLoadingOverlay } from "../cr/CrLoadingOverlay";
import { FinancialRiskProgressUpdateForm } from "./FinancialRiskProgressUpdateForm";
import { sub } from "date-fns";
import { DataContext } from '../DataContext';

export const FinancialRiskRegister = (props: IBaseComponentProps): React.ReactElement => {
    const { errorHandling: { onError }, isFullPage } = props;
    const { dataServices: { financialRiskService, signOffService, reportDueDatesService } } = useContext(DataContext);
    const [loading, setLoading] = useState(false);
    const [risks, setRisks] = useState<IFinancialRisk[]>([]);
    const [riskReports, setRiskReports] = useState<ISignOff[]>([]);
    const [riskReportDates, setRiskReportDates] = useState<{ riskId: number, dates: IReportDueDates }[]>([]);

    const logError = useCallback(onError, [onError]);

    useEffect(() => {
        const loadRisks = async (): Promise<void> => {
            try {
                setLoading(true);
                const myRisks = financialRiskService.readAll();
                const reports = signOffService.readAllFinancialRiskSignOffsSince(sub(new Date(), { months: 3 }));
                setRisks(await myRisks);
                setRiskReports(await reports);
            } catch (err) {
                logError('Error loading report entities', err.Message);
            } finally {
                setLoading(false);
            }
        };

        loadRisks();
    }, [financialRiskService, signOffService, logError]);

    const riskIds = JSON.stringify(risks.map(r => r.ID).sort());
    useEffect(() => {
        const loadReportDates = async (): Promise<void> => {
            try {
                setRiskReportDates(await Promise.all(
                    (JSON.parse(riskIds) as number[]).map(async riskId => ({
                        riskId: riskId,
                        dates: await reportDueDatesService.getFinancialRiskReportDueDates(riskId, new Date(), Period.Current)
                    }))
                ));
            } catch (err) {
                logError('Error loading financial risk report dates', err.Message);
            }
        };

        loadReportDates();
    }, [riskIds, reportDueDatesService, logError]);

    return (
        <div className={`${styles.cr} ${isFullPage ? styles.crFullPage : ''}`}>
            <div className={styles.crFullPageContent} style={{ position: 'relative' }}>
                <CrLoadingOverlay isLoading={loading} />
                <h2 className={styles.listTitle}>Financial risk register</h2>
                <div className={styles.crList}>
                    {risks.map(risk => {
                        const report = riskReports.find(rr => rr.RiskID === risk.ID);
                        const dates: IReportDueDates = report?.FinancialRisk?.FinancialRiskUpdates?.[0]?.UpdatePeriod
                            ? { Previous: null, Next: report?.FinancialRisk?.FinancialRiskUpdates?.[0]?.UpdatePeriod }
                            : riskReportDates.find(rd => rd.riskId === risk.ID)?.dates;

                        return (
                            <FinancialRiskProgressUpdateForm
                                key={risk.ID}
                                {...props}
                                entityId={risk.ID}
                                entityUpdateId={report?.FinancialRisk?.FinancialRiskUpdates?.[0]?.ID}
                                reportDates={dates}
                                disabled={true}
                                riskActions={report?.FinancialRiskMitigationActions}
                            />
                        );
                    })}
                </div>
            </div>
        </div>
    );
};