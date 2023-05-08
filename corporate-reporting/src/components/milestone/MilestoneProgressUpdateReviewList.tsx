import React, { useContext, useEffect, useState } from 'react';
import { IEntityProgressUpdateReviewListProps, IKeyWorkArea, IMilestone, IWorkStream, ListDefaults } from '../../types';
import { ProgressUpdateReviewList } from '../ProgressUpdateReviewList';
import { MilestoneProgressUpdateForm } from './MilestoneProgressUpdateForm';
import { AttributeService } from '../../services';
import { renderDate, renderEditButton, renderPreviousRag, renderProgressUpdate, renderRag } from '../cr/ListRenderers';
import { MilestoneType } from '../../refData/MilestoneType';
import { ReportTypes } from '../../refData/ReportTypes';
import { IObjectWithKey } from 'office-ui-fabric-react';
import { OrbUserContext } from '../OrbUserContext';
import { DataContext } from '../DataContext';

interface IMilestoneProgressUpdateReviewListProps extends IEntityProgressUpdateReviewListProps<IMilestone> {
    reportType: ReportTypes;
}

export const MilestoneProgressUpdateReviewList = (
    { entities, previousEntities, reportDates, readOnly,
        onChange, showPreviousUpdate, listConfig = ListDefaults, reportType, ...other }
        : IMilestoneProgressUpdateReviewListProps
): React.ReactElement => {
    const { userPermissions } = useContext(OrbUserContext);
    const { dataServices } = useContext(DataContext);
    const [parentKeyWorkAreas, setParentKeyWorkAreas] = useState<IKeyWorkArea[]>([]);
    const [parentWorkStreams, setParentWorkStreams] = useState<IWorkStream[]>([]);

    const unique = (v: number, i: number, a: number[]) => a.indexOf(v) === i;

    useEffect(() => {
        const loadParents = async () => {
            setParentKeyWorkAreas(await Promise.all(entities
                .filter(m => m.KeyWorkAreaID)
                .map(m => m.KeyWorkAreaID)
                .filter(unique)
                .map(kwaId => dataServices.keyWorkAreaService.read(kwaId))
            ));
            setParentWorkStreams(await Promise.all(entities
                .filter(m => m.WorkStreamID)
                .map(m => m.WorkStreamID)
                .filter(unique)
                .map(wsId => dataServices.workStreamService.read(wsId))
            ));
        };

        loadParents();
    }, [entities, dataServices.keyWorkAreaService, dataServices.workStreamService]);

    const hideEdit = !!(readOnly);
    const lcc = listConfig.columnWidths;
    const lcp = listConfig.placeholders;
    return (
        <>
            <ProgressUpdateReviewList
                listTitle="Milestone updates"
                listColumns={onEdit => [
                    {
                        key: '0', name: '', fieldName: 'key', minWidth: hideEdit ? 1 : lcc.editIcon, maxWidth: lcc.editIcon,
                        onRender: m => renderEditButton(onEdit, m.key, m.EntityUpdateID, !hideEdit && m.isEditable)
                    },
                    { key: '1', name: 'ID', fieldName: 'MilestoneCode', minWidth: 50, maxWidth: 75, isResizable: true, isMultiline: true },
                    {
                        key: '2', name: 'Progress update', fieldName: 'Title', minWidth: 200, isResizable: true, isMultiline: true, onRender: m => renderProgressUpdate({
                            title: m.Title,
                            comment: m.Comment,
                            author: m.UpdateAuthor,
                            date: m.UpdateDate,
                            toBeClosed: m.ToBeClosed,
                            attributes: m.Attributes,
                            previousComment: showPreviousUpdate && m.PreviousComment
                        })
                    },
                    reportType === ReportTypes.Directorate && { key: '12', name: 'Key work area', fieldName: 'ParentEntity', minWidth: 100, isResizable: true, isMultiline: true },
                    reportType === ReportTypes.Project && { key: '13', name: 'Work stream', fieldName: 'ParentEntity', minWidth: 100, isResizable: true, isMultiline: true },
                    { key: '11', name: 'Start date', fieldName: 'StartDateValue', minWidth: lcc.date, isResizable: true, onRender: m => renderDate(m.StartDate, m.key !== 0 && lcp.dataMissing) },
                    { key: '5', name: 'Baseline', fieldName: 'BaselineDateValue', minWidth: lcc.date, isResizable: true, onRender: m => renderDate(m.BaselineDate, m.key !== 0 && lcp.dataMissing) },
                    { key: '6', name: 'Forecast', fieldName: 'ForecastDateValue', minWidth: lcc.date, isResizable: true, onRender: m => renderDate(m.ForecastDate) },
                    { key: '7', name: 'Actual', fieldName: 'ActualDateValue', minWidth: lcc.date, isResizable: true, onRender: m => renderDate(m.ActualDate) },
                    { key: '8', name: 'Previous', fieldName: 'PreviousRAG', minWidth: lcc.rag, isResizable: true, onRender: m => m.key !== 0 && renderPreviousRag(m.PreviousRAG) },
                    { key: '9', name: 'Current', fieldName: 'CurrentRAG', minWidth: lcc.rag, isResizable: true, onRender: m => m.key !== 0 && renderRag(m.CurrentRAG) },
                    { key: '10', name: 'Lead', fieldName: 'LeadUser', minWidth: lcc.user, isResizable: true, isMultiline: true }
                ].filter(m => m)}
                listItems={entities?.length > 0 ?
                    entities.map(m => {
                        const mu = m.MilestoneUpdates?.[0];
                        const pmu = previousEntities?.find(p => p?.ID === m.ID)?.MilestoneUpdates?.[0];
                        return {
                            key: m.ID,
                            isEditable: userPermissions.UserCanSubmitMilestoneUpdates({
                                milestone: m,
                                keyWorkArea: parentKeyWorkAreas.find(kwa => kwa.ID === m.KeyWorkAreaID),
                                workStream: parentWorkStreams.find(ws => ws.ID === m.WorkStreamID)
                            }),
                            EntityUpdateID: mu?.ID,
                            Attributes: AttributeService.attributesToBadgeStrings(m.Attributes),
                            MilestoneCode: m.MilestoneCode,
                            Title: m.Title,
                            ParentEntity: m.MilestoneTypeID === MilestoneType.Directorate ? m.KeyWorkArea?.Title : m.MilestoneTypeID === MilestoneType.Project ? m.WorkStream?.Title : '',
                            PreviousComment: pmu ? pmu.Comment : lcp.dataMissing,
                            Comment: mu ? mu.Comment : lcp.dataTBC,
                            UpdateAuthor: mu?.UpdateUser?.Title,
                            UpdateDate: mu?.UpdateDate,
                            BaselineDate: m.BaselineDate,
                            BaselineDateValue: m.BaselineDate?.valueOf(),
                            ForecastDate: mu?.ForecastDate,
                            ForecastDateValue: mu?.ForecastDate?.valueOf(),
                            ActualDate: mu?.ActualDate,
                            ActualDateValue: mu?.ActualDate?.valueOf(),
                            PreviousRAG: pmu?.RagOptionID,
                            CurrentRAG: mu?.RagOptionID,
                            LeadUser: m.LeadUser ? m.LeadUser.Title : lcp.dataMissing,
                            ToBeClosed: mu?.ToBeClosed,
                            StartDate: m.StartDate,
                            StartDateValue: m.StartDate?.valueOf()
                        };
                    }) : [{ key: 0, Title: 'No milestones' } as IObjectWithKey]}
                progressUpdateFormTitle="Edit milestone progress update"
                progressUpdateForm={(entityId, entityUpdateId, onSaved, onCancelled) =>
                    <MilestoneProgressUpdateForm
                        {...other}
                        entityId={entityId}
                        entity={entities && entities.find(m => m.ID === entityId)}
                        reportDates={reportDates}
                        entityUpdateId={entityUpdateId}
                        defaultShowForm={true}
                        onSaved={onSaved}
                        onCancelled={onCancelled}
                    />
                }
                onChange={onChange}
            />
        </>
    );
};
