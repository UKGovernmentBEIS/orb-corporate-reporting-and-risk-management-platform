import React, { useContext } from 'react';
import { IWorkStream, IEntityProgressUpdateReviewListProps, ListDefaults } from '../../types';
import { ProgressUpdateReviewList } from '../ProgressUpdateReviewList';
import { WorkStreamProgressUpdateForm } from './WorkStreamProgressUpdateForm';
import { IObjectWithKey } from 'office-ui-fabric-react';
import { renderEditButton, renderPreviousRag, renderProgressUpdate, renderRag } from '../cr/ListRenderers';
import { OrbUserContext } from '../OrbUserContext';

export const WorkStreamProgressUpdateReviewList = (
    { entities, previousEntities, reportDates, readOnly, onChange, showPreviousUpdate, listConfig = ListDefaults, ...other }
        : IEntityProgressUpdateReviewListProps<IWorkStream>
): React.ReactElement => {
    const { userPermissions } = useContext(OrbUserContext);
    const hideEdit = !!(readOnly);
    const lcc = listConfig.columnWidths;
    const lcp = listConfig.placeholders;
    return (
        <ProgressUpdateReviewList
            listTitle="Work stream updates"
            listColumns={onEdit => [
                {
                    key: '0', name: '', fieldName: 'key', minWidth: hideEdit ? 1 : lcc.editIcon, maxWidth: lcc.editIcon,
                    onRender: ws => renderEditButton(onEdit, ws.key, ws.EntityUpdateID, !hideEdit && ws.isEditable && !!reportDates)
                },
                {
                    key: '1', name: 'Progress Update', fieldName: 'Title', minWidth: 200, isResizable: true, isMultiline: true, onRender: ws => renderProgressUpdate({
                        title: ws.Title,
                        comment: ws.ProgressUpdate,
                        author: ws.UpdateAuthor,
                        date: ws.UpdateDate,
                        toBeClosed: ws.ToBeClosed,
                        attributes: ws.Attributes,
                        previousComment: showPreviousUpdate && ws.PreviousProgressUpdate
                    })
                },
                { key: '2', name: 'Previous', fieldName: 'PreviousRAG', minWidth: lcc.rag, isResizable: true, onRender: ws => ws.key !== 0 && renderPreviousRag(ws.PreviousRAG) },
                { key: '3', name: 'Current', fieldName: 'CurrentRAG', minWidth: lcc.rag, isResizable: true, onRender: ws => ws.key !== 0 && renderRag(ws.CurrentRAG) },
                { key: '4', name: 'Lead', fieldName: 'LeadUser', minWidth: lcc.user, isResizable: true, isMultiline: true }
            ]}
            listItems={entities?.length > 0 ?
                entities.map(w => {
                    const wu = w.WorkStreamUpdates?.[0];
                    const pwu = previousEntities?.find(p => p?.ID === w.ID)?.WorkStreamUpdates?.[0];
                    return {
                        key: w.ID,
                        isEditable: userPermissions.UserCanSubmitWorkStreamUpdates(w),
                        EntityUpdateID: wu?.ID,
                        Attributes: w.Attributes?.filter(atr => atr?.AttributeType?.Display).map(a => a.AttributeType.Title),
                        Title: w.Title,
                        PreviousProgressUpdate: pwu ? pwu.Comment : lcp.dataTBC,
                        ProgressUpdate: wu ? wu.Comment : lcp.dataTBC,
                        UpdateAuthor: wu?.UpdateUser?.Title,
                        UpdateDate: wu?.UpdateDate,
                        PreviousRAG: pwu?.RagOptionID,
                        CurrentRAG: wu?.RagOptionID,
                        LeadUser: w.LeadUser ? w.LeadUser.Title : lcp.dataMissing,
                        ToBeClosed: wu?.ToBeClosed
                    };
                })
                :
                [{ key: 0, Title: 'No work streams' } as IObjectWithKey]
            }
            progressUpdateFormTitle="Edit work stream progress update"
            progressUpdateForm={(entityId, entityUpdateId, onSaved, onCancelled) =>
                <WorkStreamProgressUpdateForm
                    {...other}
                    entityId={entityId}
                    entity={entities && entities.find(w => w.ID === entityId)}
                    reportDates={reportDates}
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
