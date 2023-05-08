import React, { useContext } from 'react';
import { IEntityProgressUpdateReviewListProps, IMetric, IMetricUpdate, ListDefaults } from '../../types';
import { ProgressUpdateReviewList } from '../ProgressUpdateReviewList';
import { MetricProgressUpdateForm } from './MetricProgressUpdateForm';
import { AttributeService, NumberService } from '../../services';
import { MessageBar } from 'office-ui-fabric-react';
import { renderEditButton, renderPreviousRag, renderProgressUpdate, renderRag } from '../cr/ListRenderers';
import { OrbUserContext } from '../OrbUserContext';

interface IMetricProgressUpdateReviewListProps extends IEntityProgressUpdateReviewListProps<IMetric> {
    directorateOpenMetricCount?: number;
    previousMetricUpdates: IMetricUpdate[];
}

export const MetricProgressUpdateReviewList = (props: IMetricProgressUpdateReviewListProps): React.ReactElement => {
    const { entities, previousMetricUpdates, reportDates: directorateReportDates,
        readOnly, onChange, directorateOpenMetricCount, listConfig = ListDefaults } = props;
    const { userPermissions } = useContext(OrbUserContext);
    const hideEdit = !!(readOnly);
    let metricsAndUpdates = [];
    const lcc = listConfig.columnWidths;
    const lcp = listConfig.placeholders;

    if (entities?.length > 0) {
        metricsAndUpdates = entities.map(m => {
            const mu = m.MetricUpdates?.[0];
            const pmu = previousMetricUpdates?.find(p => p?.MetricID === m.ID);
            return {
                key: m.ID,
                isEditable: userPermissions.UserCanSubmitMetricUpdates(m),
                EntityUpdateID: mu?.ID,
                Attributes: AttributeService.attributesToBadgeStrings(m.Attributes),
                MetricCode: m.MetricCode,
                Title: m.Title,
                Progress: mu?.Comment || lcp.dataTBC,
                UpdateAuthor: mu?.UpdateUser?.Title,
                UpdateDate: mu?.UpdateDate,
                Target: (m.TargetPerformanceLowerLimit || m.TargetPerformanceLowerLimit == 0)
                    && (m.TargetPerformanceUpperLimit || m.TargetPerformanceUpperLimit == 0)
                    ? `${Number(m.TargetPerformanceLowerLimit).toLocaleString('en-GB')} to ${Number(m.TargetPerformanceUpperLimit).toLocaleString('en-GB')}`
                    : (m.TargetPerformanceUpperLimit || m.TargetPerformanceUpperLimit == 0)
                        ? `${Number(m.TargetPerformanceUpperLimit).toLocaleString('en-GB')}`
                        : (m.TargetPerformanceLowerLimit || m.TargetPerformanceLowerLimit == 0)
                            ? `${Number(m.TargetPerformanceLowerLimit).toLocaleString('en-GB')}`
                            : lcp.dataMissing,
                Unit: m.MeasurementUnit?.Title,
                Actual: (!NumberService.IsNullOrUndefined(mu?.CurrentPerformance) && Number(mu.CurrentPerformance).toLocaleString('en-GB')) || lcp.dataTBC,
                PreviousRAG: pmu?.RagOptionID,
                CurrentRAG: mu?.RagOptionID,
                LeadUser: m.LeadUser?.Title || lcp.dataMissing,
                ToBeClosed: mu?.ToBeClosed
            };
        });
    }
    else {
        metricsAndUpdates = [{ key: 0, Title: 'No metrics' }];
    }

    return (
        <>
            <ProgressUpdateReviewList
                listTitle="Metric updates"
                listColumns={onEdit => [
                    {
                        key: '0', name: '', fieldName: 'key', minWidth: hideEdit ? 1 : lcc.editIcon, maxWidth: lcc.editIcon,
                        onRender: m => renderEditButton(onEdit, m.key, m.EntityUpdateID, !hideEdit && m.isEditable)
                    },
                    { key: '1', name: 'ID', fieldName: 'MetricCode', minWidth: 50, maxWidth: 75, isResizable: true, isMultiline: true },
                    {
                        key: '2', name: 'Progress update', fieldName: 'Title', minWidth: 200, isResizable: true, isMultiline: true, onRender: m => renderProgressUpdate({
                            title: m.Title,
                            comment: m.Progress,
                            author: m.UpdateAuthor,
                            date: m.UpdateDate,
                            toBeClosed: m.ToBeClosed,
                            attributes: m.Attributes
                        })
                    },
                    {
                        key: '5', name: 'Target', fieldName: 'Target', minWidth: 100, isResizable: true, isMultiline: true, onRender: function renderTarget(m) {
                            return <div>{m.Target} {m.Target != lcp.dataMissing && m.Unit}</div>;
                        }
                    },
                    {
                        key: '6', name: 'Current', fieldName: 'Actual', minWidth: 100, isResizable: true, isMultiline: true, onRender: function renderCurrent(m) {
                            return <div>{m.Actual} {m.Actual != lcp.dataTBC && m.Unit}</div>;
                        }
                    },
                    { key: '7', name: 'Previous', fieldName: 'PreviousRAG', minWidth: lcc.rag, isResizable: true, onRender: m => m.key !== 0 && renderPreviousRag(m.PreviousRAG) },
                    { key: '8', name: 'Current', fieldName: 'CurrentRAG', minWidth: lcc.rag, isResizable: true, onRender: m => m.key !== 0 && renderRag(m.CurrentRAG) },
                    { key: '9', name: 'Lead', fieldName: 'LeadUser', minWidth: lcc.user, isResizable: true, isMultiline: true }
                ]}
                listItems={metricsAndUpdates}
                progressUpdateFormTitle="Edit metric progress update"
                progressUpdateForm={(entityId, entityUpdateId, onSaved, onCancelled) =>
                    <MetricProgressUpdateForm
                        {...props}
                        reportDates={directorateReportDates}
                        entityId={entityId}
                        entity={entities?.find(m => m.ID === entityId)}
                        entityUpdateId={entityUpdateId}
                        defaultShowForm={true}
                        onSaved={onSaved}
                        onCancelled={onCancelled}
                    />
                }
                onChange={onChange}
            />
            {!!directorateOpenMetricCount && directorateOpenMetricCount > entities.length &&
                <MessageBar>There are metrics for this directorate for which reports are not due this month.</MessageBar>
            }
        </>
    );
};
