import { IEntity } from "./Entity";
import { IUser } from "./User";
import { IPartnerOrganisation } from "./PartnerOrganisation";
import { IPartnerOrganisationRiskMitigationAction } from "./PartnerOrganisationRiskMitigationAction";
import { IPartnerOrganisationRiskRiskType } from "./PartnerOrganisationRiskRiskType";
import { IReportingEntity, ReportingEntity } from "./ReportingEntity";
import { IPartnerOrganisationRiskUpdate } from "./PartnerOrganisationRiskUpdate";

export interface IPartnerOrganisationRisk extends IReportingEntity {
    RiskCode: string;
    PartnerOrganisationID: number;
    RiskOwnerUserID: number;
    BeisRiskOwnerUserID: number;
    RiskEventDescription: string;
    RiskCauseDescription: string;
    RiskImpactDescription: string;
    UnmitigatedRiskProbabilityID: number;
    UnmitigatedRiskImpactLevelID: number;
    TargetRiskProbabilityID: number;
    TargetRiskImpactLevelID: number;

    BEISUnmitigatedRiskProbabilityID: number;
    BEISUnmitigatedRiskImpactLevelID: number;
    BEISTargetRiskProbabilityID: number;
    BEISTargetRiskImpactLevelID: number;

    RiskAppetiteID: number;
    BeisRiskAppetiteID: number; // Obsolete? Replaced with calculated appetite based on risk types
    DepartmentalObjectiveID: number;
    RiskIsOngoing: boolean;
    RiskProximity: Date;
    PartnerOrganisation?: IPartnerOrganisation;
    RiskOwnerUser?: IUser;
    BeisRiskOwnerUser?: IUser;
    PartnerOrganisationRiskMitigationActions?: IPartnerOrganisationRiskMitigationAction[];
    PartnerOrganisationRiskRiskTypes?: IPartnerOrganisationRiskRiskType[];
    UnmitigatedRiskProbability?: IEntity;
    UnmitigatedRiskImpactLevel?: IEntity;
    TargetRiskProbability?: IEntity;
    TargetRiskImpactLevel?: IEntity;

    BEISUnmitigatedRiskProbability?: IEntity;
    BEISUnmitigatedRiskImpactLevel?: IEntity;
    BEISTargetRiskProbability?: IEntity;
    BEISTargetRiskImpactLevel?: IEntity;

    RiskAppetite?: IEntity;
    BeisRiskAppetite?: IEntity;

    PartnerOrganisationRiskUpdates?: IPartnerOrganisationRiskUpdate[];
}

export class PartnerOrganisationRisk extends ReportingEntity implements IPartnerOrganisationRisk {
    public RiskCode = '';
    public PartnerOrganisationID = null;
    public RiskOwnerUserID = null;
    public BeisRiskOwnerUserID = null;
    public RiskEventDescription = '';
    public RiskCauseDescription = '';
    public RiskImpactDescription = '';
    public UnmitigatedRiskProbabilityID = null;
    public UnmitigatedRiskImpactLevelID = null;
    public TargetRiskProbabilityID = null;
    public TargetRiskImpactLevelID = null;

    public BEISUnmitigatedRiskProbabilityID = null;
    public BEISUnmitigatedRiskImpactLevelID = null;
    public BEISTargetRiskProbabilityID = null;
    public BEISTargetRiskImpactLevelID = null;

    public RiskAppetiteID = null;
    public BeisRiskAppetiteID = null;
    public DepartmentalObjectiveID = null;
    public RiskIsOngoing = false;
    public RiskProximity = null;
    public PartnerOrganisationRiskRiskTypes = [];
    public Contributors = [];
}