import React, { useContext } from 'react';
import { IEntityProgressUpdateReviewListProps, ListDefaults, IRisk, IFinancialRiskMitigationAction } from '../../types';
import { DateService, EntityUpdateService, FinancialRiskService, FinancialRiskMitigationActionService } from '../../services';
import { RagIndicator } from '../cr/RagIndicator';
import { IconButton } from 'office-ui-fabric-react/lib/Button';
import { CrEntityCompleteIcon } from '../cr/CrEntityCompleteIcon';
import { ProgressUpdateReviewList } from '../ProgressUpdateReviewList';
import { RiskMitigationActionProgressUpdateForm } from '../riskMitigationAction/RiskMitigationActionProgressUpdateForm';
import { ReviewListProgressUpdate } from '../cr/ReviewListProgressUpdate';
import { EntityStatus } from '../../refData/EntityStatus';
import { IFinancialRiskMitigationActionUpdate } from '../../types/FinancialRiskMitigationActionUpdate';
import { IObjectWithKey } from 'office-ui-fabric-react';
import { renderDate } from '../cr/ListRenderers';
import { OrbUserContext } from '../OrbUserContext';

export interface IFinancialRiskMitigationActionProgressUpdateReviewListProps extends IEntityProgressUpdateReviewListProps<IFinancialRiskMitigationAction> {
    risk: IRisk;
    riskService: FinancialRiskService;
    riskActionService: FinancialRiskMitigationActionService;
    riskActionUpdateService: EntityUpdateService<IFinancialRiskMitigationActionUpdate>;
    hideOpenActionsView?: boolean;
    hideClosedNoUpdates?: boolean;
    listTitle?: string;
    updateFormTitle?: (entity: IFinancialRiskMitigationAction) => string;
    updateFormParents?: (entity: IFinancialRiskMitigationAction) => string[];
}

export const FinancialRiskMitigationActionProgressUpdateReviewList = (
    { entities, readOnly, risk, hideClosedNoUpdates, hideOpenActionsView,
        listTitle, onChange, listConfig = ListDefaults, updateFormTitle, updateFormParents, ...other }
        : IFinancialRiskMitigationActionProgressUpdateReviewListProps
): React.ReactElement => {
    const { userPermissions } = useContext(OrbUserContext);
    const hideEdit = !!(readOnly);
    const lcc = listConfig.columnWidths;
    const lcp = listConfig.placeholders;
    return (
        <ProgressUpdateReviewList
            listTitle={listTitle || "Financial risk mitigating action updates"}
            listColumns={onEdit => !hideOpenActionsView ?
                [
                    {
                        key: '0', name: '', fieldName: 'key', minWidth: hideEdit ? 1 : lcc.editIcon, maxWidth: lcc.editIcon, onRender: function renderEditButton(a) {
                            return !hideEdit && a.isEditable && a.key !== 0 &&
                                <IconButton iconProps={{ iconName: 'Edit' }} title='Edit' onClick={() => onEdit(a.key, a.EntityUpdateID)} />;
                        }
                    },
                    {
                        key: '1', name: 'Action', fieldName: 'Title', minWidth: 150, maxWidth: 400, isResizable: true, isMultiline: true, onRender: function renderProgressUpdate(a) {
                            return <ReviewListProgressUpdate
                                entityName={a.Title}
                                progressUpdate={a.Comment}
                                updateAuthor={a.UpdateAuthor}
                                updateDate={a.UpdateDate}
                                toBeClosed={a.ToBeClosed}
                            />;
                        }
                    },
                    {
                        key: '2', name: 'RAG rating', fieldName: 'RAG', minWidth: lcc.rag, maxWidth: lcc.rag, isResizable: true, onRender: function renderRag(a) {
                            return a.key !== 0 && <RagIndicator rag={a.RAG} />;
                        }
                    },
                    { key: '3', name: 'Delivery date', fieldName: 'DeliveryDate', minWidth: lcc.date, maxWidth: lcc.date, isResizable: true },
                    { key: '4', name: 'Next review date', fieldName: 'ReviewDateValue', minWidth: lcc.date, maxWidth: lcc.date, isResizable: true, onRender: a => renderDate(a?.ReviewDate) },
                    { key: '5', name: 'Owner', fieldName: 'OwnerUser', minWidth: lcc.user, isResizable: true, isMultiline: true }
                ]
                :
                [
                    {
                        key: '0', name: '', fieldName: 'key', minWidth: hideEdit ? 1 : lcc.editIcon, maxWidth: lcc.editIcon, onRender: function renderEditButton(a) {
                            return !hideEdit && a.key !== 0 &&
                                <IconButton iconProps={{ iconName: 'Edit' }} title='Edit' onClick={() => onEdit(a.key, a.EntityUpdateID)} />;
                        }
                    },
                    {
                        key: '1', name: 'Action', fieldName: 'Title', minWidth: 150, maxWidth: 400, isResizable: true, isMultiline: true, onRender: function renderAction(a) {
                            return <div>{a.AlreadyClosed && <CrEntityCompleteIcon />}{a.Title}</div>;
                        }
                    },
                    { key: '2', name: 'Actual delivery date', fieldName: 'ActualDateValue', minWidth: lcc.date, isResizable: true, onRender: a => renderDate(a?.ActualDate) },
                    { key: '3', name: 'Owner', fieldName: 'OwnerUser', minWidth: lcc.user, isResizable: true, isMultiline: true }
                ]}
            listItems={entities?.length > 0 ?
                entities.map(a => {
                    const au = a.FinancialRiskMitigationActionUpdates?.[0];
                    return {
                        key: a.ID,
                        isEditable: userPermissions.UserCanSubmitRiskMitigationActionUpdates(a, risk),
                        EntityUpdateID: au?.ID,
                        Title: a.Title,
                        Comment: au?.Comment || lcp.dataTBC,
                        DeliveryDate: a.ActionIsOngoing ? 'Ongoing'
                            : au?.ForecastDate ? DateService.dateToUkDate(au.ForecastDate)
                                : a.ForecastDate ? DateService.dateToUkDate(a.ForecastDate)
                                    : a.BaselineDate ? DateService.dateToUkDate(a.BaselineDate)
                                        : lcp.dataMissing,
                        ReviewDate: a.ActionIsOngoing ? DateService.dateToUkDate(a.NextReviewDate) : 'N/A',
                        ReviewDateValue: a?.NextReviewDate?.valueOf(),
                        ActualDate: a?.ActualDate || lcp.dataMissing,
                        ActualDateValue: a?.ActualDate?.valueOf(),
                        OwnerUser: a.OwnerUser?.Title || lcp.dataMissing,
                        ToBeClosed: au?.ToBeClosed,
                        RAG: au?.RagOptionID,
                        UpdateAuthor: au?.UpdateUser?.Title,
                        UpdateDate: au?.UpdateDate,
                        AlreadyClosed: a.EntityStatusID === EntityStatus.Closed,
                        hasUpdates: !!au
                    };
                }).sort((x, y) => (x.ToBeClosed === y.ToBeClosed) ? 0 : x.ToBeClosed ? 1 : -1
                ).filter(rna => ((rna.hasUpdates || !rna.AlreadyClosed) || !hideClosedNoUpdates) && (rna.AlreadyClosed || !hideOpenActionsView))
                :
                [{ key: 0, Title: 'No actions' } as IObjectWithKey]
            }
            progressUpdateFormTitle="Edit risk mitigating action progress update"
            progressUpdateForm={(entityId, entityUpdateId, onSaved, onCancelled) =>
                <RiskMitigationActionProgressUpdateForm
                    {...other}
                    title={updateFormTitle}
                    parents={updateFormParents}
                    entityId={entityId}
                    entity={entities?.find(r => r.ID === entityId)}
                    entityUpdateId={entityUpdateId}
                    defaultShowForm={true}
                    onSaved={onSaved}
                    onCancelled={onCancelled}
                    maxNarrativeLength={500}
                />
            }
            onChange={onChange}
        />
    );
};
