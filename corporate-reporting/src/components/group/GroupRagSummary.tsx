import React from 'react';
import { DateService } from '../../services';
import { IBaseComponentProps, ISignOff } from '../../types';
import styles from '../../styles/cr.module.scss';
import { RagIndicator } from '../cr/RagIndicator';
import { DataContext } from '../DataContext';

export interface IGroupRagSummaryState {
    SignOffs: ISignOff[];
}

export class GroupRagSummaryState implements IGroupRagSummaryState {
    public SignOffs = [];
}

export class GroupRagSummary extends React.Component<IBaseComponentProps, IGroupRagSummaryState> {
    static contextType = DataContext;
    context!: React.ContextType<typeof DataContext>;

    constructor(props: IBaseComponentProps) {
        super(props);
        this.state = new GroupRagSummaryState();
    }

    public render(): React.ReactElement<IBaseComponentProps> {
        return (
            <div className={styles.cr}>
                <table>
                    <thead>
                        <tr>
                            <th>Group</th>
                            <th>Directorate</th>
                            <th>Report Month</th>
                            <th>Delivery confidence</th>
                            <th>Finance</th>
                            <th>People</th>
                            <th>Milestones</th>
                            <th>Metrics</th>
                        </tr>
                    </thead>
                    <tbody>
                        {this.state.SignOffs.map(so =>
                            <tr key={so.ID}>
                                <td>{so.Directorate && so.Directorate.Group && so.Directorate.Group.Title}</td>
                                <td>{so.Directorate && so.Directorate.Title}</td>
                                <td>{DateService.dateToMonthNameFormat(so.ReportMonth)}</td>
                                <td><RagIndicator rag={so.DirectorateUpdates.length > 0 ? so.DirectorateUpdates[0].OverallRagOptionID : null} /></td>
                                <td><RagIndicator rag={so.DirectorateUpdates.length > 0 ? so.DirectorateUpdates[0].FinanceRagOptionID : null} /></td>
                                <td><RagIndicator rag={so.DirectorateUpdates.length > 0 ? so.DirectorateUpdates[0].PeopleRagOptionID : null} /></td>
                                <td><RagIndicator rag={so.DirectorateUpdates.length > 0 ? so.DirectorateUpdates[0].MilestonesRagOptionID : null} /></td>
                                <td><RagIndicator rag={so.DirectorateUpdates.length > 0 ? so.DirectorateUpdates[0].MetricsRagOptionID : null} /></td>
                            </tr>
                        )}
                    </tbody>
                </table>
            </div>
        );
    }

    //#region Form initialisation

    public componentDidMount(): void {
        this.loadSignOffs();
    }

    private loadSignOffs = async (): Promise<void> => {
        const so = await this.context.dataServices.signOffService.readRagSummary();
        this.setState({ SignOffs: so });
    }

    //#endregion
}
