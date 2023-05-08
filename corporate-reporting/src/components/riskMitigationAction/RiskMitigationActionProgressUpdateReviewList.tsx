import React, { useContext } from 'react';
import { IEntityProgressUpdateReviewListProps, ListDefaults, IRisk, IRiskMitigationActionUpdate, ICorporateRiskMitigationAction } from '../../types';
import { CorporateRiskService, EntityUpdateService, RiskMitigationActionService } from '../../services';
import { CrEntityCompleteIcon } from '../cr/CrEntityCompleteIcon';
import { ProgressUpdateReviewList } from '../ProgressUpdateReviewList';
import { RiskMitigationActionProgressUpdateForm } from './RiskMitigationActionProgressUpdateForm';
import { EntityStatus } from '../../refData/EntityStatus';
import { IObjectWithKey } from 'office-ui-fabric-react';
import { renderDate, renderEditButton, renderProgressUpdate, renderRag } from '../cr/ListRenderers';
import { OrbUserContext } from '../OrbUserContext';

export interface IRiskMitigationActionProgressUpdateReviewListProps extends IEntityProgressUpdateReviewListProps<ICorporateRiskMitigationAction> {
    risk: IRisk;
    riskService: CorporateRiskService;
    riskActionService: RiskMitigationActionService<ICorporateRiskMitigationAction>;
    riskActionUpdateService: EntityUpdateService<IRiskMitigationActionUpdate>;
    hideOpenActionsView?: boolean;
    hideClosedNoUpdates?: boolean;
    listTitle?: string;
    updateFormTitle?: (entity: ICorporateRiskMitigationAction) => string;
    updateFormParents?: (entity: ICorporateRiskMitigationAction) => string[];
}

export const RiskMitigationActionProgressUpdateReviewList = (
    { entities, readOnly, risk, hideClosedNoUpdates, hideOpenActionsView,
        listTitle, onChange, listConfig = ListDefaults, updateFormTitle, updateFormParents, ...other }
        : IRiskMitigationActionProgressUpdateReviewListProps
): React.ReactElement => {
    const { userPermissions } = useContext(OrbUserContext);
    const hideEdit = !!(readOnly);
    const lcc = listConfig.columnWidths;
    const lcp = listConfig.placeholders;

    const items = entities
        ?.map(a => {
            const au = a.RiskMitigationActionUpdates?.[0];
            return {
                key: a.ID,
                isEditable: userPermissions.UserCanSubmitRiskMitigationActionUpdates(a, risk),
                EntityUpdateID: au?.ID,
                Title: a.Title,
                Comment: au?.Comment || lcp.dataTBC,
                DeliveryDate: a.ActionIsOngoing ? 'Ongoing'
                    : au?.ForecastDate ? au.ForecastDate
                        : a.ForecastDate ? a.ForecastDate
                            : a.BaselineDate ? a.BaselineDate
                                : '',
                DeliveryDateValue: a.ActionIsOngoing ? 'Ongoing'
                    : au?.ForecastDate ? au.ForecastDate?.valueOf()
                        : a.ForecastDate ? a.ForecastDate?.valueOf()
                            : a.BaselineDate ? a.BaselineDate?.valueOf()
                                : '',
                ReviewDate: a.ActionIsOngoing ? a.NextReviewDate : 'N/A',
                ReviewDateValue: a.ActionIsOngoing ? a.NextReviewDate?.valueOf() : 'N/A',
                ActualDate: a?.ActualDate || lcp.dataMissing,
                ActualDateValue: a?.ActualDate?.valueOf() || lcp.dataMissing,
                OwnerUser: a.OwnerUser?.Title || lcp.dataMissing,
                ToBeClosed: au?.ToBeClosed,
                RAG: au?.RagOptionID,
                UpdateAuthor: au?.UpdateUser?.Title,
                UpdateDate: au?.UpdateDate,
                AlreadyClosed: a.EntityStatusID === EntityStatus.Closed,
                hasUpdates: !!au
            };
        })
        .sort((x, y) => (x.ToBeClosed === y.ToBeClosed) ? 0 : x.ToBeClosed ? 1 : -1)
        .filter(rna => ((rna.hasUpdates || !rna.AlreadyClosed) || !hideClosedNoUpdates) && (rna.AlreadyClosed || !hideOpenActionsView));

    return (
        <ProgressUpdateReviewList
            listTitle={listTitle || "Risk mitigating action updates"}
            listColumns={onEdit => !hideOpenActionsView ?
                [
                    {
                        key: '0', name: '', fieldName: 'key', minWidth: hideEdit ? 1 : lcc.editIcon, maxWidth: lcc.editIcon,
                        onRender: a => renderEditButton(onEdit, a.key, a.EntityUpdateID, !hideEdit && a.isEditable)
                    },
                    {
                        key: '1', name: 'Action', fieldName: 'Title', minWidth: 150, maxWidth: 400, isResizable: true, isMultiline: true, onRender: a => renderProgressUpdate({
                            title: a.Title,
                            comment: a.Comment,
                            author: a.UpdateAuthor,
                            date: a.UpdateDate,
                            toBeClosed: a.ToBeClosed
                        })
                    },
                    { key: '2', name: 'RAG rating', fieldName: 'RAG', minWidth: lcc.rag, maxWidth: lcc.rag, isResizable: true, onRender: a => a.key !== 0 && renderRag(a.RAG) },
                    { key: '3', name: 'Delivery date', fieldName: 'DeliveryDateValue', minWidth: lcc.date, maxWidth: lcc.date, isResizable: true, onRender: a => renderDate(a.DeliveryDate, a.key !== 0 && lcp.dataMissing) },
                    { key: '4', name: 'Next review date', fieldName: 'ReviewDateValue', minWidth: lcc.date, maxWidth: lcc.date, isResizable: true, onRender: a => renderDate(a.ReviewDate, a.key !== 0 && 'N/A') },
                    { key: '5', name: 'Owner', fieldName: 'OwnerUser', minWidth: lcc.user, isResizable: true, isMultiline: true }
                ]
                :
                [
                    {
                        key: '0', name: '', fieldName: 'key', minWidth: hideEdit ? 1 : lcc.editIcon, maxWidth: lcc.editIcon,
                        onRender: a => renderEditButton(onEdit, a.key, a.EntityUpdateID, !hideEdit)
                    },
                    {
                        key: '1', name: 'Action', fieldName: 'Title', minWidth: 150, maxWidth: 400, isResizable: true, isMultiline: true, onRender: function renderAction(a) {
                            return (
                                <div>{a.AlreadyClosed && <CrEntityCompleteIcon />}{a.Title}</div>
                            );
                        }
                    },
                    { key: '2', name: 'Actual delivery date', fieldName: 'ActualDateValue', minWidth: lcc.date, isResizable: true, onRender: a => renderDate(a?.ActualDate) },
                    { key: '3', name: 'Owner', fieldName: 'OwnerUser', minWidth: lcc.user, isResizable: true, isMultiline: true }
                ]}
            listItems={items?.length > 0 ? items : [{ key: 0, Title: 'No actions' } as IObjectWithKey]}
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
                />
            }
            onChange={onChange}
        />
    );
};
