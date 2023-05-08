import { IEntity, Entity } from "./Entity";

export interface IPartnerOrganisationRiskRiskType extends IEntity {
    PartnerOrganisationRiskID: number;
    RiskTypeID: number;
}

export class PartnerOrganisationRiskRiskType extends Entity implements IPartnerOrganisationRiskRiskType {
    public PartnerOrganisationRiskID = null;
    public RiskTypeID = null;
}