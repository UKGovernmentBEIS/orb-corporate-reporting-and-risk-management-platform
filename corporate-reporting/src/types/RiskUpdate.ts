import { IProgressUpdate, ProgressUpdate } from "./ProgressUpdate";
import { IEntity } from "./Entity";
import { ISignOff } from "./SignOff";
import { IHyperlink } from "./Hyperlink";

export interface IRiskUpdate extends IProgressUpdate {
    RiskID: number;
    RiskProbabilityID: number;
    RiskImpactLevelID: number;
    Escalate: boolean;
    EscalateToRiskRegisterID: number;
    DeEscalate: boolean;
    RiskMitigationActionUpdates: string;
    SendNotifications: boolean;
    RiskRegisterID: number;
    RiskProximity: Date;
    RiskCode: string;
    RiskIsOngoing: boolean;
    SignOffID: number;
    RiskAppetiteBreachAuthorised: boolean;
    RiskProbability?: IEntity;
    RiskImpactLevel?: IEntity;
    RiskRegister?: IEntity;
    SignOff?: ISignOff;
    Narrative: string;
    ClosureReason: string;
    Attachments?: IHyperlink[];
    ToBeDiscussed?: boolean;
    DiscussionForum?: string[];
}

export class RiskUpdate extends ProgressUpdate implements IRiskUpdate {
    public RiskID = null;
    public RiskProbabilityID = null;
    public RiskImpactLevelID = null;
    public Escalate = false;
    public EscalateToRiskRegisterID = null;
    public DeEscalate = false;
    public RiskMitigationActionUpdates = null;
    public SendNotifications = false;
    public RiskRegisterID = null;
    public RiskProximity = null;
    public RiskCode = '';
    public RiskIsOngoing = null;
    public SignOffID = null;
    public RiskAppetiteBreachAuthorised = false;
    public RiskProbability = null;
    public RiskImpactLevel = null;
    public Narrative = '';
    public ClosureReason = '';
    public UpdateUser = null;
    public Attachments = [];
    public ToBeDiscussed = false;
    public DiscussionForum = [];

    constructor(riskId?: number, period?: Date) {
        super(period);
        this.RiskID = riskId;
    }
}