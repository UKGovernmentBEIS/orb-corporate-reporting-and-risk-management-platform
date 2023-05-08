import React, { useContext, useState } from 'react';
import { IProjectUpdate, ProjectUpdate, IReportDueDates, IProject, IBaseComponentProps } from '../../types';
import styles from '../../styles/cr.module.scss';
import { IconButton } from 'office-ui-fabric-react/lib/Button';
import { Panel, PanelType } from 'office-ui-fabric-react/lib/Panel';
import { CrLastEdit } from '../cr/CrLastEdit';
import { CrCheckbox } from '../cr/CrCheckbox';
import { CrTextField } from '../cr/CrTextField';
import { ProjectProgressUpdateForm } from './ProjectProgressUpdateForm';
import { CrReviewListHistory } from '../cr/CrReviewListHistory';
import { ProjectHeadlineRagAndComments } from './ProjectHeadlineRagAndComments';
import { ProjectCoreInfoRagsAndComments } from './ProjectCoreInfoRagsAndComments';
import { OrbUserContext } from '../OrbUserContext';

export interface IProjectProgressUpdateReviewProps extends IBaseComponentProps {
    project?: IProject;
    projectUpdate?: IProjectUpdate;
    previousProjectUpdate?: IProjectUpdate;
    readOnly?: boolean;
    onChange?: () => void;
    showPreviousUpdate?: boolean;
    reportDates: IReportDueDates;
}

export const ProjectProgressUpdateReviewList = (props: IProjectProgressUpdateReviewProps): React.ReactElement => {
    const { project, projectUpdate, previousProjectUpdate: ppu, readOnly, onChange, showPreviousUpdate } = props;
    const { userPermissions } = useContext(OrbUserContext);
    const projectId = project?.ID;
    const pu = projectUpdate || new ProjectUpdate();
    const hideEdit = !!readOnly;
    const [showForm, setShowForm] = useState(false);

    const closeEditUpdate = (reloadList: boolean): void => {
        setShowForm(false);
        if (reloadList) onChange?.();
    };

    const renderCurrentHeader = () =>
        <div className={`${styles.gridRow} ${styles.signOffGridRow}`}>
            <div className={`${styles.gridCol} ${styles.sm12}`}>
                <span>Current reporting period:</span>
            </div>
        </div>;

    return (
        <div className={styles.cr}>
            {projectId && !hideEdit && userPermissions.UserCanSubmitProjectUpdates(projectId) &&
                <IconButton
                    iconProps={{ iconName: 'Edit' }}
                    title='Edit'
                    onClick={() => setShowForm(true)}
                />
            }
            <div className={styles.grid}>
                {showPreviousUpdate && ppu && renderCurrentHeader()}
                <ProjectHeadlineRagAndComments
                    rag={pu.OverallRagOptionID}
                    progressUpdate={pu.ProgressUpdate}
                    futureActions={pu.FutureActions}
                    escalations={pu.Escalations}
                />
                {showPreviousUpdate && ppu &&
                    <div>
                        <div className={`${styles.gridRow} ${styles.signOffGridRow}`}>
                            <div className={`${styles.gridCol} ${styles.sm12}`}>
                                <CrReviewListHistory />
                            </div>
                        </div>
                        <ProjectHeadlineRagAndComments
                            className={styles.historyFade}
                            rag={ppu.OverallRagOptionID}
                            progressUpdate={ppu.ProgressUpdate}
                            futureActions={ppu.FutureActions}
                            escalations={ppu.Escalations}
                        />
                    </div>
                }
                {showPreviousUpdate && ppu && renderCurrentHeader()}
                <ProjectCoreInfoRagsAndComments
                    finance={{ rag: pu.FinanceRagOptionID, comment: pu.FinanceComment }}
                    people={{ rag: pu.PeopleRagOptionID, comment: pu.PeopleComment }}
                    milestones={{ rag: pu.MilestonesRagOptionID, comment: pu.MilestonesComment }}
                    benefits={{ rag: pu.BenefitsRagOptionID, comment: pu.BenefitsComment }}
                />
                {showPreviousUpdate && ppu &&
                    <div>
                        <div className={`${styles.gridRow} ${styles.signOffGridRow}`}>
                            <div className={`${styles.gridCol} ${styles.sm12}`}>
                                <CrReviewListHistory />
                            </div>
                        </div>
                        <ProjectCoreInfoRagsAndComments
                            className={styles.historyFade}
                            finance={{ rag: ppu.FinanceRagOptionID, comment: ppu.FinanceComment }}
                            people={{ rag: ppu.PeopleRagOptionID, comment: ppu.PeopleComment }}
                            milestones={{ rag: ppu.MilestonesRagOptionID, comment: ppu.MilestonesComment }}
                            benefits={{ rag: ppu.BenefitsRagOptionID, comment: ppu.BenefitsComment }}
                        />
                    </div>
                }
                <div className={`${styles.gridRow}`}>
                    <div className={`${styles.gridCol} ${styles.sm12}`}>
                        <CrCheckbox className={styles.formField}
                            label="Mark for closure"
                            checked={pu.ToBeClosed}
                            disabled
                        />
                        {pu.ToBeClosed &&
                            <CrTextField className={styles.formField}
                                label="Why has it been closed?"
                                required={true} multiline
                                value={pu.Comment}
                                maxLength={500}
                                placeholder='Please provide details of why the project is being closed.'
                                disabled
                            />
                        }
                    </div>
                </div>
                <div className={`${styles.gridRow}`}>
                    <div className={`${styles.gridCol} ${styles.sm12}`}>
                        <CrLastEdit author={pu.UpdateUser && pu.UpdateUser.Title} editDate={pu.UpdateDate} />
                    </div>
                </div>
            </div>
            <Panel isOpen={showForm} headerText="Edit project update" type={PanelType.medium} onDismiss={() => setShowForm(false)}>
                <ProjectProgressUpdateForm
                    {...props}
                    entityId={projectId}
                    entityUpdateId={pu?.ID}
                    defaultShowForm={true}
                    onSaved={() => closeEditUpdate(true)}
                    onCancelled={() => closeEditUpdate(false)}
                />
            </Panel>
        </div>
    );
};
