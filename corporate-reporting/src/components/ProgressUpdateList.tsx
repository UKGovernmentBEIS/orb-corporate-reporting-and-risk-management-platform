import React from 'react';
import { IEntity, IReportDueDates } from '../types';
import styles from '../styles/cr.module.scss';
import { ProgressUpdateListHeader } from './cr/ProgressUpdateListHeader';

export interface IProgressUpdateListProps<T extends IEntity> {
    onError?: (userMessage: string, details?: string) => void;
    onLoading?: (isLoading: boolean) => void;
    listTitle?: string;
    expandContent?: boolean;
    onExpandContent?: (expand: boolean) => void;
    entityName?: string;
    reportDates: IReportDueDates;
    showListIfEmpty?: boolean;
    entities: T[];
    renderProgressUpdateForm: (entity: T, showForm?: boolean) => React.ReactElement;
    filters?: { text: string, dueBy: Date };
}

export const ProgressUpdateList = <T extends IEntity>(
    { entities, showListIfEmpty, listTitle, filters, expandContent, renderProgressUpdateForm }: IProgressUpdateListProps<T>
): React.ReactElement => {
    return (
        <div className={`${styles.cr} ${listTitle ? styles.crList : ''}`}>
            {(showListIfEmpty || (entities && entities.length > 0)) &&
                <div className={styles.progressUpdateList} style={{ position: 'relative' }}>
                    {listTitle &&
                        <ProgressUpdateListHeader title={listTitle} />
                    }
                    <div className={styles.updateList}>
                        {expandContent && entities.map(e =>
                            renderProgressUpdateForm(e, entities.length === 1)
                        )}
                        {expandContent && entities.length === 0 &&
                            <div>No updates are due</div>
                        }
                        {expandContent && (filters?.text || filters?.dueBy) &&
                            <div className={styles.hide}>No updates match the filters</div>
                        }
                    </div>
                </div>
            }
        </div>
    );
};
