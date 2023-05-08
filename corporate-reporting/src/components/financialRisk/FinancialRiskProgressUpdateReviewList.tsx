import React, { useContext, useMemo, useState } from 'react';
import {
    IReportDueDates, IFinancialRisk, IFinancialRiskUpdate, FinancialRiskUpdate,
    FinancialRisk, IBaseComponentProps
} from '../../types';
import styles from '../../styles/cr.module.scss';
import { IconButton } from 'office-ui-fabric-react/lib/Button';
import { Panel, PanelType } from 'office-ui-fabric-react/lib/Panel';
import { CrLastEdit } from '../cr/CrLastEdit';
import { Label } from 'office-ui-fabric-react/lib/Label';
import { CrCheckbox } from '../cr/CrCheckbox';
import { CrTextField } from '../cr/CrTextField';
import { CrDatePicker } from '../cr/CrDatePicker';
import { RiskKeyInfo } from '../risk/RiskKeyInfo';
import { RiskRagIndicator } from '../cr/RiskRagIndicator';
import { FinancialRiskProgressUpdateForm } from './FinancialRiskProgressUpdateForm';
import { SpendProfileField } from './SpendProfileField';
import { HyperlinksField } from '../cr/HyperlinksField';
import { DataContext } from '../DataContext';
import { OrbUserContext } from '../OrbUserContext';

export interface IFinancialRiskProgressUpdateReviewListProps extends IBaseComponentProps {
    riskUpdate?: IFinancialRiskUpdate;
    risk?: IFinancialRisk;
    reportDates?: IReportDueDates;
    hideEditIcon?: boolean;
    onChange?: () => void;
}

export const FinancialRiskProgressUpdateReviewList = (props: IFinancialRiskProgressUpdateReviewListProps): React.ReactElement => {
    const { riskUpdate, risk, hideEditIcon } = props;
    const { userPermissions } = useContext(OrbUserContext);
    const { lookupData, loadLookupData: { riskImpactLevels, riskProbabilities, riskTypes } } = useContext(DataContext);
    const riskId = risk?.ID;
    const [showForm, setShowForm] = useState(false);
    const [riskReport, setRiskReport] = useState<{ riskId: number, riskUpdateId: number }>({ riskId: null, riskUpdateId: null });
    const ru = riskUpdate || new FinancialRiskUpdate();
    const r = risk || new FinancialRisk();
    const hideEdit = hideEditIcon && hideEditIcon === true ? true : false;

    useMemo(() => riskImpactLevels(), [riskImpactLevels]);
    useMemo(() => riskProbabilities(), [riskProbabilities]);
    useMemo(() => riskTypes(), [riskTypes]);

    const closePanel = (): void => {
        setShowForm(false);
    };

    const editUpdate = (entityId: number, entityUpdateId: number): void => {
        setRiskReport({ riskId: entityId, riskUpdateId: entityUpdateId });
        setShowForm(true);
    };

    const closeEditUpdate = (reloadList: boolean): void => {
        setRiskReport({ riskId: null, riskUpdateId: null });
        setShowForm(false);
        if (reloadList && props.onChange) {
            props.onChange();
        }
    };

    return (
        <div className={styles.cr}>
            <div className={styles.formField}>
                <RiskKeyInfo
                    risk={r}
                    riskImpactLevels={lookupData.RiskImpactLevels}
                    riskProbabilities={lookupData.RiskProbabilities}
                    riskTypes={lookupData.RiskTypes}
                />
            </div>
            {riskId && !hideEdit && userPermissions.UserCanSubmitFinancialRiskUpdates(r) &&
                <IconButton iconProps={{ iconName: 'Edit' }} title='Edit' onClick={() => editUpdate(riskId, ru.ID)} />
            }
            <div>
                <Label>Current rating</Label>
                <RiskRagIndicator impactLevel={ru.RiskImpactLevel} probability={ru.RiskProbability} />
            </div>
            <br />
            {ru.ToBeClosed ||
                <>
                    <CrCheckbox label="Is the risk ongoing?" className={styles.formField} disabled={true} checked={ru.RiskIsOngoing} />
                    <CrDatePicker label='What is the proximity of this risk?' className={styles.formField} disabled={true} value={ru.RiskProximity} />
                </>
            }
            <CrCheckbox className={styles.formField} label="Mark for closure?" disabled={true} checked={ru.ToBeClosed} />
            {ru.ToBeClosed &&
                <CrTextField className={styles.formField} label="Reason for closure" disabled={true} multiline value={ru.ClosureReason} />
            }
            {ru.ToBeClosed &&
                <CrTextField className={styles.formField} label="Closure narrative" disabled={true} multiline value={ru.Comment} />
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
            <CrCheckbox
                label="Spend/income profile not applicable?"
                disabled={true}
                className={styles.formField}
                checked={ru.Measurements?.SpendProfileNotApplicable}
            />
            <SpendProfileField
                className={styles.formField}
                disabled={true}
                reportDate={ru.UpdatePeriod}
                value={ru.Measurements?.SpendProfile}
            />
            <HyperlinksField
                label="Attachments"
                description="Add links to any supporting documents or files"
                disabled={true}
                className={styles.formField}
                addEditLinkHelpText="Please ensure access to the linked file is possible for those who will need to review it."
                links={ru.Attachments}
            />
            <CrLastEdit author={ru.UpdateUser?.Title} editDate={ru.UpdateDate} />
            <Panel isOpen={showForm} headerText="Edit risk update" type={PanelType.large} onDismiss={closePanel}>
                <FinancialRiskProgressUpdateForm
                    {...props}
                    entityId={riskReport.riskId}
                    entity={risk}
                    entityUpdateId={riskReport.riskUpdateId}
                    reportDates={props.reportDates}
                    defaultShowForm={true}
                    onSaved={() => closeEditUpdate(true)}
                    onCancelled={() => closeEditUpdate(false)}
                />
            </Panel>
        </div>
    );
};
