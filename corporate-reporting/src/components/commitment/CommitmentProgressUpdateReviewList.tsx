import React, { useContext } from 'react';
import { ICommitment, IEntityProgressUpdateReviewListProps, ListDefaults } from '../../types';
import { AttributeService } from '../../services';
import { ProgressUpdateReviewList } from '../ProgressUpdateReviewList';
import { CommitmentProgressUpdateForm } from './CommitmentProgressUpdateForm';
import { IObjectWithKey } from 'office-ui-fabric-react';
import { renderDate, renderEditButton, renderPreviousRag, renderProgressUpdate, renderRag } from '../cr/ListRenderers';
import { OrbUserContext } from '../OrbUserContext';

export const CommitmentProgressUpdateReviewList = (
    { entities, previousEntities, reportDates, readOnly, onChange, listConfig = ListDefaults, ...other }
        : IEntityProgressUpdateReviewListProps<ICommitment>
): React.ReactElement => {
    const { userPermissions } = useContext(OrbUserContext);
    const hideEdit = !!(readOnly);
    const lcc = listConfig.columnWidths;
    const lcp = listConfig.placeholders;
    return (
        <ProgressUpdateReviewList
            listTitle="Commitment progress updates"
            listColumns={onEdit => [
                {
                    key: '0', name: '', fieldName: 'key', minWidth: hideEdit ? 1 : lcc.editIcon, maxWidth: lcc.editIcon,
                    onRender: c => renderEditButton(onEdit, c.key, c.EntityUpdateID, !hideEdit && c.isEditable)
                },
                {
                    key: '1', name: 'Commitment', fieldName: 'Title', minWidth: 200, isResizable: true, isMultiline: true, onRender: c => renderProgressUpdate({
                        title: c.Title,
                        comment: c.ProgressUpdate,
                        author: c.UpdateAuthor,
                        date: c.UpdateDate,
                        toBeClosed: c.ToBeClosed,
                        attributes: c.Attributes
                    })
                },
                { key: '4', name: 'Baseline', fieldName: 'BaselineDateValue', minWidth: lcc.date, isResizable: true, onRender: c => renderDate(c.BaselineDate, c.key !== 0 && lcp.dataMissing) },
                { key: '5', name: 'Forecast', fieldName: 'ForecastDateValue', minWidth: lcc.date, isResizable: true, onRender: c => renderDate(c.ForecastDate, c.key !== 0 && lcp.dataTBC) },
                { key: '6', name: 'Actual', fieldName: 'ActualDateValue', minWidth: lcc.date, isResizable: true, onRender: c => renderDate(c.ActualDate, c.key !== 0 && lcp.dataTBC) },
                { key: '7', name: 'Previous', fieldName: 'PreviousRAG', minWidth: lcc.rag, isResizable: true, onRender: c => c.key !== 0 && renderPreviousRag(c.PreviousRAG) },
                { key: '8', name: 'Current', fieldName: 'CurrentRAG', minWidth: lcc.rag, isResizable: true, onRender: c => c.key !== 0 && renderRag(c.CurrentRAG) },
                { key: '9', name: 'Lead', fieldName: 'LeadUser', minWidth: lcc.user, isResizable: true, isMultiline: true }
            ]}
            listItems={entities?.length > 0 ?
                entities.map(c => {
                    const cu = c.CommitmentUpdates?.[0];
                    const pcu = previousEntities?.find(p => p.ID === c.ID)?.CommitmentUpdates?.[0];
                    return {
                        key: c.ID,
                        isEditable: userPermissions.UserCanSubmitCommitmentUpdates(c),
                        EntityUpdateID: cu?.ID,
                        Attributes: AttributeService.attributesToBadgeStrings(c.Attributes),
                        Title: c.Title,
                        ProgressUpdate: cu ? cu.Comment : lcp.dataTBC,
                        UpdateAuthor: cu?.UpdateUser?.Title,
                        UpdateDate: cu?.UpdateDate,
                        BaselineDate: c.BaselineDate,
                        BaselineDateValue: c.BaselineDate?.valueOf(),
                        ForecastDate: cu?.ForecastDate,
                        ForecastDateValue: cu?.ForecastDate?.valueOf(),
                        ActualDate: cu?.ActualDate,
                        ActualDateValue: cu?.ActualDate?.valueOf(),
                        PreviousRAG: pcu?.RagOptionID,
                        CurrentRAG: cu?.RagOptionID,
                        LeadUser: c.LeadUser ? c.LeadUser.Title : lcp.dataMissing,
                        ToBeClosed: cu?.ToBeClosed
                    };
                })
                :
                [{ key: 0, Title: 'No commitments' } as IObjectWithKey]
            }
            progressUpdateFormTitle="Edit commitment progress update"
            progressUpdateForm={(entityId, entityUpdateId, onSaved, onCancelled) =>
                <CommitmentProgressUpdateForm
                    {...other}
                    reportDates={reportDates}
                    entityId={entityId}
                    entity={entities && entities.find(c => c.ID === entityId)}
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
