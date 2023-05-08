import React, { useCallback, useContext, useEffect, useState } from 'react';
import {
    ISignOff, SaveStatus, IReportDueDates, SignOff, ICorporateRisk, ISignOffDto, ISignOffAndMetadata, IBaseComponentProps, IMetricUpdate, IBenefitUpdate
} from '../../types';
import styles from '../../styles/cr.module.scss';
import { SignOffType } from '../../refData/SignOffType';
import { ConfirmDialog } from '../cr/ConfirmDialog';
import { FormButtons } from '../cr/FormButtons';
import { FieldErrorMessage } from '../cr/FieldDecorators';
import { CrApprovalDetails } from '../cr/CrApprovalDetails';
import { MessageBar, MessageBarType } from 'office-ui-fabric-react/lib/MessageBar';
import { Period } from '../../refData/Period';
import { DraftReportDirectorate } from '../draftReport/DraftReportDirectorate';
import { DraftReportProject } from '../draftReport/DraftReportProject';
import { DraftReportPartnerOrganisation } from '../draftReport/DraftReportPartnerOrganisation';
import { DraftReportRisk } from '../draftReport/DraftReportRisk';
import { DraftReportFinancialRisk } from '../draftReport/DraftReportFinancialRisk';
import { CrPreviousApprovalDetails } from '../cr/CrPreviousApprovalDetails';
import { DataContext } from '../DataContext';
import { CrReportShimmer } from '../cr/CrReportShimmer';

export class SignOffBuilderValidations {
    public DirectorateUpdate: string = null;
    public ProjectUpdate: string = null;
    public PartnerOrganisationUpdate: string = null;
    public ReportMonth: string = null;
    public OverallRagOptionID: string = null;
    public FinanceRagOptionID: string = null;
    public PeopleRagOptionID: string = null;
    public MilestonesRagOptionID: string = null;
    public MetricsRagOptionID: string = null;
    public BenefitsRagOptionID: string = null;
    public KPIRagOptionID: string = null;
    public Title: string = null;
    public Escalate: string = null;
    public DeEscalate: string = null;
    public RiskProximity: string = null;
    public RiskAppetiteBreachAuthorised: string = null;
    public RiskImpactLevelID: string = null;
    public RiskProbabilityID: string = null;
    public RiskUpdate: string = null;
    public RiskMitigationActionUpdates: string = null;
    public RiskMitigationActions: string = null;
}

export interface ISignOffBuilderProps extends IBaseComponentProps {
    signOffType: SignOffType;
    signOffEntityId: number;
    period: Period;
    reportDates: IReportDueDates;
}

export const SignOffBuilder = (props: ISignOffBuilderProps): React.ReactElement => {
    const { errorHandling: { onError, clearErrors }, signOffType, signOffEntityId, reportDates, period } = props;
    const { dataServices: { reportBuilderService, signOffService, metricUpdateService, benefitUpdateService } } = useContext(DataContext);
    const [loading, setLoading] = useState(false);
    const [report, setReport] = useState<Partial<ISignOff>>(null);
    const [reportMetadata, setReportMetadata] = useState<ISignOffDto>(null);
    const [previousReport, setPreviousReport] = useState<ISignOff>(null);
    const [previousMetricUpdates, setPreviousMetricUpdates] = useState<IMetricUpdate[]>([]);
    const [previousBenefitUpdates, setPreviousBenefitUpdates] = useState<IBenefitUpdate[]>([]);
    const [savedReport, setSavedReport] = useState<ISignOff>(null);
    const [showRAGConfirmDialog, setShowRAGConfirmDialog] = useState(false);
    const [validationErrors, setValidationErrors] = useState(new SignOffBuilderValidations());
    const [saveStatus, setSaveStatus] = useState(SaveStatus.None);

    const logError = useCallback(onError, [onError]);
    const resetErrors = useCallback(clearErrors, [clearErrors]);

    const loadReport = async () => {
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
            setReportMetadata(signOffAndMetadata.metadata);
        } catch (ex) {
            logError(`Error loading draft report`, ex);
        } finally {
            setLoading(false);
        }
    };

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

        const loadCurrentReport = async () => {
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
                setReportMetadata(signOffAndMetadata.metadata);
            } catch (ex) {
                logError(`Error loading draft report`, ex);
            } finally {
                setLoading(false);
            }
        };

        const loadReports = async () => {
            if (signOffType && signOffEntityId && reportDates?.Next) {
                loadCurrentReport();
                loadPreviousReport();
            }
        };

        loadReports();
    }, [signOffType, signOffEntityId, reportDates?.Next, reportDates?.Previous, signOffService, reportBuilderService,
        benefitUpdateService, metricUpdateService, logError]);

    useEffect(() => {
        setSavedReport(null);
    }, [signOffType, signOffEntityId, period]);

    const confirmOverrideRagValidation = (): void => {
        setShowRAGConfirmDialog(false);
        saveSignOff(true);
    };

    const validateSignOff = (): boolean => {
        const errors: SignOffBuilderValidations = new SignOffBuilderValidations();
        let valid = true;

        if (signOffEntityId) {
            if (signOffType === SignOffType.Directorate) {
                const du = report.Directorate?.DirectorateUpdates?.[0];
                if (du) {
                    if (du.OverallRagOptionID === null) {
                        errors.OverallRagOptionID = 'Delivery confidence RAG rating is missing from the report';
                        valid = false;
                    } else errors.OverallRagOptionID = null;

                    if (du.FinanceRagOptionID === null) {
                        errors.FinanceRagOptionID = 'Finance RAG rating is missing from the report';
                        valid = false;
                    } else errors.FinanceRagOptionID = null;

                    if (du.PeopleRagOptionID === null) {
                        errors.PeopleRagOptionID = 'People RAG rating is missing from the report';
                        valid = false;
                    } else errors.PeopleRagOptionID = null;

                    if (du.MilestonesRagOptionID === null) {
                        errors.MilestonesRagOptionID = 'Milestones RAG rating is missing from the report';
                        valid = false;
                    } else errors.MilestonesRagOptionID = null;

                    if (du.MetricsRagOptionID === null) {
                        errors.MetricsRagOptionID = 'Metrics RAG rating is missing from the report';
                        valid = false;
                    } else errors.MetricsRagOptionID = null;

                    if (du.OverallRagOptionID !== null && du.FinanceRagOptionID !== null && du.PeopleRagOptionID != null && du.MilestonesRagOptionID !== null && du.MetricsRagOptionID !== null) {
                        const averageRAG = (du.FinanceRagOptionID + du.PeopleRagOptionID + du.MilestonesRagOptionID + du.MetricsRagOptionID) / 4;
                        if (averageRAG < du.OverallRagOptionID - 1 || averageRAG > du.OverallRagOptionID + 1) {
                            valid = false;
                            setShowRAGConfirmDialog(true);
                        }
                    }
                } else {
                    errors.DirectorateUpdate = 'No directorate update has been created for this report';
                    valid = false;
                }
            }
            if (signOffType === SignOffType.Project) {
                const pu = report.Project?.ProjectUpdates?.[0];
                if (pu) {
                    if (pu.OverallRagOptionID === null) {
                        errors.OverallRagOptionID = 'Delivery confidence RAG rating is missing from the report';
                        valid = false;
                    } else errors.OverallRagOptionID = null;

                    if (pu.FinanceRagOptionID === null) {
                        errors.FinanceRagOptionID = 'Finance RAG rating is missing from the report';
                        valid = false;
                    } else errors.FinanceRagOptionID = null;

                    if (pu.PeopleRagOptionID === null) {
                        errors.PeopleRagOptionID = 'People RAG rating is missing from the report';
                        valid = false;
                    } else errors.PeopleRagOptionID = null;

                    if (pu.MilestonesRagOptionID === null) {
                        errors.MilestonesRagOptionID = 'Milestones RAG rating is missing from the report';
                        valid = false;
                    } else errors.MilestonesRagOptionID = null;

                    if (pu.BenefitsRagOptionID === null) {
                        errors.BenefitsRagOptionID = 'Benefits RAG rating is missing from the report';
                        valid = false;
                    } else errors.BenefitsRagOptionID = null;

                    if (pu.OverallRagOptionID !== null && pu.FinanceRagOptionID !== null && pu.PeopleRagOptionID != null && pu.MilestonesRagOptionID !== null && pu.BenefitsRagOptionID !== null) {
                        const averageRAG = (pu.FinanceRagOptionID + pu.PeopleRagOptionID + pu.MilestonesRagOptionID + pu.BenefitsRagOptionID) / 4;
                        if (averageRAG < pu.OverallRagOptionID - 1 || averageRAG > pu.OverallRagOptionID + 1) {
                            valid = false;
                            setShowRAGConfirmDialog(true);
                        }
                    }
                } else {
                    errors.ProjectUpdate = 'No project update has been created for this report';
                    valid = false;
                }
            }
            if (signOffType === SignOffType.PartnerOrganisation) {
                const pu = report.PartnerOrganisation?.PartnerOrganisationUpdates?.[0];
                if (pu) {
                    if (pu.OverallRagOptionID === null) {
                        errors.OverallRagOptionID = 'Delivery confidence RAG rating is missing from the report';
                        valid = false;
                    } else errors.OverallRagOptionID = null;

                    if (pu.FinanceRagOptionID === null) {
                        errors.FinanceRagOptionID = 'Finance RAG rating is missing from the report';
                        valid = false;
                    } else errors.FinanceRagOptionID = null;

                    if (pu.PeopleRagOptionID === null) {
                        errors.PeopleRagOptionID = 'People RAG rating is missing from the report';
                        valid = false;
                    } else errors.PeopleRagOptionID = null;

                    if (pu.MilestonesRagOptionID === null) {
                        errors.MilestonesRagOptionID = 'Milestones RAG rating is missing from the report';
                        valid = false;
                    } else errors.MilestonesRagOptionID = null;

                    if (pu.KPIRagOptionID === null) {
                        errors.KPIRagOptionID = 'Key performance indicator RAG rating is missing from the report';
                        valid = false;
                    } else errors.KPIRagOptionID = null;

                    if (pu.OverallRagOptionID !== null && pu.FinanceRagOptionID !== null && pu.PeopleRagOptionID != null && pu.MilestonesRagOptionID !== null && pu.KPIRagOptionID !== null) {
                        const averageRAG = (pu.FinanceRagOptionID + pu.PeopleRagOptionID + pu.MilestonesRagOptionID + pu.KPIRagOptionID) / 4;
                        if (averageRAG < pu.OverallRagOptionID - 1 || averageRAG > pu.OverallRagOptionID + 1) {
                            valid = false;
                            setShowRAGConfirmDialog(true);
                        }
                    }
                } else {
                    errors.ProjectUpdate = 'No partner organisation update has been created for this report';
                    valid = false;
                }
            }
            if (signOffType === SignOffType.Risk) {
                const ru = (report.Risk as ICorporateRisk)?.RiskUpdates?.[0];
                if (ru) {
                    if (ru.RiskImpactLevelID === null) {
                        errors.RiskImpactLevelID = 'Risk Impact Level rating is missing from the report';
                        valid = false;
                    } else errors.RiskImpactLevelID = null;

                    if (ru.RiskProbabilityID === null) {
                        errors.RiskProbabilityID = 'Risk Probability Level is missing from the report';
                        valid = false;
                    } else errors.RiskProbabilityID = null;
                } else {
                    errors.RiskUpdate = 'No risk update has been created for this report';
                    valid = false;
                }
            }
            if (signOffType === SignOffType.FinancialRisk) {
                const ru = report.FinancialRisk?.FinancialRiskUpdates?.[0];
                if (ru) {
                    if (ru.RiskImpactLevelID === null) {
                        errors.RiskImpactLevelID = 'Risk Impact Level rating is missing from the report';
                        valid = false;
                    } else errors.RiskImpactLevelID = null;

                    if (ru.RiskProbabilityID === null) {
                        errors.RiskProbabilityID = 'Risk Probability Level is missing from the report';
                        valid = false;
                    } else errors.RiskProbabilityID = null;
                } else {
                    errors.RiskUpdate = 'No risk update has been created for this report';
                    valid = false;
                }
            }
        }
        setValidationErrors(errors);
        return valid;
    };

    const saveSignOff = async (overrideRagValidation: boolean): Promise<void> => {
        if (overrideRagValidation || validateSignOff()) {
            setSaveStatus(SaveStatus.Pending);

            const signOff = new SignOff(reportDates?.Next);
            signOff.ReportJson = JSON.stringify(report);

            if (signOffType === SignOffType.Directorate) {
                signOff.DirectorateID = signOffEntityId;
            }
            if (signOffType === SignOffType.Project) {
                signOff.ProjectID = signOffEntityId;
            }
            if (signOffType === SignOffType.PartnerOrganisation) {
                signOff.PartnerOrganisationID = signOffEntityId;
            }
            if (signOffType === SignOffType.Risk) {
                const r = report.Risk as ICorporateRisk;
                signOff.RiskID = signOffEntityId;
                signOff.Title = `${r?.RiskUpdates?.[0]?.RiskCode} - ${r?.RiskUpdates?.[0]?.Title}`;
            }
            if (signOffType === SignOffType.FinancialRisk) {
                const r = report.FinancialRisk;
                signOff.RiskID = signOffEntityId;
                signOff.Title = `${r?.FinancialRiskUpdates?.[0]?.RiskCode} - ${r?.FinancialRiskUpdates?.[0]?.Title}`;
            }

            try {
                const createdSignOff = await signOffService.create(signOff);
                await readSignOffAndApprover(createdSignOff);
                setSaveStatus(SaveStatus.Success);
                setReport(createdSignOff);
                resetErrors();
            } catch (err) {
                setSaveStatus(SaveStatus.Error);
                logError(`Error saving sign-off`, err.message);
            }
        }
    };

    const onCancel = async (): Promise<void> => {
        setValidationErrors(new SignOffBuilderValidations());
        loadReport();
    };

    const readSignOffAndApprover = async (signOff: ISignOff): Promise<ISignOff> => {
        try {
            setSavedReport(await signOffService.read(signOff.ID, true));
            return signOff;
        } catch (err) {
            logError(`Error loading saved sign-off`, err.message);
        }
    };

    const allowApprove = (): boolean => saveStatus !== SaveStatus.Pending;

    return (
        <div className={styles.cr}>
            {signOffEntityId && report && reportDates &&
                <div>
                    {savedReport ?
                        <CrApprovalDetails
                            className={styles.fontSize18}
                            approverName={savedReport?.SignOffUser?.Title}
                            approvalDate={savedReport?.SignOffDate}
                        />
                        :
                        <CrPreviousApprovalDetails
                            className={styles.marginTop12}
                            previouslyApproved={reportMetadata?.LastApproved != null}
                            approvedBy={reportMetadata?.LastApprovedBy}
                            approvedDate={reportMetadata?.LastApproved}
                            changedSinceApproval={reportMetadata?.ChangedSinceApproval}
                        />
                    }
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
                            loadReport={() => loadReport()}
                        />
                    }
                    {signOffType === SignOffType.Risk &&
                        <>
                            {(report?.Risk as ICorporateRisk)?.RiskUpdates?.[0]?.ToBeClosed &&
                                <MessageBar messageBarType={MessageBarType.warning}>
                                    <span>Clicking the Approve button will close this risk. </span>
                                    <span>By clicking the Approve button you confirm that the risk no longer exists because either it has become an issue, or the mitigating actions have worked. </span>
                                    <span>Please remember to let the relevant people know that the risk has closed. </span>
                                </MessageBar>
                            }
                            <DraftReportRisk
                                {...props}
                                report={report}
                                loadReport={() => loadReport()}
                            />
                        </>
                    }
                    {signOffType === SignOffType.FinancialRisk &&
                        <>
                            {report?.FinancialRisk?.FinancialRiskUpdates?.[0]?.ToBeClosed &&
                                <MessageBar messageBarType={MessageBarType.warning}>
                                    <span>Clicking the Approve button will close this risk. </span>
                                    <span>By clicking the Approve button you confirm that the risk no longer exists because either it has become an issue, or the mitigating actions have worked. </span>
                                    <span>Please remember to let the relevant people know that the risk has closed. </span>
                                </MessageBar>
                            }
                            <DraftReportFinancialRisk
                                {...props}
                                report={report}
                                loadReport={() => loadReport()}
                            />
                        </>
                    }
                    {(signOffType === SignOffType.Directorate || signOffType === SignOffType.Project
                        || signOffType === SignOffType.PartnerOrganisation || signOffType == SignOffType.Risk
                        || signOffType === SignOffType.FinancialRisk) &&
                        <div>
                            <ConfirmDialog
                                hidden={!showRAGConfirmDialog}
                                title="Warning"
                                confirmButtonText="Submit"
                                handleConfirm={confirmOverrideRagValidation}
                                handleCancel={() => setShowRAGConfirmDialog(false)}
                            >
                                <p>There is a difference between the RAG rating for delivery confidence and the underlying indicators.</p>
                                <p>To correct this, you can:</p>
                                <ul>
                                    <li>change the ratings in the report</li>
                                    <li>submit anyway if you think you have explained the difference</li>
                                </ul>
                            </ConfirmDialog>
                            {savedReport &&
                                <CrApprovalDetails
                                    className={styles.fontSize18}
                                    approverName={savedReport?.SignOffUser?.Title}
                                    approvalDate={savedReport?.SignOffDate}
                                />
                            }
                            <FormButtons
                                primaryText="Approve"
                                onPrimaryClick={() => saveSignOff(false)}
                                onSecondaryClick={onCancel}
                                primaryStatus={saveStatus}
                                primaryDisabled={!allowApprove()}
                            />
                            <FieldErrorMessage value={validationErrors.DirectorateUpdate} />
                            <FieldErrorMessage value={validationErrors.ProjectUpdate} />
                            <FieldErrorMessage value={validationErrors.PartnerOrganisationUpdate} />
                            <FieldErrorMessage value={validationErrors.OverallRagOptionID} />
                            <FieldErrorMessage value={validationErrors.FinanceRagOptionID} />
                            <FieldErrorMessage value={validationErrors.PeopleRagOptionID} />
                            <FieldErrorMessage value={validationErrors.MilestonesRagOptionID} />
                            <FieldErrorMessage value={validationErrors.MetricsRagOptionID} />
                            <FieldErrorMessage value={validationErrors.BenefitsRagOptionID} />
                            <FieldErrorMessage value={validationErrors.RiskMitigationActionUpdates} />
                            <FieldErrorMessage value={validationErrors.RiskMitigationActions} />
                            <FieldErrorMessage value={validationErrors.RiskProbabilityID} />
                            <FieldErrorMessage value={validationErrors.RiskImpactLevelID} />
                            <FieldErrorMessage value={validationErrors.RiskUpdate} />
                        </div>
                    }
                </div>
                ||
                <CrReportShimmer disableAnimation={!loading}>
                    <div className={styles.fontSize18} style={{ maxWidth: '350px' }}>
                        {loading ?
                            <span>Loading...</span>
                            :
                            <span>Please select a directorate, project, partner organisation or risk to review and sign-off above</span>
                        }
                    </div>
                </CrReportShimmer>
            }
        </div>
    );
};
