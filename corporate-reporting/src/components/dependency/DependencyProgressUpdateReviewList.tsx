import React, { useContext } from 'react';
import { IDependency, IEntityProgressUpdateReviewListProps, ListDefaults } from '../../types';
import { ProgressUpdateReviewList } from '../ProgressUpdateReviewList';
import { DependencyProgressUpdateForm } from './DependencyProgressUpdateForm';
import { IObjectWithKey } from '@uifabric/utilities';
import { renderDate, renderEditButton, renderPreviousRag, renderProgressUpdate, renderRag } from '../cr/ListRenderers';
import { AttributeService } from '../../services';
import { OrbUserContext } from '../OrbUserContext';

export const DependencyProgressUpdateReviewList = (
    { entities, previousEntities, reportDates, readOnly, onChange, showPreviousUpdate, listConfig = ListDefaults, ...other }
        : IEntityProgressUpdateReviewListProps<IDependency>
): React.ReactElement => {
    const { userPermissions } = useContext(OrbUserContext);
    const hideEdit = !!(readOnly);
    const lcc = listConfig.columnWidths;
    const lcp = listConfig.placeholders;
    return (
        <ProgressUpdateReviewList
            listTitle="Dependency progress updates"
            listColumns={onEdit => [
                {
                    key: '0', name: '', fieldName: 'key', minWidth: hideEdit ? 1 : lcc.editIcon, maxWidth: lcc.editIcon,
                    onRender: d => renderEditButton(onEdit, d.key, d.EntityUpdateID, !hideEdit && d.isEditable)
                },
                {
                    key: '1', name: 'Dependency', fieldName: 'Title', minWidth: 200, isResizable: true, isMultiline: true, onRender: d => renderProgressUpdate({
                        title: d.Title,
                        comment: d.ProgressUpdate,
                        author: d.UpdateAuthor,
                        date: d.UpdateDate,
                        toBeClosed: d.ToBeClosed,
                        attributes: d.Attributes,
                        previousComment: showPreviousUpdate && d.PreviousProgressUpdate
                    })
                },
                { key: '2', name: 'Name of third party', fieldName: 'ThirdParty', minWidth: 150, isResizable: true, isMultiline: true },
                { key: '3', name: 'Start date', fieldName: 'StartDateValue', minWidth: lcc.date, isResizable: true, onRender: d => renderDate(d.StartDate, d.key !== 0 && lcp.dataMissing) },
                { key: '7', name: 'Baseline', fieldName: 'BaselineDateValue', minWidth: lcc.date, isResizable: true, onRender: d => renderDate(d.BaselineDate) },
                { key: '8', name: 'Forecast', fieldName: 'ForecastDateValue', minWidth: lcc.date, isResizable: true, onRender: d => renderDate(d.ForecastDate) },
                { key: '9', name: 'Actual', fieldName: 'ActualDateValue', minWidth: lcc.date, isResizable: true, onRender: d => renderDate(d.ActualDate) },
                { key: '4', name: 'Previous', fieldName: 'PreviousRAG', minWidth: lcc.rag, isResizable: true, onRender: d => d.key !== 0 && renderPreviousRag(d.PreviousRAG) },
                { key: '5', name: 'Current', fieldName: 'CurrentRAG', minWidth: lcc.rag, isResizable: true, onRender: d => d.key !== 0 && renderRag(d.CurrentRAG) },
                { key: '6', name: 'Lead', fieldName: 'LeadUser', minWidth: lcc.user, isResizable: true, isMultiline: true }
            ]}
            listItems={entities?.length > 0 ? entities.map(d => {
                const du = d.DependencyUpdates?.[0];
                const pdu = previousEntities?.find(p => p?.ID === d.ID)?.DependencyUpdates?.[0];
                return {
                    key: d.ID,
                    isEditable: userPermissions.UserCanSubmitDependencyUpdates(d),
                    EntityUpdateID: du?.ID,
                    Attributes: AttributeService.attributesToBadgeStrings(d.Attributes),
                    ThirdParty: d.ThirdParty,
                    Title: d.Title,
                    PreviousProgressUpdate: pdu ? pdu.Comment : lcp.dataMissing,
                    ProgressUpdate: du ? du.Comment : lcp.dataTBC,
                    UpdateAuthor: du?.UpdateUser?.Title,
                    UpdateDate: du?.UpdateDate,
                    StartDate: d.StartDate,
                    StartDateValue: d.StartDate?.valueOf(),
                    BaselineDate: d.BaselineDate,
                    BaselineDateValue: d.BaselineDate?.valueOf(),
                    ForecastDate: du?.ForecastDate,
                    ForecastDateValue: du?.ForecastDate?.valueOf(),
                    ActualDate: du?.ActualDate,
                    ActualDateValue: du?.ActualDate?.valueOf(),
                    PreviousRAG: pdu?.RagOptionID,
                    CurrentRAG: du?.RagOptionID,
                    LeadUser: d.LeadUser ? d.LeadUser.Title : lcp.dataMissing,
                    ToBeClosed: du?.ToBeClosed
                };
            }) : [{ key: 0, Title: 'No dependencies' } as IObjectWithKey]}
            progressUpdateFormTitle="Edit dependency progress update"
            progressUpdateForm={(entityId, entityUpdateId, onSaved, onCancelled) =>
                <DependencyProgressUpdateForm
                    {...other}
                    entityId={entityId}
                    entity={entities?.find(d => d.ID === entityId)}
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
