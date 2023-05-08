import { IAttributeType } from '../types';
import { IEntity } from './Entity';

export interface IAttribute extends IEntity {
    ID: number;
    AttributeTypeID: number;
    AttributeValue: string;
    BenefitID: number;
    CommitmentID: number;
    DependencyID: number;
    KeyWorkAreaID: number;
    MetricID: number;
    MilestoneID: number;
    WorkStreamID: number;
    AttributeType?: IAttributeType;
    RiskID: number;
    PartnerOrganisationRiskID: number;
    DirectorateID: number;
    ProjectID: number;
}

export class Attribute implements IAttribute {
    public ID = 0;
    public Title = null;
    public AttributeTypeID = null;
    public AttributeValue = '';
    public BenefitID = null;
    public CommitmentID = null;
    public DependencyID = null;
    public KeyWorkAreaID = null;
    public MetricID = null;
    public MilestoneID = null;
    public WorkStreamID = null;
    public AttributeType = null;
    public RiskID = null;
    public PartnerOrganisationRiskID = null;
    public DirectorateID = null;
    public ProjectID = null;
}