import React, { useContext, useMemo, useState } from 'react';
import { IRiskUpdate, RiskUpdate, Risk, IRisk, IReportDueDates, IBaseComponentProps } from '../../types';
import styles from '../../styles/cr.module.scss';
import { IconButton } from 'office-ui-fabric-react/lib/Button';
import { Panel, PanelType } from 'office-ui-fabric-react/lib/Panel';
import { RiskProgressUpdateForm } from './RiskProgressUpdateForm';
import { CrLastEdit } from '../cr/CrLastEdit';
import { Label } from 'office-ui-fabric-react/lib/Label';
import { CrCheckbox } from '../cr/CrCheckbox';
import { RiskRegister } from '../../refData/RiskRegister';
import { CrTextField } from '../cr/CrTextField';
import { CrDatePicker } from '../cr/CrDatePicker';
import { RiskKeyInfo } from './RiskKeyInfo';
import { RiskRagIndicator } from '../cr/RiskRagIndicator';
import { DataContext } from '../DataContext';
import { OrbUserContext } from '../OrbUserContext';
import { CrDropdown } from '../cr/CrDropdown';
import { LookupService } from '../../services';

export interface IRiskProgressUpdateReviewProps extends IBaseComponentProps {
    riskUpdate?: IRiskUpdate;
    risk?: IRisk;
    reportDates?: IReportDueDates;
    hideEditIcon?: boolean;
    onChange?: () => void;
}

export const RiskProgressUpdateReviewList = (props: IRiskProgressUpdateReviewProps): React.ReactElement => {
    const { riskUpdate, risk, hideEditIcon } = props;
    const { userPermissions } = useContext(OrbUserContext);
    const { lookupData, loadLookupData: { riskDiscussionForums, riskImpactLevels, riskProbabilities, riskTypes } } = useContext(DataContext);
    const riskId = risk?.ID;
    const [showForm, setShowForm] = useState(false);
    const [entity, setEntity] = useState<{ entityId: number, entityUpdateId: number }>({ entityId: null, entityUpdateId: null });
    const ru = riskUpdate || new RiskUpdate();
    const r = risk || new Risk();
    const hideEdit = hideEditIcon && hideEditIcon === true ? true : false;

    useMemo(() => riskDiscussionForums(), [riskDiscussionForums]);
    useMemo(() => riskImpactLevels(), [riskImpactLevels]);
    useMemo(() => riskProbabilities(), [riskProbabilities]);
    useMemo(() => riskTypes(), [riskTypes]);

    const editUpdate = (entityId: number, entityUpdateId: number): void => {
        setShowForm(true);
        setEntity({ entityId: entityId, entityUpdateId: entityUpdateId });
    };

    const closeEditUpdate = (reloadList: boolean): void => {
        setShowForm(false);
        setEntity({ entityId: null, entityUpdateId: null });
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
            {riskId && !hideEdit && userPermissions.UserCanSubmitRiskUpdates(r) &&
                <IconButton iconProps={{ iconName: 'Edit' }} title='Edit' onClick={() => editUpdate(riskId, ru.ID)} />
            }
            <div>
                <Label>Current Rating</Label>
                <RiskRagIndicator impactLevel={ru.RiskImpactLevel} probability={ru.RiskProbability} />
            </div>
            <br />
            {ru.ToBeClosed ||
                <>
                    <CrCheckbox label="Is the risk ongoing?" className={styles.formField} disabled={true} checked={ru.RiskIsOngoing} />
                    <CrDatePicker label='What is the proximity of this risk?' className={styles.formField} disabled={true} value={ru.RiskProximity} />
                </>
            }
            {r?.RiskRegisterID !== RiskRegister.Departmental &&
                <>
                    <CrCheckbox className={styles.formField} label="Request that this risk be escalated" disabled={true} checked={ru.Escalate} />
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
                            <CrTextField className={styles.formField} label="Why should this risk be escalated?" disabled={true} multiline value={ru.Comment} />
                        </>
                    }
                </>
            }
            <CrCheckbox className={styles.formField} label="Request that this risk be discussed" disabled={true} checked={ru.ToBeDiscussed} />
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
            {r?.RiskRegisterID !== RiskRegister.Directorate &&
                <>
                    <CrCheckbox className={styles.formField} label="Request that this risk be de-escalated" disabled={true} checked={ru.DeEscalate} />
                    {ru.DeEscalate &&
                        <CrTextField className={styles.formField} label="Why should this risk be de-escalated?" disabled={true} multiline value={ru.Comment} />
                    }
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
            <CrLastEdit author={ru.UpdateUser?.Title} editDate={ru.UpdateDate} />
            <Panel isOpen={showForm} headerText="Edit risk update" type={PanelType.large} onDismiss={() => setShowForm(false)}>
                <RiskProgressUpdateForm
                    {...props}
                    entityId={entity.entityId}
                    entity={props.risk}
                    entityUpdateId={entity.entityUpdateId}
                    reportDates={props.reportDates}
                    defaultShowForm={true}
                    onSaved={() => closeEditUpdate(true)}
                    onCancelled={() => closeEditUpdate(false)}
                />
            </Panel>
        </div>
    );
};
