import React, { useContext, useEffect, useState } from 'react';
import {
    IPartnerOrganisationRiskMitigationAction, IEntityProgressUpdateReviewListProps, ListDefaults, IPartnerOrganisationRisk
} from '../../types';
import { RagIndicator } from '../cr/RagIndicator';
import { IconButton } from 'office-ui-fabric-react/lib/Button';
import { ProgressUpdateReviewList } from '../ProgressUpdateReviewList';
import { PartnerOrganisationRiskMitigationActionProgressUpdateForm } from './PartnerOrganisationRiskMitigationActionProgressUpdateForm';
import { ReviewListProgressUpdate } from '../cr/ReviewListProgressUpdate';
import { IObjectWithKey } from 'office-ui-fabric-react';
import { OrbUserContext } from '../OrbUserContext';
import { DataContext } from '../DataContext';
import { EntityStatus } from '../../refData/EntityStatus';

export const PartnerOrganisationRiskMitigationActionProgressUpdateReviewList = (
    { entities, readOnly, onChange, listConfig = ListDefaults, ...other }
        : IEntityProgressUpdateReviewListProps<IPartnerOrganisationRiskMitigationAction>
): React.ReactElement => {
    const { userPermissions } = useContext(OrbUserContext);
    const { dataServices } = useContext(DataContext);
    const [parentRisks, setParentRisks] = useState<IPartnerOrganisationRisk[]>([]);

    useEffect(() => {
        const loadParents = async () => {
            setParentRisks(await Promise.all(entities
                .map(a => a.PartnerOrganisationRiskID)
                .filter((v, i, a) => a.indexOf(v) === i)
                .map(riskId => dataServices.partnerOrganisationRiskService.read(riskId))
            ));
        };

        loadParents();
    }, [entities, dataServices.partnerOrganisationRiskService]);

    const hideEdit = !!(readOnly);
    const lcc = listConfig.columnWidths;
    const lcp = listConfig.placeholders;

    const items = entities
        .map(r => {
            const ru = r.PartnerOrganisationRiskMitigationActionUpdates?.[0];
            return {
                key: r.ID,
                isEditable: userPermissions.UserCanSubmitPartnerOrganisationRiskMitigationActionUpdates(r, parentRisks.find(risk => risk.ID === r.PartnerOrganisationRiskID)),
                EntityUpdateID: ru?.ID,
                Title: r.Title,
                Comment: ru ? ru.Comment : lcp.dataTBC,
                OwnerUser: r.OwnerUser ? r.OwnerUser.Title : lcp.dataMissing,
                ToBeClosed: ru?.ToBeClosed,
                RAG: ru?.RagOptionID,
                UpdateAuthor: ru?.UpdateUser.Title,
                UpdateDate: ru?.UpdateDate,
                AlreadyClosed: r.EntityStatusID === EntityStatus.Closed,
                hasUpdates: !!ru
            };
        })
        .sort((x, y) => x.ToBeClosed === y.ToBeClosed ? 0 : x.ToBeClosed ? 1 : -1)
        .filter(rma => rma.hasUpdates || !rma.AlreadyClosed);

    return (
        <ProgressUpdateReviewList
            listTitle="Partner organisation risk mitigation action updates"
            listColumns={onEdit =>
                [
                    {
                        key: '0', name: '', fieldName: 'key', minWidth: hideEdit ? 1 : lcc.editIcon, maxWidth: lcc.editIcon, onRender: function renderEditButton(r) {
                            return !hideEdit && r.isEditable && r.key !== 0 && (
                                <IconButton iconProps={{ iconName: 'Edit' }} title='Edit' onClick={() => onEdit(r.key, r.EntityUpdateID)} />
                            );
                        }
                    },
                    {
                        key: '1', name: 'Action', fieldName: 'Title', minWidth: 150, isResizable: true, isMultiline: true, onRender: function renderProgressUpdate(r) {
                            return (
                                <ReviewListProgressUpdate
                                    entityName={r.Title}
                                    progressUpdate={r.Comment}
                                    updateAuthor={r.UpdateAuthor}
                                    updateDate={r.UpdateDate}
                                    toBeClosed={r.ToBeClosed}
                                />
                            );
                        }
                    },
                    {
                        key: '2', name: 'RAG rating', fieldName: 'RAG', minWidth: lcc.rag, maxWidth: lcc.rag, isResizable: true, onRender: function renderRag(r) {
                            return r.key !== 0 && (
                                <RagIndicator rag={r.RAG} />
                            );
                        }
                    },
                    { key: '4', name: 'Owner', fieldName: 'OwnerUser', minWidth: lcc.user, isResizable: true, isMultiline: true }
                ]}
            listItems={items?.length > 0 ? items : [{ key: 0, Title: 'No actions' } as IObjectWithKey]}
            progressUpdateFormTitle="Edit partner organisation risk mitigation action progress update"
            progressUpdateForm={(entityId, entityUpdateId, onSaved, onCancelled) =>
                <PartnerOrganisationRiskMitigationActionProgressUpdateForm
                    {...other}
                    entityId={entityId}
                    entity={entities && entities.find(a => a.ID === entityId)}
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
