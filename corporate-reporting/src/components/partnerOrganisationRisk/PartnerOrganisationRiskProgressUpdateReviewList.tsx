import React, { useContext, useState } from 'react';
import {
    IPartnerOrganisationRisk, IPartnerOrganisationRiskMitigationAction,
    IReportDueDates, IListConfig, ListDefaults, IBaseComponentProps
} from '../../types';
import { RiskRagService } from '../../services';
import { DetailsList, SelectionMode, IColumn, DetailsRow, IDetailsRowProps } from 'office-ui-fabric-react/lib/DetailsList';
import { RagIndicator } from '../cr/RagIndicator';
import { IconButton } from 'office-ui-fabric-react/lib/Button';
import styles from '../../styles/cr.module.scss';
import { Panel, PanelType } from 'office-ui-fabric-react/lib/Panel';
import { PartnerOrganisationRiskProgressUpdateForm } from './PartnerOrganisationRiskProgressUpdateForm';
import { ReviewListProgressUpdate } from '../cr/ReviewListProgressUpdate';
import { PreviousRagIndicator } from '../cr/PreviousRagIndicator';
import { OrbUserContext } from '../OrbUserContext';

export interface IPartnerOrganisationRiskProgressUpdateReviewListProps extends IBaseComponentProps {
    entities: IPartnerOrganisationRisk[];
    previousEntities: IPartnerOrganisationRisk[];
    listConfig: IListConfig;
    reportDates: IReportDueDates;
    riskMitigationActions: IPartnerOrganisationRiskMitigationAction[];
    previousRiskMitigationActions: IPartnerOrganisationRiskMitigationAction[];
    readOnly?: boolean;
    onChange?: () => void;
    listTitle: string;
    editFormTitle?: string;
}

export const PartnerOrganisationRiskProgressUpdateReviewList = (props: IPartnerOrganisationRiskProgressUpdateReviewListProps): React.ReactElement => {
    const { userPermissions } = useContext(OrbUserContext);
    const [editForm, setEditForm] = useState<{ entityId: number, entityUpdateId: number, showForm: boolean }>(
        { entityId: null, entityUpdateId: null, showForm: false });

    const { entities: risks, previousEntities: previousRisks, riskMitigationActions, previousRiskMitigationActions,
        reportDates, listConfig = ListDefaults } = props;

    const _onRenderRow = (rowProps: IDetailsRowProps): JSX.Element => {
        if (rowProps.item.isRisk) {
            return (
                <>
                    <div className={`${styles.reviewListRowDivider} ${styles.reviewListRowDividerGray}`}>Risk:</div>
                    <DetailsRow {...rowProps} />
                    {rowProps.item.hasActions &&
                        <div className={styles.reviewListRowDivider}>Actions:</div>
                    }
                </>
            );
        }
        return <DetailsRow {...rowProps} />;
    };

    const editUpdate = (entityId: number, entityUpdateId: number): void => {
        setEditForm({ entityId: entityId, entityUpdateId: entityUpdateId, showForm: true });
    };

    const closeEditUpdate = (reloadList = false): void => {
        setEditForm({ entityId: null, entityUpdateId: null, showForm: false });
        if (reloadList && props.onChange) props.onChange();
    };

    const riskRagLabel = (impactLevelName: string, probabilityName: string): string => {
        return impactLevelName && probabilityName ? `${impactLevelName}/${probabilityName}` : 'To be completed';
    };

    const lcc = listConfig.columnWidths;
    const lcp = listConfig.placeholders;

    const hideEdit = !!(props.readOnly);
    const risksAndActions = [];
    if (risks?.length > 0) {
        risks.forEach(r => {
            const ru = r.PartnerOrganisationRiskUpdates?.[0];
            const pru = previousRisks?.find(p => p?.ID === r.ID)?.PartnerOrganisationRiskUpdates?.[0];
            risksAndActions.push({
                isRisk: true,
                hasActions: riskMitigationActions &&
                    (1 <= (riskMitigationActions.filter(riskMitigationAction => riskMitigationAction.PartnerOrganisationRiskID === r.ID).length)),
                key: r.ID,
                isEditable: userPermissions.UserCanSubmitPartnerOrganisationRiskUpdates(r),
                EntityUpdateID: ru?.ID,
                Code: r.RiskCode,
                Title: r.Title,
                Comment: ru?.Comment,
                UpdateAuthor: ru?.UpdateUser?.Title,
                UpdateDate: ru?.UpdateDate,
                PreviousRAG: pru?.RagOptionID,
                PreviousRAGLabel: riskRagLabel(pru?.RiskImpactLevel?.Title, pru?.RiskProbability?.Title),
                PreviousBeisRAG: pru?.BeisRagOptionID,
                PreviousBeisRAGLabel: riskRagLabel(pru?.BeisRiskImpactLevel?.Title, pru?.BeisRiskProbability?.Title),
                CurrentRAG: ru?.RagOptionID,
                CurrentRAGLabel: riskRagLabel(ru?.RiskImpactLevel?.Title, ru?.RiskProbability?.Title),
                CurrentBeisRAG: ru?.BeisRagOptionID,
                CurrentBeisRAGLabel: riskRagLabel(ru?.BeisRiskImpactLevel?.Title, ru?.BeisRiskProbability?.Title),
                TargetRAG: r ? RiskRagService.calculateRiskRag(r.TargetRiskImpactLevelID, r.TargetRiskProbabilityID) : null,
                TargetRAGLabel: riskRagLabel(r?.TargetRiskImpactLevel?.Title, r?.TargetRiskProbability?.Title),
                TargetBeisRAG: r ? RiskRagService.calculateRiskRag(r.BEISTargetRiskImpactLevelID, r.BEISTargetRiskProbabilityID) : null,
                TargetBeisRAGLabel: riskRagLabel(r?.BEISTargetRiskImpactLevel?.Title, r?.BEISTargetRiskProbability?.Title),
                LeadUser: r.RiskOwnerUser ? r.RiskOwnerUser.Title : lcp.dataMissing,
                ToBeClosed: ru?.ToBeClosed
            });

            const unorderedActions = [];
            if (riskMitigationActions?.length > 0) {
                const rmas = riskMitigationActions.filter(riskMitigationAction => riskMitigationAction.PartnerOrganisationRiskID === r.ID);
                rmas.forEach((rma, index) => {
                    const rmau = rma?.PartnerOrganisationRiskMitigationActionUpdates?.[0];
                    const prmau = previousRiskMitigationActions?.find(prma => prma.ID === rma.ID)?.PartnerOrganisationRiskMitigationActionUpdates?.[0];
                    unorderedActions.push({
                        isRisk: false,
                        key: r.ID * 100000 + index,
                        EntityUpdateID: rmau?.ID,
                        Code: rma.RiskMitigationActionCode,
                        Title: rma.Title,
                        Comment: rmau ? rmau.Comment : lcp.dataTBC,
                        UpdateAuthor: rmau?.UpdateUser?.Title,
                        UpdateDate: rmau?.UpdateDate,
                        PreviousRAG: prmau?.RagOptionID,
                        CurrentRAG: rmau?.RagOptionID,
                        LeadUser: rma.OwnerUser ? rma.OwnerUser.Title : lcp.dataMissing,
                        ToBeClosed: rmau?.ToBeClosed
                    });
                });

                risksAndActions.push(...unorderedActions.sort((x, y) => x.ToBeClosed === y.ToBeClosed ? 0 : x.ToBeClosed ? 1 : -1));
            }
        });
    } else {
        risksAndActions.push({ key: 0, Title: 'No risks' });
    }

    const isHeader = (key: number) => key === 0;
    const isAction = (key: number) => key >= 100000;

    const listColumns: IColumn[] = [
        {
            key: '0', name: '', fieldName: 'key', minWidth: hideEdit ? 1 : lcc.editIcon, maxWidth: lcc.editIcon, onRender: function renderEditButton(m) {
                return !hideEdit && !isHeader(m.key) && !isAction(m.key) && reportDates &&
                    <IconButton iconProps={{ iconName: 'Edit' }} title='Edit' onClick={() => editUpdate(m.key, m.EntityUpdateID)} />;
            }
        },
        { key: '1', name: 'ID', fieldName: 'Code', minWidth: 50, maxWidth: 75, isResizable: true, isMultiline: true },
        {
            key: '2', name: 'Risk/action and progress', fieldName: 'Title', minWidth: 200, isResizable: true, isMultiline: true, onRender: function renderProgressUpdate(m) {
                return <ReviewListProgressUpdate
                    entityName={m.Title}
                    progressUpdate={m.Comment}
                    updateAuthor={m.UpdateAuthor}
                    updateDate={m.UpdateDate}
                    toBeClosed={m.ToBeClosed}
                />;
            }
        },
        {
            key: '3', name: 'BEIS ratings', fieldName: 'PreviousBeisRAG', minWidth: lcc.rag, isResizable: true, onRender: function renderBeisRags(m) {
                return !isHeader(m.key) && !isAction(m.key) &&
                    <>
                        <div>Previous: <PreviousRagIndicator rag={m.PreviousBeisRAG} label={m.PreviousBeisRAGLabel} /></div>
                        <div>Current: <RagIndicator rag={m.CurrentBeisRAG} label={m.CurrentBeisRAGLabel} /></div>
                        <div>Target: <RagIndicator rag={m.TargetBeisRAG} label={m.TargetBeisRAGLabel} /></div>
                    </>;
            }
        },
        {
            key: '4', name: 'Partner org ratings', fieldName: 'PreviousRAG', minWidth: lcc.rag, isResizable: true, onRender: function renderPreviousRag(m) {
                return !isHeader(m.key) &&
                    <>
                        <div>Previous: <PreviousRagIndicator rag={m.PreviousRAG} label={!isAction(m.key) ? m.PreviousRAGLabel : null} /></div>
                        <div>Current: <RagIndicator rag={m.CurrentRAG} label={!isAction(m.key) ? m.CurrentRAGLabel : null} /></div>
                        {!isAction(m.key) &&
                            <div>Target: <RagIndicator rag={m.TargetRAG} label={m.TargetRAGLabel} /></div>
                        }
                    </>;
            }
        },
        { key: '5', name: 'Lead', fieldName: 'LeadUser', minWidth: lcc.user, isResizable: true, isMultiline: true }
    ];

    return (
        <div className={styles.cr}>
            <div>
                <h3 className={styles.reviewListTitle}>{props.listTitle}</h3>
                <div className={styles.reviewList}>
                    <DetailsList selectionMode={SelectionMode.none} columns={listColumns} items={risksAndActions} onRenderRow={_onRenderRow} />
                </div>
                <Panel isOpen={editForm.showForm} headerText={props.editFormTitle} type={PanelType.medium} onDismiss={() => closeEditUpdate(false)}>
                    <PartnerOrganisationRiskProgressUpdateForm
                        {...props}
                        entityId={editForm.entityId}
                        entityUpdateId={editForm.entityUpdateId}
                        defaultShowForm={true}
                        onSaved={() => closeEditUpdate(true)}
                        onCancelled={() => closeEditUpdate(false)}
                    />
                </Panel>
            </div>
        </div>
    );
};
