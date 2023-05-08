import React, { useCallback, useContext, useEffect, useState } from 'react';
import { IReportDueDates, ISignOff, ISignOffAndMetadata, IBaseComponentProps, IBenefitUpdate, IMetricUpdate } from '../../types';
import styles from '../../styles/cr.module.scss';
import { SignOffType } from '../../refData/SignOffType';
import { CrReportShimmer } from '../cr/CrReportShimmer';
import { Period } from '../../refData/Period';
import { DraftReportDirectorate } from './DraftReportDirectorate';
import { DraftReportProject } from './DraftReportProject';
import { DraftReportRisk } from './DraftReportRisk';
import { DraftReportPartnerOrganisation } from './DraftReportPartnerOrganisation';
import { DraftReportFinancialRisk } from './DraftReportFinancialRisk';
import { DataContext } from '../DataContext';

interface IDraftReportBuilderProps extends IBaseComponentProps {
    signOffType: SignOffType;
    signOffEntityId: number;
    period: Period;
    reportDates: IReportDueDates;
}

export const DraftReportBuilder = (props: IDraftReportBuilderProps): React.ReactElement => {
    const { errorHandling: { onError }, signOffType, signOffEntityId, reportDates } = props;
    const { dataServices: { reportBuilderService, signOffService, benefitUpdateService, metricUpdateService } } = useContext(DataContext);
    const [loading, setLoading] = useState(false);
    const [report, setReport] = useState<Partial<ISignOff>>(null);
    const [previousReport, setPreviousReport] = useState<ISignOff>(null);
    const [previousMetricUpdates, setPreviousMetricUpdates] = useState<IMetricUpdate[]>([]);
    const [previousBenefitUpdates, setPreviousBenefitUpdates] = useState<IBenefitUpdate[]>([]);

    const logError = useCallback(onError, [onError]);

    const loadReport = useCallback(async () => {
        setReport(null);
        setLoading(true);
        try {
            let signOffAndMetadata: ISignOffAndMetadata;
            if (signOffType === SignOffType.Directorate) {
                signOffAndMetadata = await reportBuilderService.buildDirectorateReport(signOffEntityId, reportDates?.Next);
                const prevMetricUpdates = await Promise.all(
                    signOffAndMetadata.report.Metrics.map(async metric => {
                        if (metric?.ID && reportDates?.Previous) {
                            return await metricUpdateService.readLastSignedOffUpdateBeforeDate(metric.ID, reportDates.Previous);
                        }
                    })
                );
                setPreviousMetricUpdates(prevMetricUpdates.filter(u => u));
            }
            if (signOffType === SignOffType.PartnerOrganisation) {
                signOffAndMetadata = await reportBuilderService.buildPartnerOrganisationReport(signOffEntityId, reportDates?.Next);
            }
            if (signOffType === SignOffType.Project) {
                signOffAndMetadata = await reportBuilderService.buildProjectReport(signOffEntityId, reportDates?.Next);
                const prevBenefitUpdates = await Promise.all(
                    signOffAndMetadata.report.Benefits.map(async benefit => {
                        if (benefit?.ID && reportDates?.Previous) {
                            return await benefitUpdateService.readLastSignedOffUpdateBeforeDate(benefit.ID, reportDates.Previous);
                        }
                    })
                );
                setPreviousBenefitUpdates(prevBenefitUpdates.filter(u => u));
            }
            if (signOffType === SignOffType.Risk) {
                signOffAndMetadata = await reportBuilderService.buildRiskReport(signOffEntityId, reportDates?.Next);
            }
            if (signOffType === SignOffType.FinancialRisk) {
                signOffAndMetadata = await reportBuilderService.buildFinancialRiskReport(signOffEntityId, reportDates?.Next);
            }
            setReport(signOffAndMetadata.report);
        } catch (ex) {
            logError(`Error loading draft report`, ex);
        } finally {
            setLoading(false);
        }
    }, [reportBuilderService, benefitUpdateService, metricUpdateService, reportDates?.Next, reportDates?.Previous, signOffEntityId, signOffType, logError]);

    useEffect(() => {
        const loadPreviousReport = async () => {
            try {
                if (signOffType === SignOffType.Directorate) {
                    setPreviousReport(await signOffService.readPreviousDirectorateSignOff(signOffEntityId, reportDates?.Next));
                }
                if (signOffType === SignOffType.PartnerOrganisation) {
                    setPreviousReport(await signOffService.readPreviousPartnerOrganisationSignOff(signOffEntityId, reportDates?.Next));
                }
                if (signOffType === SignOffType.Project) {
                    setPreviousReport(await signOffService.readPreviousProjectSignOff(signOffEntityId, reportDates?.Next));
                }
            } catch (ex) {
                logError(`Error loading previous report`, ex);
            }
        };

        const loadReports = () => {
            if (signOffType && signOffEntityId && reportDates?.Next) {
                loadReport();
                loadPreviousReport();
            }
        };

        loadReports();
    }, [signOffType, signOffEntityId, reportDates?.Next, loadReport, signOffService, logError]);

    return (
        <div className={styles.cr}>
            {signOffEntityId && report && reportDates?.Next &&
                <div>
                    {signOffType === SignOffType.Directorate &&
                        <DraftReportDirectorate
                            {...props}
                            report={report}
                            previousReport={previousReport}
                            previousMetricUpdates={previousMetricUpdates}
                            loadReport={() => loadReport()}
                        />
                    }
                    {signOffType === SignOffType.Project &&
                        <DraftReportProject
                            {...props}
                            report={report}
                            previousReport={previousReport}
                            previousBenefitUpdates={previousBenefitUpdates}
                            loadReport={() => loadReport()}
                        />
                    }
                    {signOffType === SignOffType.PartnerOrganisation &&
                        <DraftReportPartnerOrganisation
                            {...props}
                            report={report}
                            previousReport={previousReport}
                            loadReport={async () => loadReport()}
                        />
                    }
                    {signOffType === SignOffType.Risk &&
                        <DraftReportRisk
                            {...props}
                            report={report}
                            loadReport={() => loadReport()}
                        />
                    }
                    {signOffType === SignOffType.FinancialRisk &&
                        <DraftReportFinancialRisk
                            {...props}
                            report={report}
                            loadReport={() => loadReport()}
                        />
                    }
                </div>
                ||
                <CrReportShimmer disableAnimation={!loading}>
                    <div className={styles.fontSize18}>
                        {loading ?
                            <span>Loading...</span>
                            :
                            <span>Please select a report above</span>
                        }
                    </div>
                </CrReportShimmer>
            }
        </div>
    );
};
