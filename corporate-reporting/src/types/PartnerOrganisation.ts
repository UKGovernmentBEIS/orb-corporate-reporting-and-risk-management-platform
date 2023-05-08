import { IReportingEntity, ReportingEntity } from "./ReportingEntity";
import { IUser } from "./User";
import { IDirectorate } from "./Directorate";
import { IEntityContributors } from "./EntityContributors";
import { IMilestone } from "./Milestone";
import { IPartnerOrganisationRisk } from "./PartnerOrganisationRisk";
import { IPartnerOrganisationUpdate } from "./PartnerOrganisationUpdate";

export interface IPartnerOrganisation extends IReportingEntity, IEntityContributors {
    DirectorateID: number;
    LeadPolicySponsorUserID: number;
    ReportAuthorUserID: number;
    Objectives: string;
    ReportingFrequency: number;
    Directorate?: IDirectorate;
    LeadPolicySponsorUser?: IUser;
    ReportAuthorUser?: IUser;
    Milestones?: IMilestone[];
    PartnerOrganisationRisks?: IPartnerOrganisationRisk[];
    PartnerOrganisationUpdates?: IPartnerOrganisationUpdate[];
}

export class PartnerOrganisation extends ReportingEntity implements IPartnerOrganisation {
    public DirectorateID = null;
    public LeadPolicySponsorUserID = null;
    public ReportAuthorUserID = null;
    public Objectives = '';
    public ReportingFrequency = null;
    public Contributors = [];
}