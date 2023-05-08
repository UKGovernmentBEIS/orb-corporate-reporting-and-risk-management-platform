import React, { useCallback, useContext, useEffect, useMemo, useState } from 'react';
import {
    IRiskMitigationAction, IRiskMitigationActionUpdate,
    ReportDueDates, ISignOff, RiskUpdate, ICorporateRisk, IBaseComponentProps
} from '../../types';
import { RiskRagService, AttributeService, RiskAppetiteService, LookupService } from '../../services';
import styles from '../../styles/cr.module.scss';
import { CrCheckbox } from '../cr/CrCheckbox';
import { RagIndicator } from '../cr/RagIndicator';
import { Label } from 'office-ui-fabric-react/lib/Label';
import { CrTextField } from '../cr/CrTextField';
import { UpdateHeader } from '../cr/UpdateHeader';
import { CrDatePicker } from '../cr/CrDatePicker';
import { RiskRegister } from '../../refData/RiskRegister';
import { CrApprovalDetails } from '../cr/CrApprovalDetails';
import { RiskMitigationActionProgressUpdateReviewList } from '../riskMitigationAction/RiskMitigationActionProgressUpdateReviewList';
import { RiskKeyInfo } from '../risk/RiskKeyInfo';
import { CrInlineIcon } from '../cr/CrInlineIcon';
import { EntityStatus } from '../../refData/EntityStatus';
import { DataContext } from '../DataContext';
import { CrDropdown } from '../cr/CrDropdown';

export interface IRiskRegisterRiskProps extends IBaseComponentProps {
    risk: ICorporateRisk;
    reportDate: Date;
    signOff?: ISignOff;
}

export const RiskRegisterRisk = (props: IRiskRegisterRiskProps): React.ReactElement => {
    const { errorHandling: { onError }, risk, signOff, reportDate } = props;
    const { dataServices: { corporateRiskService, corporateRiskMitigationActionService, corporateRiskMitigationActionUpdateService },
        lookupData, loadLookupData: { riskDiscussionForums, riskImpactLevels, riskProbabilities, riskTypes } } = useContext(DataContext);
    const [showForm, setShowForm] = useState(false);
    const [riskMitigationActions, setRiskMitigationActions] = useState<IRiskMitigationAction[]>([]);
    const [riskMitigationActionUpdates, setRiskMitigationActionUpdates] = useState<IRiskMitigationActionUpdate[]>([]);
    const ru = (signOff?.Risk as ICorporateRisk)?.RiskUpdates?.[0] || new RiskUpdate();
    const currentMonth = reportDate.getUTCMonth() === (new Date()).getUTCMonth();
    const logError = useCallback(onError, [onError]);

    useMemo(() => riskDiscussionForums(), [riskDiscussionForums]);
    useMemo(() => riskImpactLevels(), [riskImpactLevels]);
    useMemo(() => riskProbabilities(), [riskProbabilities]);
    useMemo(() => riskTypes(), [riskTypes]);

    useEffect(() => {
        const loadActionsAndUpdates = async () => {
            if (signOff?.ID) {
                setRiskMitigationActions(signOff.RiskMitigationActions);
                setRiskMitigationActionUpdates(signOff.RiskMitigationActions?.map(a => a.RiskMitigationActionUpdates?.[0]).filter(rmau => rmau));
            } else {
                try {
                    const rma = await loadRiskMitigationActions(risk?.ID);
                    setRiskMitigationActions(rma);
                    const rmaUpdates = await loadRiskMitigationActionUpdates(rma);
                    setRiskMitigationActionUpdates(rmaUpdates.filter(rmau => rmau));
                } catch (err) {
                    logError(`Error loading risk actions`, err.message);
                }
            }
        };

        const loadRiskMitigationActions = async (riskId: number): Promise<IRiskMitigationAction[]> => {
            const rma = await corporateRiskMitigationActionService.readMitigationActionsForRisk(riskId);
            if (rma) {
                return rma;
            }
            return Promise.resolve([]);
        };

        const loadRiskMitigationActionUpdates = async (actions: IRiskMitigationAction[]): Promise<IRiskMitigationActionUpdate[]> => {
            return Promise.all(
                actions.map(async a =>
                    await corporateRiskMitigationActionUpdateService.readLatestUpdateForPeriod(a.ID, reportDate)
                )
            );
        };

        if (showForm) {
            loadActionsAndUpdates();
        }
    }, [risk?.ID, reportDate, signOff?.ID, signOff?.RiskMitigationActions, showForm,
        corporateRiskMitigationActionService, corporateRiskMitigationActionUpdateService, logError]);

    return (
        <div className={styles.cr}>
            <UpdateHeader
                title={`${risk.RiskCode} - ${risk.Title}`}
                closedDate={risk.EntityStatusID === EntityStatus.Closed && risk.EntityStatusDate}
                tags={risk.Attributes && AttributeService.attributesToBadgeStrings(risk.Attributes)}
                parents={[
                    risk.RiskRegisterID === RiskRegister.Departmental && risk.Directorate?.Group?.Title,
                    (risk.RiskRegisterID === RiskRegister.Departmental || risk.RiskRegisterID === RiskRegister.Group) && risk.Directorate?.Title,
                    risk.Project?.Title
                ].filter(p => p)}
                people={risk.RiskOwnerUser && [{ role: 'Lead', names: [risk.RiskOwnerUser.Title] }]}
                dueDate={ru.UpdatePeriod}
                rag={ru.RagOptionID}
                ragLabel={(ru.RiskImpactLevel && ru.RiskProbability && `${ru.RiskImpactLevel?.Title}/${ru.RiskProbability?.Title}`)
                    || (!currentMonth && 'Not completed')}
                isOpen={showForm}
                onClick={() => setShowForm(!showForm)}
            />
            {showForm &&
                <div className={styles.riskRegisterRiskForm}>
                    <div className={styles.cr}>
                        <div className={styles.formField}>
                            <RiskKeyInfo
                                risk={risk}
                                riskImpactLevels={lookupData.RiskImpactLevels}
                                riskProbabilities={lookupData.RiskProbabilities}
                                riskTypes={lookupData.RiskTypes}
                            />
                        </div>
                        <div className={styles.grid}>
                            <div className={styles.gridRow}>
                                <div className={`${styles.gridCol} ${styles.sm8}`}>
                                    <Label>Current rating</Label>
                                    <RagIndicator
                                        rag={RiskRagService.calculateRiskRag(ru.RiskImpactLevelID, ru.RiskProbabilityID)}
                                        label={(ru.RiskImpactLevel && ru.RiskProbability && `${ru.RiskImpactLevel?.Title}/${ru.RiskProbability?.Title}`)
                                            || (!currentMonth && 'Not completed')}
                                    />
                                </div>
                                <div className={`${styles.gridCol} ${styles.sm4}`}>
                                    <Label>Risk appetite threshold</Label>
                                    <div style={{ padding: '3px' }}>
                                        {RiskAppetiteService.riskWithinBoundary(lookupData.RiskTypes, ru, risk) &&
                                            <span><CrInlineIcon iconName="Like" /> Inside</span>
                                            ||
                                            <span><CrInlineIcon iconName="Warning" /> Outside</span>
                                        }
                                    </div>
                                </div>
                            </div>
                            <div className={styles.gridRow}>
                                <div className={`${styles.gridCol} ${styles.sm12}`}>
                                    {ru.ToBeClosed ||
                                        <>
                                            <CrCheckbox
                                                label="Is the risk ongoing?"
                                                className={styles.formField}
                                                disabled={true}
                                                checked={ru.RiskIsOngoing}
                                            />
                                            <CrDatePicker
                                                label='What is the proximity of this risk?'
                                                className={styles.formField}
                                                disabled={true}
                                                value={ru.RiskProximity}
                                            />
                                        </>
                                    }
                                    {risk.RiskRegisterID !== RiskRegister.Departmental &&
                                        <>
                                            <CrCheckbox
                                                className={styles.formField}
                                                label="Request that this risk be escalated"
                                                disabled={true}
                                                checked={ru.Escalate}
                                            />
                                            {ru.Escalate &&
                                                <>
                                                    <CrDropdown
                                                        label="Which register you would like the risk to be escalated to?"
                                                        className={styles.formField}
                                                        disabled={true}
                                                        options={[
                                                            { key: RiskRegister.Departmental, text: 'Departmental' },
                                                            { key: RiskRegister.Group, text: 'Group' }
                                                        ]}
                                                        selectedKey={ru.EscalateToRiskRegisterID}
                                                    />
                                                    <CrTextField
                                                        className={styles.formField}
                                                        label="Why should this risk be escalated?"
                                                        disabled={true}
                                                        multiline
                                                        value={ru.Comment}
                                                    />
                                                </>
                                            }
                                        </>
                                    }
                                    <CrCheckbox
                                        className={styles.formField}
                                        label="Request that this risk be discussed"
                                        disabled={true}
                                        checked={ru.ToBeDiscussed}
                                    />
                                    {ru.ToBeDiscussed &&
                                        <CrDropdown
                                            label="Where would you like the risk to be discussed?"
                                            multiSelect
                                            className={styles.formField}
                                            disabled={true}
                                            options={LookupService.arrayToDropdownOptions([...new Set([
                                                ...lookupData.RiskDiscussionForums?.map(f => f.Title),
                                                ...ru.DiscussionForum
                                            ])])}
                                            selectedKeys={ru.DiscussionForum}
                                        />
                                    }
                                    {risk.RiskRegisterID !== RiskRegister.Directorate &&
                                        <>
                                            <CrCheckbox
                                                className={styles.formField}
                                                label="Request that this risk be de-escalated"
                                                disabled={true}
                                                checked={ru.DeEscalate}
                                            />
                                            {ru.DeEscalate &&
                                                <CrTextField
                                                    className={styles.formField}
                                                    label="Why should this risk be de-escalated?"
                                                    disabled={true}
                                                    multiline
                                                    value={ru.Comment}
                                                />
                                            }
                                        </>
                                    }
                                    <CrCheckbox
                                        className={styles.formField}
                                        label="Mark for closure?"
                                        disabled={true}
                                        checked={ru.ToBeClosed}
                                    />
                                    {ru.ToBeClosed &&
                                        <CrTextField
                                            className={styles.formField}
                                            label="Closure narrative"
                                            disabled={true}
                                            multiline
                                            value={ru.Comment}
                                        />
                                    }
                                    <CrTextField
                                        label="Narrative"
                                        className={styles.formField}
                                        placeholder='Please describe how you have come to this overall rating?'
                                        multiline
                                        rows={2}
                                        disabled={true}
                                        maxLength={500}
                                        charCounter={true}
                                        value={ru.Narrative}
                                    />
                                    <RiskMitigationActionProgressUpdateReviewList
                                        {...props}
                                        hideClosedNoUpdates={true}
                                        readOnly={true}
                                        entities={riskMitigationActions
                                            .filter(a => a.EntityStatusID === EntityStatus.Open)
                                            .map(a => ({
                                                ...a,
                                                RiskMitigationActionUpdates: riskMitigationActionUpdates
                                                    .filter(u => u.RiskMitigationActionID === a.ID)
                                            }))}
                                        previousEntities={[]}
                                        reportDates={new ReportDueDates}
                                        riskService={corporateRiskService}
                                        riskActionService={corporateRiskMitigationActionService}
                                        riskActionUpdateService={corporateRiskMitigationActionUpdateService}
                                    />
                                    <RiskMitigationActionProgressUpdateReviewList
                                        {...props}
                                        listTitle="Closed risk mitigating action updates"
                                        hideOpenActionsView={true}
                                        readOnly={true}
                                        entities={riskMitigationActions
                                            .filter(a => a.EntityStatusID === EntityStatus.Closed)
                                            .map(a => ({
                                                ...a,
                                                RiskMitigationActionUpdates: riskMitigationActionUpdates
                                                    .filter(u => u.RiskMitigationActionID === a.ID)
                                            }))}
                                        previousEntities={[]}
                                        reportDates={new ReportDueDates}
                                        riskService={corporateRiskService}
                                        riskActionService={corporateRiskMitigationActionService}
                                        riskActionUpdateService={corporateRiskMitigationActionUpdateService}
                                    />
                                    {signOff?.SignOffUser && ru.UpdateDate &&
                                        <CrApprovalDetails
                                            approverName={signOff?.SignOffUser?.Title}
                                            approvalDate={ru.UpdateDate}
                                        />
                                    }
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            }
        </div>
    );
};
