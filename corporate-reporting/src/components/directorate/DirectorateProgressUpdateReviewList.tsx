import React, { useContext, useState } from 'react';
import {
    IDirectorateUpdate, DirectorateUpdate, ListDefaults as ld,
    IReportDueDates, IDirectorate, IBaseComponentProps
} from '../../types';
import styles from '../../styles/cr.module.scss';
import { RagIndicator } from '../cr/RagIndicator';
import { IconButton } from 'office-ui-fabric-react/lib/Button';
import { Panel, PanelType } from 'office-ui-fabric-react/lib/Panel';
import { CrLastEdit } from '../cr/CrLastEdit';
import { DirectorateProgressUpdateForm } from './DirectorateProgressUpdateForm';
import { OrbUserContext } from '../OrbUserContext';

export interface IDirectorateProgressUpdateReviewProps extends IBaseComponentProps {
    directorate?: IDirectorate;
    directorateUpdate?: IDirectorateUpdate;
    readOnly?: boolean;
    onChange?: () => void;
    reportDates: IReportDueDates;
}

export const DirectorateProgressUpdateReviewList = (props: IDirectorateProgressUpdateReviewProps): React.ReactElement => {
    const { userPermissions } = useContext(OrbUserContext);
    const directorateId = props.directorate?.ID;
    const du = props.directorateUpdate || new DirectorateUpdate();
    const hideEdit = !!(props.readOnly);

    const [showForm, setShowForm] = useState(false);

    const closeEditUpdate = (reloadList: boolean): void => {
        setShowForm(false);
        if (reloadList) props.onChange?.();
    };

    return (
        <div className={styles.cr}>
            {directorateId && !hideEdit && userPermissions.UserCanSubmitDirectorateUpdates(directorateId) &&
                <IconButton iconProps={{ iconName: 'Edit' }} title='Edit' onClick={() => setShowForm(true)} />
            }
            <div className={styles.grid}>
                <div className={`${styles.gridRow} ${styles.signOffGridRow}`}>
                    <div className={`${styles.gridCol} ${styles.sm12}`}>
                        <RagIndicator rag={du.OverallRagOptionID} />
                    </div>
                </div>
                <div className={`${styles.gridRow} ${styles.signOffGridRow}`}>
                    <div className={`${styles.gridCol} ${styles.sm12} ${styles.xl4}`}>
                        <div className={styles.content}>
                            <div className={styles.reviewListTitle}>Delivery confidence</div>
                            <p>{du.ProgressUpdate || ld.placeholders.dataTBC}</p>
                        </div>
                    </div>
                    <div className={`${styles.gridCol} ${styles.sm12} ${styles.xl4}`}>
                        <div className={styles.content}>
                            <div className={styles.reviewListTitle}>Future actions</div>
                            <p>{du.FutureActions || ld.placeholders.dataTBC}</p>
                        </div>
                    </div>
                    <div className={`${styles.gridCol} ${styles.sm12} ${styles.xl4}`}>
                        <div className={styles.content}>
                            <div className={styles.reviewListTitle}>Escalations for senior leader action</div>
                            <p>{du.Escalations || ld.placeholders.dataTBC}</p>
                        </div>
                    </div>
                </div>
                <div className={`${styles.gridRow} ${styles.signOffGridRow}`}>
                    <div className={`${styles.gridCol} ${styles.sm12} ${styles.xl3}`}>
                        <div className={styles.content}>
                            <div className={styles.reviewListTitle}>Finance</div>
                            <RagIndicator rag={du.FinanceRagOptionID} />
                            <p>{du.FinanceComment || ld.placeholders.dataTBC}</p>
                        </div>
                    </div>
                    <div className={`${styles.gridCol} ${styles.sm12} ${styles.xl3}`}>
                        <div className={styles.content}>
                            <div className={styles.reviewListTitle}>People</div>
                            <RagIndicator rag={du.PeopleRagOptionID} />
                            <p>{du.PeopleComment || ld.placeholders.dataTBC}</p>
                        </div>
                    </div>
                    <div className={`${styles.gridCol} ${styles.sm12} ${styles.xl3}`}>
                        <div className={styles.content}>
                            <div className={styles.reviewListTitle}>Milestones</div>
                            <RagIndicator rag={du.MilestonesRagOptionID} />
                            <p>{du.MilestonesComment || ld.placeholders.dataTBC}</p>
                        </div>
                    </div>
                    <div className={`${styles.gridCol} ${styles.sm12} ${styles.xl3}`}>
                        <div className={styles.content}>
                            <div className={styles.reviewListTitle}>Metrics</div>
                            <RagIndicator rag={du.MetricsRagOptionID} />
                            <p>{du.MetricsComment || ld.placeholders.dataTBC}</p>
                        </div>
                    </div>
                </div>
                <div className={styles.gridRow}>
                    <div className={`${styles.gridCol} ${styles.sm12}`}>
                        <CrLastEdit author={du.UpdateUser?.Title} editDate={du.UpdateDate} />
                    </div>
                </div>
            </div>
            <Panel isOpen={showForm} headerText="Edit directorate update" type={PanelType.medium} onDismiss={() => setShowForm(false)}>
                <DirectorateProgressUpdateForm
                    {...props}
                    entityId={directorateId}
                    entityUpdateId={du?.ID}
                    defaultShowForm={true}
                    onSaved={() => closeEditUpdate(true)}
                    onCancelled={() => closeEditUpdate(false)}
                />
            </Panel>
        </div>
    );
};
