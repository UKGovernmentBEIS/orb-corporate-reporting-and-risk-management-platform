import React from 'react';
import { ICustomReportingEntity, ICustomReportingEntityType, IEntityProgressUpdateReviewListProps, ListDefaults } from '../../types';
import { ProgressUpdateReviewList } from '../ProgressUpdateReviewList';
import { ReportingEntityProgressUpdateForm } from './ReportingEntityProgressUpdateForm';
import { IObjectWithKey } from 'office-ui-fabric-react';
import { renderEditButton, renderPreviousRag, renderProgressUpdate, renderRag } from '../cr/ListRenderers';
import { DateService } from '../../services';

export interface IReportingEntityProgressUpdateReviewListProps extends IEntityProgressUpdateReviewListProps<ICustomReportingEntity> {
    entityType: ICustomReportingEntityType;
}

export const ReportingEntityProgressUpdateReviewList = (props: IReportingEntityProgressUpdateReviewListProps): React.ReactElement => {
    const { entities, previousEntities, reportDates, readOnly, onChange, listConfig = ListDefaults, entityType, ...other } = props;
    const hideEdit = !!(readOnly);
    const lcc = listConfig.columnWidths;
    const lcp = listConfig.placeholders;
    return (
        <ProgressUpdateReviewList
            listTitle={`${entityType.Title} progress updates`}
            listColumns={onEdit => [
                {
                    key: '0', name: '', fieldName: 'key', minWidth: hideEdit ? 1 : lcc.editIcon, maxWidth: lcc.editIcon,
                    onRender: re => renderEditButton(onEdit, re.key, re.EntityUpdateID, !hideEdit && re.isEditable)
                },
                {
                    key: '1', name: 'Progress update', fieldName: 'Title', minWidth: 200, isResizable: true, isMultiline: true, onRender: re => renderProgressUpdate({
                        title: re.Title,
                        comment: re.ProgressUpdate,
                        author: re.UpdateAuthor,
                        date: re.UpdateDate,
                        toBeClosed: re.ToBeClosed,
                        attributes: re.Attributes
                    })
                },
                entityType.UpdateHasDeliveryDates && {
                    key: '3', name: 'Delivery dates', fieldName: 'ForecastDateValue', minWidth: 200, isResizable: true, onRender: function renderDeliveryDates(re) {
                        return re.key !== 0 && (
                            <>
                                <div>Baseline: {re.BaselineDate ? DateService.dateToUkDate(re.BaselineDate) : lcp.dataMissing}</div>
                                {re.ForecastDate && <div>Forecast:  {DateService.dateToUkDate(re.ForecastDate)}</div>}
                                {re.ActualDate && <div>Actual: {DateService.dateToUkDate(re.ActualDate)}</div>}
                            </>
                        );
                    }
                },
                entityType.HasUpperAndLowerTargets && {
                    key: '6', name: 'Target performance', fieldName: 'Target', minWidth: 200, isResizable: true, isMultiline: true, onRender: function renderTarget(m) {
                        return <div>{m.Target} {m.Target != lcp.dataMissing && m.Unit}</div>;
                    }
                },
                entityType.UpdateHasMeasurement && {
                    key: '7', name: 'Current performance', fieldName: 'Actual', minWidth: 200, isResizable: true, isMultiline: true, onRender: function renderCurrent(m) {
                        return <div>{m.Actual} {(m.Actual != lcp.dataTBC && m.Unit) ? m.Unit : ''}</div>;
                    }
                },
                entityType.UpdateHasRag ? { key: '8', name: 'Previous', fieldName: 'PreviousRAG', minWidth: lcc.rag, isResizable: true, onRender: re => re.key !== 0 && renderPreviousRag(re.PreviousRAG) } : null,
                entityType.UpdateHasRag ? { key: '9', name: 'Current', fieldName: 'CurrentRAG', minWidth: lcc.rag, isResizable: true, onRender: re => re.key !== 0 && renderRag(re.CurrentRAG) } : null,
                { key: '10', name: 'Lead', fieldName: 'LeadUser', minWidth: lcc.user, isResizable: true, isMultiline: true }
            ].filter(c => c)}
            listItems={entities?.length > 0 ?
                entities.map(re => {
                    const reu = re.ReportingEntityUpdates?.[0];
                    const preu = previousEntities?.find(p => p?.ID === re.ID)?.ReportingEntityUpdates?.[0];
                    return {
                        key: re.ID,
                        isEditable: true,
                        EntityUpdateID: reu?.ID,
                        Attributes: re.Attributes?.filter(atr => atr?.AttributeType?.Display).map(a => a.AttributeType.Title),
                        Title: re.Title,
                        ProgressUpdate: reu?.Comment,
                        UpdateAuthor: reu?.UpdateUser?.Title,
                        UpdateDate: reu?.UpdateDate,
                        Target: (re.TargetPerformanceLowerLimit || re.TargetPerformanceLowerLimit == 0)
                            && (re.TargetPerformanceUpperLimit || re.TargetPerformanceUpperLimit == 0)
                            ? `${Number(re.TargetPerformanceLowerLimit).toLocaleString('en-GB')} to ${Number(re.TargetPerformanceUpperLimit).toLocaleString('en-GB')}`
                            : (re.TargetPerformanceUpperLimit || re.TargetPerformanceUpperLimit == 0)
                                ? `${Number(re.TargetPerformanceUpperLimit).toLocaleString('en-GB')}`
                                : (re.TargetPerformanceLowerLimit || re.TargetPerformanceLowerLimit == 0)
                                    ? `${Number(re.TargetPerformanceLowerLimit).toLocaleString('en-GB')}`
                                    : lcp.dataMissing,
                        Unit: re.MeasurementUnit?.Title,
                        Actual: reu ? reu.CurrentPerformance && Number(reu.CurrentPerformance).toLocaleString('en-GB') : lcp.dataTBC,
                        BaselineDate: re.BaselineDate,
                        BaselineDateValue: re.BaselineDate?.valueOf(),
                        ForecastDate: reu?.ForecastDate,
                        ForecastDateValue: reu?.ForecastDate?.valueOf(),
                        ActualDate: reu?.ActualDate,
                        ActualDateValue: reu?.ActualDate?.valueOf(),
                        PreviousRAG: preu?.RagOptionID,
                        CurrentRAG: reu?.RagOptionID,
                        LeadUser: re.LeadUser?.Title || lcp.dataMissing,
                        ToBeClosed: reu?.ToBeClosed
                    };
                })
                :
                [{ key: 0, Title: `No ${entityType.Title}` } as IObjectWithKey]
            }
            progressUpdateFormTitle={`Edit ${entityType.Title} progress update`}
            progressUpdateForm={(entityId, entityUpdateId, onSaved, onCancelled) =>
                <ReportingEntityProgressUpdateForm
                    {...other}
                    reportDates={reportDates}
                    entityId={entityId}
                    entity={entities?.find(re => re.ID === entityId)}
                    entityUpdateId={entityUpdateId}
                    defaultShowForm={true}
                    onSaved={onSaved}
                    onCancelled={onCancelled}
                    entityType={entityType}
                />
            }
            onChange={onChange}
            isHeadlineList={entityType.IsHeadlineSection}
        />
    );
};
