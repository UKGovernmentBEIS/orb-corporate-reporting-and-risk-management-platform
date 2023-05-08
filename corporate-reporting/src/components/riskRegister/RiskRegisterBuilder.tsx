import React from 'react';
import { IRisk, IRiskUpdate, ICorporateRisk, ICorporateRiskUpdate, ICorporateRiskMitigationAction, IBaseComponentProps } from '../../types';
import styles from '../../styles/cr.module.scss';
import { CrLoadingOverlay } from '../cr/CrLoadingOverlay';
import { RiskRegisterRisk } from './RiskRegisterRisk';
import { CorporateRiskService } from '../../services';
import { ICorporateRiskMitigationActionUpdate } from '../../types/CorporateRiskMitigationActionUpdate';
import { DataContext } from '../DataContext';

export interface IRiskRegisterBuilderProps extends IBaseComponentProps {
    riskRegisterId: number;
    parentEntityId: number;
    reportDate: Date;
}

export interface IRiskRegisterBuilderState {
    Loading: boolean;
    Risks: ICorporateRisk[];
    RiskUpdates: ICorporateRiskUpdate[];
    RiskMitigationActions: ICorporateRiskMitigationAction[];
    RiskMitigationActionUpdates: ICorporateRiskMitigationActionUpdate[];
}

export class RiskRegisterBuilderState {
    public Loading = false;
    public Risks = [];
    public RiskUpdates = [];
    public RiskMitigationActions = [];
    public RiskMitigationActionUpdates = [];
}

export class RiskRegisterBuilder extends React.Component<IRiskRegisterBuilderProps, IRiskRegisterBuilderState> {
    static contextType = DataContext;
    context!: React.ContextType<typeof DataContext>;

    constructor(props: IRiskRegisterBuilderProps) {
        super(props);
        this.state = new RiskRegisterBuilderState();
    }

    public render(): React.ReactElement<IRiskRegisterBuilderProps> {
        const { reportDate } = this.props;
        const { Risks, Loading } = this.state;

        return (
            <div className={styles.cr} style={{ position: "relative" }}>
                <CrLoadingOverlay isLoading={Loading} opaque={true} />
                {Risks.length === 0 && <div>There are no risks on this register</div>}
                {Risks.map(r => {
                    const ru = this.state.RiskUpdates.find(riskUpdate => riskUpdate.RiskID === r.ID && riskUpdate.UpdatePeriod.getTime() === reportDate.getTime());
                    return (
                        <RiskRegisterRisk
                            key={r.ID}
                            {...this.props}
                            risk={ru?.SignOff?.Risk as ICorporateRisk || r}
                            signOff={ru?.SignOff}
                        />
                    );
                })}
            </div>
        );
    }

    public componentDidMount(): void {
        this.loadRisksAndUpdates();
    }

    public componentDidUpdate(prevProps: IRiskRegisterBuilderProps): void {
        const { reportDate } = this.props;
        const newDate = reportDate && reportDate.getTime();
        const oldDate = prevProps.reportDate && prevProps.reportDate.getTime();
        if (prevProps.riskRegisterId !== this.props.riskRegisterId || prevProps.parentEntityId !== this.props.parentEntityId) {
            this.loadRisksAndUpdates();
        }
        else if (oldDate !== newDate) {
            this.loadRisksAndUpdates();
        }
    }

    private loadRisksAndUpdates = async (): Promise<void> => {
        this.setState({ Loading: true });
        try {
            const risks = await this.loadRisks(this.props.riskRegisterId, this.props.parentEntityId, this.props.reportDate);
            this.setState({ Risks: risks });
            const riskUpdates = await this.loadRiskUpdates(risks);
            this.setState({ RiskUpdates: riskUpdates.filter(ru => ru) });
        } catch (err) {
            this.props.errorHandling?.onError(`Error loading risks`, err.message);
        } finally {
            this.setState({ Loading: false });
        }
    }

    public loadRisks = async (riskRegisterId: number, parentEntityId: number, period: Date): Promise<ICorporateRisk[]> => {
        if (riskRegisterId && parentEntityId) {
            return CorporateRiskService.sortRisksByCode(await this.context.dataServices.corporateRiskService.readRegisterRisksForMonth(riskRegisterId, parentEntityId, period));
        }
        return Promise.resolve([]);
    }

    public loadRiskUpdates = async (risks: IRisk[]): Promise<IRiskUpdate[]> => {
        return Promise.all(
            risks.map(async r => await this.context.dataServices.corporateRiskUpdateService.readLastSignedOffUpdateForPeriod(r.ID, this.props.reportDate))
        );
    }
}
