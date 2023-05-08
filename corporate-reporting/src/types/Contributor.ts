import { Entity, IEntity } from "./Entity";
import { IRisk } from "./Risk";
import { IUser } from "./User";

export interface IContributor extends IEntity {
    ContributorUserID: number;
    BenefitID: number;
    CommitmentID: number;
    DependencyID: number;
    KeyWorkAreaID: number;
    MetricID: number;
    MilestoneID: number;
    WorkStreamID: number;
    RiskID: number;
    RiskMitigationActionID: number;
    PartnerOrganisationID: number;
    PartnerOrganisationRiskID: number;
    PartnerOrganisationRiskMitigationActionID: number;
    Risk?: IRisk;
    ContributorUser?: IUser;
    IsReadOnly?: boolean;
}

export class Contributor extends Entity implements IContributor {
    public ContributorUserID = null;
    public BenefitID = null;
    public CommitmentID = null;
    public DependencyID = null;
    public KeyWorkAreaID = null;
    public MetricID = null;
    public MilestoneID = null;
    public WorkStreamID = null;
    public RiskID = null;
    public RiskMitigationActionID = null;
    public PartnerOrganisationID = null;
    public PartnerOrganisationRiskID = null;
    public PartnerOrganisationRiskMitigationActionID = null;
    public IsReadOnly = false;
}