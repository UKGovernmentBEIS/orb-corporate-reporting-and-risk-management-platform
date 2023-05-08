import { IEntity } from "./Entity";
import { IUser } from "./User";
import { IRiskRiskType } from "./RiskRiskType";
import { IDirectorate } from "./Directorate";
import { IProject } from "./Project";
import { IReportingEntity, ReportingEntity } from "./ReportingEntity";
import { DateService } from "../services";
import { IGroup } from "./Group";
import { IRiskRiskMitigationAction } from "./RiskRiskMitigationAction";

export interface IRisk extends IReportingEntity {
    RiskCode: string;
    GroupID: number;
    DirectorateID: number;
    ProjectID: number;
    RiskOwnerUserID: number;
    RiskRegisterID: number;
    ReportApproverUserID?: number;
    RiskEventDescription: string;
    RiskCauseDescription: string;
    RiskImpactDescription: string;
    UnmitigatedRiskProbabilityID: number;
    UnmitigatedRiskImpactLevelID: number;
    TargetRiskProbabilityID: number;
    TargetRiskImpactLevelID: number;
    RiskAppetiteID: number; // Obsolete, now calculated from other selections?
    RiskIsOngoing: boolean;
    RiskProximity: Date;
    IsProjectRisk: boolean;
    CreatedDate: Date;
    RiskRegisteredDate: Date;
    Group?: IGroup;
    Directorate?: IDirectorate;
    Project?: IProject;
    RiskRegister?: IEntity;
    RiskOwnerUser?: IUser;
    ReportApproverUser?: IUser;
    RiskRiskTypes?: IRiskRiskType[];
    UnmitigatedRiskProbability?: IEntity;
    UnmitigatedRiskImpactLevel?: IEntity;
    TargetRiskProbability?: IEntity;
    TargetRiskImpactLevel?: IEntity;
    RiskAppetite?: IEntity;
    LinkedRiskID?: number;
    ChildRisks?: IRisk[];
    RiskRiskMitigationActions?: IRiskRiskMitigationAction[];
}

export class Risk extends ReportingEntity implements IRisk {
    public RiskCode = '';
    public GroupID = null;
    public DirectorateID = null;
    public ProjectID = null;
    public RiskOwnerUserID = null;
    public ReportApproverUserID = null;
    public RiskRegisterID = null;
    public RiskEventDescription = '';
    public RiskCauseDescription = '';
    public RiskImpactDescription = '';
    public UnmitigatedRiskProbabilityID = null;
    public UnmitigatedRiskImpactLevelID = null;
    public TargetRiskProbabilityID = null;
    public TargetRiskImpactLevelID = null;
    public RiskAppetiteID = null;
    public RiskIsOngoing = false;
    public RiskProximity = null;
    public IsProjectRisk = null;
    public CreatedDate = null;
    public RiskRegisteredDate = DateService.setLocaleDateToUTC(new Date());

    public Group = null;
    public Directorate = null;
    public Project = null;
    public RiskRegister = null;
    public RiskOwnerUser = null;
    public RiskRiskTypes = [];
    public UnmitigatedRiskProbability = null;
    public UnmitigatedRiskImpactLevel = null;
    public TargetRiskProbability = null;
    public TargetRiskImpactLevel = null;
    public RiskAppetite = null;
    public LinkedRiskID = null;
    public ChildRisks = [];
    public EntityStatus = null;
    public Contributors = [];
}
