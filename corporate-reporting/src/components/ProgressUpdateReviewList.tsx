import React, { useState } from 'react';
import styles from '../styles/cr.module.scss';
import { Panel, PanelType } from 'office-ui-fabric-react/lib/Panel';
import { SelectionMode, IColumn, DetailsRow, IDetailsRowProps, IDetailsHeaderProps, DetailsHeader, IObjectWithKey } from 'office-ui-fabric-react/lib/DetailsList';
import { IReviewListState } from '../types';
import { SortableList } from './cr/SortableList';

export interface IProgressUpdateReviewListProps {
    listTitle: string;
    listColumns: (onEdit: (entityId: number, entityUpdateId: number) => void) => IColumn[];
    listItems: IObjectWithKey[];
    progressUpdateFormTitle: string;
    progressUpdateForm: (entity: number, entityUpdateId: number, onSaved: () => void, onCancelled: () => void) => React.ReactElement;
    onChange: () => void;
    isHeadlineList?: boolean;
}

export const ProgressUpdateReviewList = ({ listTitle, listColumns, listItems, progressUpdateFormTitle, progressUpdateForm, onChange, isHeadlineList }: IProgressUpdateReviewListProps): React.ReactElement => {

    const [selectedEntity, setSelectedEntity] = useState<IReviewListState>({ EntityId: null, EntityUpdateId: null, ShowForm: false });

    const editUpdate = (entityId: number, entityUpdateId: number): void => {
        setSelectedEntity({ EntityId: entityId, EntityUpdateId: entityUpdateId, ShowForm: true });
    };

    const closeEditUpdate = (reloadList = false): void => {
        setSelectedEntity({ EntityId: null, EntityUpdateId: null, ShowForm: false });
        if (reloadList && onChange) {
            onChange();
        }
    };

    const headlineList = isHeadlineList ? { onRenderDetailsHeader: ProgressUpdateReviewListHeader, onRenderRow: ProgressUpdateReviewListRow } : {};

    return (
        <div className={styles.cr}>
            <div>
                <h3 className={styles.reviewListTitle}>{listTitle}</h3>
                <div className={styles.reviewList}>
                    <SortableList
                        {...headlineList}
                        selectionMode={SelectionMode.none}
                        columns={listColumns(editUpdate)}
                        items={listItems}
                    />
                </div>
                <Panel isOpen={selectedEntity.ShowForm} headerText={progressUpdateFormTitle} type={PanelType.medium} onDismiss={() => closeEditUpdate(false)}>
                    {progressUpdateForm(selectedEntity.EntityId, selectedEntity.EntityUpdateId, () => closeEditUpdate(true), () => closeEditUpdate(false))}
                </Panel>
            </div>
        </div>
    );
};

const ProgressUpdateReviewListRow = (props: IDetailsRowProps) =>
    <DetailsRow {...props} className={`${styles.reviewListRow} ${props.className}`} />;

const ProgressUpdateReviewListHeader = (props: IDetailsHeaderProps) =>
    <DetailsHeader {...props} className={`${styles.reviewListRow} ${props.className}`} />;