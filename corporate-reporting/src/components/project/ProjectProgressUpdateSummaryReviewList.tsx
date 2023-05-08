import React, { useContext, useEffect, useState } from 'react';
import styles from '../../styles/cr.module.scss';
import { IProject, IReviewListState, IListConfig, ListDefaults, IEntityProgressUpdateReviewListProps } from '../../types';
import { AttributeService, ProjectUpdateService } from '../../services';
import { DetailsList, SelectionMode, IColumn } from 'office-ui-fabric-react/lib/DetailsList';
import { IconButton } from 'office-ui-fabric-react/lib/Button';
import { CrEntityCompleteIcon } from '../cr/CrEntityCompleteIcon';
import { CrLastEdit } from '../cr/CrLastEdit';
import { ProjectProgressUpdateForm } from './ProjectProgressUpdateForm';
import { Panel, PanelType } from 'office-ui-fabric-react/lib/Panel';
import { CrReviewListHistory } from '../cr/CrReviewListHistory';
import { CrBadges } from '../cr/CrBadges';
import { PreviousRagIndicator } from '../cr/PreviousRagIndicator';
import { renderRag } from '../cr/ListRenderers';
import { MessageBar } from 'office-ui-fabric-react';
import { DataContext } from '../DataContext';

export interface IProjectProgressUpdateSummaryReviewListProps extends IEntityProgressUpdateReviewListProps<IProject> {
    showPreviousUpdate?: boolean;
    listConfig?: IListConfig;
    directorateOpenProjectCount?: number;
}

const PreviousProjectRAG = ({ service, projectId, currentPeriod }: { service: ProjectUpdateService, projectId: number, currentPeriod: Date }) => {
    const [rag, setRag] = useState<number>(null);

    useEffect(() => {
        const loadPreviousRag = async () => {
            setRag(await service.readLastSignedOffUpdateRagForPreviousPeriod(projectId, currentPeriod).then(pu => pu?.OverallRagOptionID));
        };

        loadPreviousRag();
    }, [service, projectId, currentPeriod]);

    return <PreviousRagIndicator rag={rag} />;
};

export const ProjectProgressUpdateSummaryReviewList = (props: IProjectProgressUpdateSummaryReviewListProps): React.ReactElement => {
    const { entities, previousEntities, readOnly,
        reportDates, showPreviousUpdate, listConfig = ListDefaults, directorateOpenProjectCount } = props;
    const { dataServices: { projectUpdateService } } = useContext(DataContext);
    const [state, setState] = useState<IReviewListState>({ EntityId: null, EntityUpdateId: null, ShowForm: false });
    const hideEdit = !!(readOnly);
    const lcc = listConfig.columnWidths;
    const lcp = listConfig.placeholders;

    const projectsAndUpdates = entities?.length > 0 ?
        entities.map(p => {
            const pu = p?.ProjectUpdates?.[0];
            const ppu = previousEntities?.find(pu2 => pu2?.ID === p.ID)?.ProjectUpdates?.[0];
            return {
                key: p.ID,
                EntityUpdateID: pu?.ID,
                Attributes: AttributeService.attributesToBadgeStrings(p.Attributes),
                Title: p.Title,
                PreviousProgressUpdate: ppu ? ppu.ProgressUpdate : lcp.dataTBC,
                ProgressUpdate: pu ? pu.ProgressUpdate : lcp.dataTBC,
                FutureActions: pu ? pu.FutureActions : lcp.dataTBC,
                UpdateAuthor: pu?.UpdateUser?.Title,
                UpdateDate: pu?.UpdateDate,
                PreviousRAG: ppu?.OverallRagOptionID,
                CurrentRAG: pu?.OverallRagOptionID,
                ToBeClosed: pu?.ToBeClosed,
                SRO: p.SeniorResponsibleOwnerUser?.Title
            };
        })
        :
        [{ key: 0, Title: 'No projects' }];

    const listColumns: IColumn[] = [
        {
            key: '0', name: '', fieldName: 'key', minWidth: hideEdit ? 1 : lcc.editIcon, maxWidth: lcc.editIcon, onRender: function renderEditButton(p) {
                return !hideEdit && p.key !== 0 &&
                    <IconButton iconProps={{ iconName: 'Edit' }} title='Edit' onClick={() => editUpdate(p.key, p.EntityUpdateID)} />;
            }
        },
        {
            key: '1', name: 'Progress Update', fieldName: 'Title', minWidth: 200, isResizable: true, isMultiline: true, onRender: function renderProgressUpdate(p) {
                return (
                    <div>
                        {p.ToBeClosed && <CrEntityCompleteIcon />}
                        <div className={styles.fontWeightSemibold}>{p.Title} <CrBadges
                            badges={p.Attributes?.map((a: string) =>
                                ({ text: a, description: `Attribute: ${a}`, badgeClass: styles.badgeSecondary })
                            )} />
                        </div>
                        <div>{p.ProgressUpdate}</div>
                        <div>{p.FutureActions}</div>
                        <CrLastEdit author={p.UpdateAuthor} editDate={p.UpdateDate} />
                        {showPreviousUpdate &&
                            <CrReviewListHistory value={`${p.PreviousProgressUpdate}\n${p.PreviousFutureActions}`} />
                        }
                    </div>
                );
            }
        },
        {
            key: '3', name: 'Previous', fieldName: 'PreviousRAG', minWidth: lcc.rag, isResizable: true, onRender: function renderPreviousRag(p) {
                return p.key !== 0 && <PreviousProjectRAG service={projectUpdateService} projectId={p.key} currentPeriod={reportDates?.Next} />; /* eslint-disable-line react/prop-types */  // For some reason this line causes: error  'reportDates.Next' is missing in props validation  react/prop-types
            }
        },
        { key: '4', name: 'Current', fieldName: 'CurrentRAG', minWidth: lcc.rag, isResizable: true, onRender: p => p.key !== 0 && renderRag(p.CurrentRAG) },
        { key: '5', name: 'SRO', fieldName: 'SRO', minWidth: lcc.user, isResizable: true, isMultiline: true }
    ];

    const editUpdate = (entityId: number, entityUpdateId: number): void => {
        setState({ EntityId: entityId, EntityUpdateId: entityUpdateId, ShowForm: true });
    };

    const closeEditUpdate = (reloadList = false): void => {
        setState({ EntityId: null, EntityUpdateId: null, ShowForm: false });
        if (reloadList && props.onChange) {
            props.onChange();
        }
    };

    return (
        <div className={styles.cr}>
            <h3 className={styles.reviewListTitle}>{props.listTitle}</h3>
            <div className={styles.reviewList}>
                <DetailsList
                    selectionMode={SelectionMode.none}
                    columns={listColumns}
                    items={projectsAndUpdates}
                />
            </div>
            {!!directorateOpenProjectCount && directorateOpenProjectCount > entities.length &&
                <MessageBar>There are projects in this directorate for which reports are not due this month.</MessageBar>
            }
            <Panel
                isOpen={state.ShowForm}
                headerText={props.progressUpdateFormTitle}
                type={PanelType.medium}
                onDismiss={() => closeEditUpdate(false)}
            >
                <ProjectProgressUpdateForm
                    {...props}
                    entityId={state.EntityId}
                    entityUpdateId={state.EntityUpdateId}
                    defaultShowForm={true}
                    onSaved={() => closeEditUpdate(true)}
                    onCancelled={() => closeEditUpdate(false)}
                />
            </Panel>
        </div>
    );
};
