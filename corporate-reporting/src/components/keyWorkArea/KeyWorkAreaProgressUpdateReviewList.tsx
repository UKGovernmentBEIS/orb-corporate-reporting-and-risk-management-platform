import React, { useContext } from 'react';
import { IKeyWorkArea, IEntityProgressUpdateReviewListProps, ListDefaults } from '../../types';
import { ProgressUpdateReviewList } from '../ProgressUpdateReviewList';
import { KeyWorkAreaProgressUpdateForm } from './KeyWorkAreaProgressUpdateForm';
import { IObjectWithKey } from 'office-ui-fabric-react';
import { renderEditButton, renderPreviousRag, renderProgressUpdate, renderRag } from '../cr/ListRenderers';
import { OrbUserContext } from '../OrbUserContext';

export const KeyWorkAreaProgressUpdateReviewList = (
    { entities, previousEntities, reportDates, readOnly, onChange, listConfig = ListDefaults, ...other }
        : IEntityProgressUpdateReviewListProps<IKeyWorkArea>
): React.ReactElement => {
    const { userPermissions } = useContext(OrbUserContext);
    const hideEdit = !!(readOnly);
    const lcc = listConfig.columnWidths;
    const lcp = listConfig.placeholders;
    return (
        <ProgressUpdateReviewList
            listTitle="Key work area progress updates"
            listColumns={onEdit => [
                {
                    key: '0', name: '', fieldName: 'key', minWidth: hideEdit ? 1 : lcc.editIcon, maxWidth: lcc.editIcon,
                    onRender: kwa => renderEditButton(onEdit, kwa.key, kwa.EntityUpdateID, !hideEdit && kwa.isEditable)
                },
                {
                    key: '1', name: 'Progress update', fieldName: 'Title', minWidth: 200, isResizable: true, isMultiline: true, onRender: kwa => renderProgressUpdate({
                        title: kwa.Title,
                        comment: kwa.ProgressUpdate,
                        author: kwa.UpdateAuthor,
                        date: kwa.UpdateDate,
                        toBeClosed: kwa.ToBeClosed,
                        attributes: kwa.Attributes
                    })
                },
                { key: '3', name: 'Previous', fieldName: 'PreviousRAG', minWidth: lcc.rag, isResizable: true, onRender: kwa => kwa.key !== 0 && renderPreviousRag(kwa.PreviousRAG) },
                { key: '4', name: 'Current', fieldName: 'CurrentRAG', minWidth: lcc.rag, isResizable: true, onRender: kwa => kwa.key !== 0 && renderRag(kwa.CurrentRAG) },
                { key: '5', name: 'Lead', fieldName: 'LeadUser', minWidth: lcc.user, isResizable: true, isMultiline: true }
            ]}
            listItems={entities?.length > 0 ?
                entities.map(k => {
                    const ku = k.KeyWorkAreaUpdates?.[0];
                    const pku = previousEntities?.find(p => p?.ID === k.ID)?.KeyWorkAreaUpdates?.[0];
                    return {
                        key: k.ID,
                        isEditable: userPermissions.UserCanSubmitKeyWorkAreaUpdates(k),
                        EntityUpdateID: ku?.ID,
                        Attributes: k.Attributes?.filter(atr => atr?.AttributeType?.Display).map(a => a.AttributeType.Title),
                        Title: k.Title,
                        ProgressUpdate: ku ? ku.Comment : lcp.dataTBC,
                        UpdateAuthor: ku?.UpdateUser?.Title,
                        UpdateDate: ku?.UpdateDate,
                        PreviousRAG: pku?.RagOptionID,
                        CurrentRAG: ku?.RagOptionID,
                        LeadUser: k.LeadUser ? k.LeadUser.Title : lcp.dataMissing,
                        ToBeClosed: ku?.ToBeClosed
                    };
                })
                :
                [{ key: 0, Title: 'No key work areas' } as IObjectWithKey]
            }
            progressUpdateFormTitle="Edit key work area progress update"
            progressUpdateForm={(entityId, entityUpdateId, onSaved, onCancelled) =>
                <KeyWorkAreaProgressUpdateForm
                    {...other}
                    reportDates={reportDates}
                    entityId={entityId}
                    entity={entities && entities.find(k => k.ID === entityId)}
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
