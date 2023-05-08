import React from 'react';
import {
    IBaseComponentProps, IDirectorate, IDirectorateUpdate, IKeyWorkArea, IKeyWorkAreaUpdate,
    IProject, IProjectUpdate, IWorkStream, IWorkStreamUpdate
} from '../../types';
import styles from '../../styles/cr.module.scss';
import { DetailsList, SelectionMode } from 'office-ui-fabric-react/lib/DetailsList';
import { RagIndicator } from '../cr/RagIndicator';
import { DataContext } from '../DataContext';

export interface IGroupSummaryListState {
    ReportPeriod: Date;

    Directorates: IDirectorate[];
    DirectorateUpdates: IDirectorateUpdate[];
    KeyWorkAreas: IKeyWorkArea[];
    KeyWorkAreaUpdates: IKeyWorkAreaUpdate[];
    Projects: IProject[];
    ProjectUpdates: IProjectUpdate[];
    WorkStreams: IWorkStream[];
    WorkStreamUpdates: IWorkStreamUpdate[];
}

export class GroupSummaryListState implements IGroupSummaryListState {
    public ReportPeriod = null;
    public Directorates = [];
    public DirectorateUpdates = [];
    public KeyWorkAreas = [];
    public KeyWorkAreaUpdates = [];
    public Projects = [];
    public ProjectUpdates = [];
    public WorkStreams = [];
    public WorkStreamUpdates = [];

    constructor() {
        const now = new Date();
        this.ReportPeriod = new Date(Date.UTC(now.getFullYear(), now.getMonth() + 1, 0, 0, 0, 0));
    }
}

export class GroupSummaryList extends React.Component<IBaseComponentProps, IGroupSummaryListState> {
    static contextType = DataContext;
    context!: React.ContextType<typeof DataContext>;
    
    constructor(props: IBaseComponentProps) {
        super(props);
        this.state = new GroupSummaryListState();
    }

    public render(): React.ReactElement<IBaseComponentProps> {
        const kwaListColumns = [
            { key: '1', name: 'Key Work Area', fieldName: 'Title', minWidth: 200 },
            { key: '2', name: 'Status', fieldName: 'RagOptionID', minWidth: 200, onRender: item => this.getKeyWorkAreaStatus(item) }
        ];
        const wsListColumns = [
            { key: '1', name: 'Work Stream', fieldName: 'Title', minWidth: 200 },
            { key: '2', name: 'Status', fieldName: 'RagOptionID', minWidth: 200, onRender: item => this.getWorkStreamStatus(item) }
        ];
        return (
            <div className={styles.cr}>
                {this.state.Directorates.length === 0 && this.state.Projects.length === 0 &&
                    <div>You are not a Director General</div>
                }
                {this.state.Directorates.map(d =>
                    <div key={d.ID}>
                        <div className={styles.fontSize18}>{d.Title}</div>
                        <div className={styles.grid}>
                            <div className={styles.gridRow}>
                                <p className={`${styles.gridCol} ${styles.sm6} ${styles.fontSize16}`}>Delivery confidence</p>
                                <div className={`${styles.gridCol} ${styles.sm6}`}>
                                    <RagIndicator rag={this.getDirectorateStatus(d.ID)} />
                                </div>
                            </div>
                        </div>
                        <DetailsList
                            selectionMode={SelectionMode.none}
                            columns={kwaListColumns}
                            items={this.state.KeyWorkAreas.filter(k => k.DirectorateID === d.ID)} />
                    </div>
                )}
                {this.state.Projects.map(p =>
                    <div key={p.ID}>
                        <div className={styles.fontSize18}>{p.Title}</div>
                        <div className={styles.grid}>
                            <div className={styles.gridRow}>
                                <p className={`${styles.gridCol} ${styles.sm6} ${styles.fontSize16}`}>Delivery confidence</p>
                                <div className={`${styles.gridCol} ${styles.sm6}`}>
                                    <RagIndicator rag={this.getProjectStatus(p.ID)} />
                                </div>
                            </div>
                        </div>
                        <DetailsList
                            selectionMode={SelectionMode.none}
                            columns={wsListColumns}
                            items={this.state.WorkStreams.filter(w => w.ProjectID === p.ID)} />
                    </div>
                )}
            </div>
        );
    }

    private getDirectorateStatus = (directorateId: number) => {
        const directorateUpdate = this.state.DirectorateUpdates.filter(d => d.DirectorateID === directorateId);
        if (directorateUpdate.length > 0)
            return directorateUpdate[0].OverallRagOptionID;
    }

    private getKeyWorkAreaStatus = (kwa: IKeyWorkArea) => {
        const keyWorkAreaUpdate = this.state.KeyWorkAreaUpdates.filter(k => k.KeyWorkAreaID === kwa.ID);
        if (keyWorkAreaUpdate.length > 0)
            return (<RagIndicator rag={keyWorkAreaUpdate[0].RagOptionID} />);
        else
            return (<div>No signed off update</div>);
    }

    private getProjectStatus(projectId: number) {
        const projectUpdate = this.state.ProjectUpdates.filter(p => p.ProjectID === projectId);
        if (projectUpdate.length > 0)
            return projectUpdate[0].OverallRagOptionID;
    }

    private getWorkStreamStatus(ws: IWorkStream) {
        const workStreamUpdate = this.state.WorkStreamUpdates.filter(w => w.WorkStreamID === ws.ID);
        if (workStreamUpdate.length > 0)
            return (<RagIndicator rag={workStreamUpdate[0].RagOptionID} />);
        else
            return (<div>No signed off update</div>);
    }

    //#region Form initialisation

    public componentDidMount(): void {
        this.loadDirectorates();
        this.loadProjects();
    }

    private loadDirectorates = async (): Promise<void> => {
        try {
            const d = await this.context.dataServices.directorateService.readDgDirectorates();
            this.setState({ Directorates: d });
            d.forEach(async directorate => {
                const du = await this.context.dataServices.directorateUpdateService.readLatestUpdateForPeriod(directorate.ID, this.state.ReportPeriod);
                if (du) {
                    this.setState(state => ({ DirectorateUpdates: [...state.DirectorateUpdates, du] }));
                }
                const k = await this.context.dataServices.keyWorkAreaService.readDirectorateKeyWorkAreas(directorate.ID);
                this.setState(state => ({ KeyWorkAreas: [...state.KeyWorkAreas, ...k] }));
                k.forEach(async keyWorkArea => {
                    const ku = await this.context.dataServices.keyWorkAreaUpdateService.readLastSignedOffUpdateForPeriod(keyWorkArea.ID, this.state.ReportPeriod);
                    if (ku) {
                        this.setState(state => ({ KeyWorkAreaUpdates: [...state.KeyWorkAreaUpdates, ku] }));
                    }
                });
            });
        } catch (err) {
            this.props.errorHandling?.onError(`Error loading directorates`, err.message);
        }
    }

    private loadProjects = async (): Promise<void> => {
        try {
            const p = await this.context.dataServices.projectService.readDgProjects();
            this.setState({ Projects: p });
            p.forEach(async project => {
                const pu = await this.context.dataServices.projectUpdateService.readLatestUpdateForPeriod(project.ID, this.state.ReportPeriod);
                if (pu) {
                    this.setState(state => ({ ProjectUpdates: [...state.ProjectUpdates, pu] }));
                }
                const ws = await this.context.dataServices.workStreamService.readProjectWorkStreams(project.ID);
                this.setState(state => ({ WorkStreams: [...state.WorkStreams, ...ws] }));
                ws.forEach(async workStream => {
                    const wsu = await this.context.dataServices.workStreamUpdateService.readLastSignedOffUpdateForPeriod(workStream.ID, this.state.ReportPeriod);
                    if (wsu) {
                        this.setState(state => ({ WorkStreamUpdates: [...state.WorkStreamUpdates, wsu] }));
                    }
                });
            });
        } catch (err) {
            this.props.errorHandling?.onError(`Error loading projects`, err.message);
        }
    }

    //#endregion
}
