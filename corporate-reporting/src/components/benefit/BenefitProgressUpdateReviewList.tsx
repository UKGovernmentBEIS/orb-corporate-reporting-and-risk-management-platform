import React, { useContext } from 'react';
import { IBenefit, IBenefitUpdate, IEntityProgressUpdateReviewListProps, ListDefaults } from '../../types';
import { ProgressUpdateReviewList } from '../ProgressUpdateReviewList';
import { BenefitProgressUpdateForm } from './BenefitProgressUpdateForm';
import { IObjectWithKey } from 'office-ui-fabric-react';
import { NumberService } from '../../services';
import { renderEditButton, renderPreviousRag, renderProgressUpdate, renderRag } from '../cr/ListRenderers';
import { OrbUserContext } from '../OrbUserContext';

interface IBenefitProgressUpdateReviewListProps extends IEntityProgressUpdateReviewListProps<IBenefit> {
    previousBenefitUpdates: IBenefitUpdate[];
}

export const BenefitProgressUpdateReviewList = (props: IBenefitProgressUpdateReviewListProps): React.ReactElement => {
    const { entities, previousBenefitUpdates, reportDates: projectReportDates,
        readOnly, onChange, showPreviousUpdate, listConfig = ListDefaults } = props;
    const { userPermissions } = useContext(OrbUserContext);
    const hideEdit = !!(readOnly);
    const lcc = listConfig.columnWidths;
    const lcp = listConfig.placeholders;

    const columns = (onEdit: (entityId: number, entityUpdateId: number) => void) => [
        {
            key: '0', name: '', fieldName: 'key', minWidth: hideEdit ? 1 : lcc.editIcon, maxWidth: lcc.editIcon,
            onRender: b => renderEditButton(onEdit, b.key, b.EntityUpdateID, !hideEdit && b.isEditable)
        },
        {
            key: '1', name: 'Benefit', fieldName: 'Title', minWidth: 200, isMultiline: true, isResizable: true, onRender: b => renderProgressUpdate({
                title: b.Title,
                comment: b.ProgressUpdate,
                author: b.UpdateAuthor,
                date: b.UpdateDate,
                toBeClosed: b.ToBeClosed,
                attributes: b.Attributes,
                previousComment: showPreviousUpdate && b.PreviousProgressUpdate
            })
        },
        { key: '3', name: 'Type', fieldName: 'BenefitType', minWidth: 100, isResizable: true, isMultiline: true },
        {
            key: '5', name: 'Target', fieldName: 'Target', minWidth: 100, isResizable: true, isMultiline: true, onRender: function renderTarget(b) {
                return <div>{b.Target} {b.Target !== lcp.dataMissing && b.Unit}</div>;
            }
        },
        {
            key: '6', name: 'Current', fieldName: 'Actual', minWidth: 100, isResizable: true, isMultiline: true, onRender: function renderCurrent(b) {
                return <div>{b.Actual} {b.Actual !== lcp.dataTBC && b.Unit}</div>;
            }
        },
        { key: '7', name: 'Previous', fieldName: 'PreviousRAG', minWidth: lcc.rag, isResizable: true, onRender: b => b.key !== 0 && renderPreviousRag(b.PreviousRAG) },
        { key: '8', name: 'Current', fieldName: 'CurrentRAG', minWidth: lcc.rag, isResizable: true, onRender: b => b.key !== 0 && renderRag(b.CurrentRAG) },
        { key: '9', name: 'Lead', fieldName: 'LeadUser', minWidth: lcc.user, isResizable: true, isMultiline: true }
    ];

    const listItems = entities?.map(b => {
        const bu = b.BenefitUpdates?.[0];
        const pbu = previousBenefitUpdates?.find(p => p?.BenefitID === b.ID);
        return {
            key: b.ID,
            isEditable: userPermissions.UserCanSubmitBenefitUpdates(b),
            Attributes: b?.Attributes?.filter(atr => atr?.AttributeType?.Display).map(a => a?.AttributeType?.Title),
            EntityUpdateID: bu?.ID,
            Title: b.Title,
            BenefitType: b.BenefitType?.Title || lcp.dataMissing,
            PreviousProgressUpdate: pbu?.Comment || lcp.dataMissing,
            ProgressUpdate: bu?.Comment || lcp.dataTBC,
            UpdateAuthor: bu?.UpdateUser?.Title,
            UpdateDate: bu?.UpdateDate,
            Target: (b.TargetPerformanceLowerLimit || b.TargetPerformanceLowerLimit == 0) && (b.TargetPerformanceUpperLimit || b.TargetPerformanceUpperLimit == 0)
                ? `${Number(b.TargetPerformanceLowerLimit).toLocaleString('en-GB')} to ${Number(b.TargetPerformanceUpperLimit).toLocaleString('en-GB')}`
                : (b.TargetPerformanceUpperLimit || b.TargetPerformanceUpperLimit == 0)
                    ? `${Number(b.TargetPerformanceUpperLimit).toLocaleString('en-GB')}`
                    : (b.TargetPerformanceLowerLimit || b.TargetPerformanceLowerLimit == 0)
                        ? `${Number(b.TargetPerformanceLowerLimit).toLocaleString('en-GB')}`
                        : lcp.dataMissing,
            Unit: b?.MeasurementUnit?.Title,
            Actual: (!NumberService.IsNullOrUndefined(bu?.CurrentPerformance) && Number(bu.CurrentPerformance).toLocaleString('en-GB')) || lcp.dataTBC,
            PreviousRAG: pbu?.RagOptionID || null,
            CurrentRAG: bu?.RagOptionID || null,
            LeadUser: b.LeadUser?.Title || lcp.dataMissing,
            ToBeClosed: bu?.ToBeClosed
        };
    });

    return (
        <ProgressUpdateReviewList
            listTitle="Benefit progress updates"
            listColumns={onEdit => columns(onEdit)}
            listItems={listItems?.length > 0 ? listItems : [{ key: 0, Title: 'No benefits' } as IObjectWithKey]}
            progressUpdateFormTitle="Edit benefit progress update"
            progressUpdateForm={(entityId, entityUpdateId, onSaved, onCancelled) =>
                <BenefitProgressUpdateForm
                    {...props}
                    entityId={entityId}
                    entity={entities?.find(b => b.ID === entityId)}
                    reportDates={projectReportDates}
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
