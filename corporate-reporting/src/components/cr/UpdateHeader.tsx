import React from 'react';
import { DateService } from '../../services/DateService';
import styles from '../../styles/cr.module.scss';
import { Icon } from 'office-ui-fabric-react/lib/Icon';
import { CrBreadcrumb } from './CrBreadcrumb';
import { RagIndicator } from '../cr/RagIndicator';
import { TooltipHost, TooltipOverflowMode } from 'office-ui-fabric-react/lib/Tooltip';
import { IEntityRole } from '../../types/EntityRole';
import { Text } from 'office-ui-fabric-react/lib/Text';
import { UpdateHeaderTitle } from './UpdateHeaderTitle';
import { RagColours } from '../../refData/RagColours';

export interface IUpdateHeaderProps {
    title: string;
    closedDate?: Date;
    tags?: string[];
    parents?: string[];
    rag: RagColours;
    ragLabel?: string;
    dueDate?: Date | string;
    people?: IEntityRole[];
    onPeopleHover?: () => Promise<void>;
    isOpen?: boolean;
    onClick?: () => void;
}

export const Due = ({ dueDate }: { dueDate: Date | string }): React.ReactElement => {
    const dueDateString = dueDate instanceof Date ? DateService.dateToUkLongDate(dueDate) : dueDate;
    return dueDateString ?
        <span title={`A report for this item is due by: ${dueDateString}`}>Due: {dueDateString}</span>
        : null;
};

export const UpdateHeader = (
    { title, closedDate, tags, parents, rag, ragLabel, dueDate, people, onPeopleHover, isOpen, onClick }: IUpdateHeaderProps
): React.ReactElement => {
    const closed: string = closedDate ? `Closed: ${closedDate instanceof Date ? DateService.dateToUkDate(closedDate) : closedDate}` : null;
    return (
        <div className={`${styles.cr} ${styles.updateHeader}`} onClick={onClick}>
            <Icon iconName={isOpen ? 'ChevronDown' : 'ChevronRight'} className={styles.msIcon} />
            <div className={`${styles.grid} ${styles.updateHeaderContent}`}>
                <div className={`${styles.gridRow} ${styles.rowColumns}`}>
                    <div className={`${styles.gridCol} ${styles.sm7} ${styles.lg6} ${styles.column}`}>
                        <div className={styles.flexWidthFix}>
                            <div className={styles.updateHeaderTitle}>
                                <TooltipHost overflowMode={TooltipOverflowMode.Parent} content={<UpdateHeaderTitle title={title} tags={tags} />}>
                                    <UpdateHeaderTitle title={title} tags={tags} />
                                </TooltipHost>
                            </div>
                            <CrBreadcrumb items={parents} />
                        </div>
                    </div>
                    <div className={`${styles.gridCol} ${styles.hiddenMdDown} ${styles.lg4} ${styles.column} ${styles.columnRightAlign}`}>
                        {closedDate &&
                            <>
                                <div className={styles.updateHeaderMetadata}>
                                    <Icon iconName="Completed" style={{ fontSize: '25px' }} title="Closed" />
                                </div>
                                <div className={`${styles.updateHeaderMetadata} ${styles.subTitle}`}>
                                    <TooltipHost overflowMode={TooltipOverflowMode.Parent} content={closed}>{closed}</TooltipHost>
                                </div>
                            </>
                            || dueDate &&
                            <div className={`${styles.updateHeaderMetadata} ${styles.subTitle}`}>
                                <TooltipHost overflowMode={TooltipOverflowMode.Parent} content={<Due dueDate={dueDate} />}><Due dueDate={dueDate} /></TooltipHost>
                            </div>
                        }
                        <div className={styles.updateHeaderMetadata} onMouseOver={onPeopleHover}>
                            <TooltipHost closeDelay={400} content={people && people.length > 0 &&
                                people.map((p, i) => <Text key={i} block style={{ marginBottom: '9px' }}><strong>{p.role}:</strong> {p.names.join(', ')}</Text>)
                            }>
                                <Icon iconName="People" style={{ fontSize: '25px', color: people && people.length > 0 ? '' : '#bbb' }} />
                            </TooltipHost>
                        </div>
                    </div>
                    <div className={`${styles.gridCol} ${styles.sm5} ${styles.lg2} ${styles.column}`}>
                        <div className={styles.rag}><RagIndicator rag={rag} label={ragLabel} /></div>
                    </div>
                </div>
            </div>
        </div>
    );
};
