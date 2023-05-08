import React, { useContext, useState } from 'react';
import {
    IPartnerOrganisationUpdate, IReviewListState, PartnerOrganisationUpdate,
    ListDefaults as ld, IReportDueDates, IPartnerOrganisation, IBaseComponentProps
} from '../../types';
import styles from '../../styles/cr.module.scss';
import { RagIndicator } from '../cr/RagIndicator';
import { IconButton } from 'office-ui-fabric-react/lib/Button';
import { Panel, PanelType } from 'office-ui-fabric-react/lib/Panel';
import { CrLastEdit } from '../cr/CrLastEdit';
import { PartnerOrganisationProgressUpdateForm } from './PartnerOrganisationProgressUpdateForm';
import { OrbUserContext } from '../OrbUserContext';

export interface IPartnerOrganisationProgressUpdateReviewProps extends IBaseComponentProps {
    reportDates: IReportDueDates;
    partnerOrganisation: IPartnerOrganisation;
    partnerOrganisationUpdate?: IPartnerOrganisationUpdate;
    readOnly?: boolean;
    onChange?: () => void;
}

export const PartnerOrganisationProgressUpdateReviewList = (props: IPartnerOrganisationProgressUpdateReviewProps): React.ReactElement => {
    const { userPermissions } = useContext(OrbUserContext);
    const partnerOrganisationId = props.partnerOrganisation?.ID;
    const defaultState = { EntityId: null, EntityUpdateId: null, ShowForm: false };
    const [selectedEntity, setSelectedEntity] = useState<IReviewListState>(defaultState);

    const closePanel = () => {
        setSelectedEntity(defaultState);
    };

    const editUpdate = (entityId: number, entityUpdateId: number): void => {
        setSelectedEntity({ EntityId: entityId, EntityUpdateId: entityUpdateId, ShowForm: true });
    };

    const closeEditUpdate = (reloadList: boolean): void => {
        setSelectedEntity(defaultState);
        if (reloadList && props.onChange) {
            props.onChange();
        }
    };

    const pu = props.partnerOrganisationUpdate || new PartnerOrganisationUpdate(props.reportDates?.Next);
    const hideEdit = !!(props.readOnly);

    return (
        <div className={styles.cr}>
            {partnerOrganisationId && !hideEdit
                && userPermissions.UserCanSubmitPartnerOrganisationUpdates(props.partnerOrganisation) &&
                <IconButton iconProps={{ iconName: 'Edit' }} title='Edit' onClick={() => editUpdate(partnerOrganisationId, pu.ID)} />
            }
            <div className={styles.grid}>
                <div className={`${styles.gridRow} ${styles.signOffGridRow}`}>
                    <div className={`${styles.gridCol} ${styles.sm12}`}>
                        <RagIndicator rag={pu.OverallRagOptionID} />
                    </div>
                </div>
                <div className={`${styles.gridRow} ${styles.signOffGridRow}`}>
                    <div className={`${styles.gridCol} ${styles.sm12} ${styles.xl4}`}>
                        <div className={styles.content}>
                            <div className={styles.reviewListTitle}>Delivery confidence</div>
                            <p>{pu.ProgressUpdate || ld.placeholders.dataTBC}</p>
                        </div>
                    </div>
                    <div className={`${styles.gridCol} ${styles.sm12} ${styles.xl4}`}>
                        <div className={styles.content}>
                            <div className={styles.reviewListTitle}>Future actions</div>
                            <p>{pu.FutureActions || ld.placeholders.dataTBC}</p>
                        </div>
                    </div>
                    <div className={`${styles.gridCol} ${styles.sm12} ${styles.xl4}`}>
                        <div className={styles.content}>
                            <div className={styles.reviewListTitle}>Escalations for senior leader action</div>
                            <p>{pu.Escalations || ld.placeholders.dataTBC}</p>
                        </div>
                    </div>
                </div>
                <div className={`${styles.gridRow} ${styles.signOffGridRow}`}>
                    <div className={`${styles.gridCol} ${styles.sm12} ${styles.xl3}`}>
                        <div className={styles.content}>
                            <div className={styles.reviewListTitle}>Finance</div>
                            <RagIndicator rag={pu.FinanceRagOptionID} />
                            <p>{pu.FinanceComment || ld.placeholders.dataTBC}</p>
                        </div>
                    </div>
                    <div className={`${styles.gridCol} ${styles.sm12} ${styles.xl3}`}>
                        <div className={styles.content}>
                            <div className={styles.reviewListTitle}>People</div>
                            <RagIndicator rag={pu.PeopleRagOptionID} />
                            <p>{pu.PeopleComment || ld.placeholders.dataTBC}</p>
                        </div>
                    </div>
                    <div className={`${styles.gridCol} ${styles.sm12} ${styles.xl3}`}>
                        <div className={styles.content}>
                            <div className={styles.reviewListTitle}>Milestones</div>
                            <RagIndicator rag={pu.MilestonesRagOptionID} />
                            <p>{pu.MilestonesComment || ld.placeholders.dataTBC}</p>
                        </div>
                    </div>
                    <div className={`${styles.gridCol} ${styles.sm12} ${styles.xl3}`}>
                        <div className={styles.content}>
                            <div className={styles.reviewListTitle}>Key performance indicators</div>
                            <RagIndicator rag={pu.KPIRagOptionID} />
                            <p>{pu.KPIComment || ld.placeholders.dataTBC}</p>
                        </div>
                    </div>
                </div>
                <div className={styles.gridRow}>
                    <div className={`${styles.gridCol} ${styles.sm12}`}>
                        <CrLastEdit author={pu.UpdateUser && pu.UpdateUser.Title} editDate={pu.UpdateDate} />
                    </div>
                </div>
            </div>
            <Panel isOpen={selectedEntity.ShowForm} headerText="Edit partner organisation update" type={PanelType.medium} onDismiss={closePanel}>
                <PartnerOrganisationProgressUpdateForm
                    {...props}
                    entityId={selectedEntity.EntityId}
                    entityUpdateId={selectedEntity.EntityUpdateId}
                    defaultShowForm={true}
                    onSaved={() => closeEditUpdate(true)}
                    onCancelled={() => closeEditUpdate(false)}
                />
            </Panel>
        </div>
    );
};
