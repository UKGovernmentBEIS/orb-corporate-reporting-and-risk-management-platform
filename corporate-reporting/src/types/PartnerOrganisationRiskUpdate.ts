import { IProgressUpdate, ProgressUpdate } from "./ProgressUpdate";
import { IEntity } from "./Entity";
import { IPartnerOrganisationRisk } from "./PartnerOrganisationRisk";

export interface IPartnerOrganisationRiskUpdate extends IProgressUpdate {
    PartnerOrganisationRiskID: number;
    RiskProbabilityID: number;
    RiskImpactLevelID: number;
    BeisRiskProbabilityID: number;
    BeisRiskImpactLevelID: number;
    BeisRagOptionID: number;
    RiskProximity: Date;
    RiskIsOngoing: boolean;
    SignOffID: number;
    PartnerOrganisationRisk?: IPartnerOrganisationRisk;
    RiskProbability?: IEntity;
    RiskImpactLevel?: IEntity;
    BeisRiskProbability?: IEntity;
    BeisRiskImpactLevel?: IEntity;
}

export class PartnerOrganisationRiskUpdate extends ProgressUpdate implements IPartnerOrganisationRiskUpdate {
    public PartnerOrganisationRiskID = null;
    public RiskProbabilityID = null;
    public RiskImpactLevelID = null;
    public BeisRiskProbabilityID = null;
    public BeisRiskImpactLevelID = null;
    public BeisRagOptionID = null;
    public RiskProximity = null;
    public RiskIsOngoing = null;
    public SignOffID = null;

    constructor(riskId?: number, period?: Date) {
        super(period);
        this.PartnerOrganisationRiskID = riskId;
    }
}