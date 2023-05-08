import { IEntityWithStatus, EntityWithStatus } from "./EntityWithStatus";
import { IUserRole } from "./UserRole";
import { IUserGroup } from "./UserGroup";
import { IUserDirectorate } from "./UserDirectorate";
import { IUserProject } from "./UserProject";
import { IDirectorate } from "./Directorate";
import { IProject } from "./Project";
import { IRisk } from "./Risk";
import { IUserPartnerOrganisation } from "./UserPartnerOrganisation";
import { IPartnerOrganisation } from "./PartnerOrganisation";
import { IContributor } from "./Contributor";
import { IFinancialRisk } from "./FinancialRisk";

export interface IUser extends IEntityWithStatus {
    Username: string;
    EmailAddress: string;
    IsServiceAccount?: boolean;
    UserRoles?: IUserRole[];
    UserGroups?: IUserGroup[];
    UserDirectorates?: IUserDirectorate[];
    UserPartnerOrganisations?: IUserPartnerOrganisation[];
    UserProjects?: IUserProject[];
    DirectorateDirectorUsers?: IDirectorate[];
    ProjectSeniorResponsibleOwnerUsers?: IProject[];
    CorporateRiskRiskOwnerUsers?: IRisk[];
    CorporateRiskReportApproverUsers?: IRisk[];
    FinancialRiskRiskOwnerUsers?: IFinancialRisk[];
    FinancialRiskReportApproverUsers?: IFinancialRisk[];
    DirectorateReportApproverUsers?: IDirectorate[];
    ProjectReportApproverUsers?: IProject[];
    PartnerOrganisationLeadPolicySponsorUsers?: IPartnerOrganisation[];
    PartnerOrganisationReportAuthorUsers?: IPartnerOrganisation[];
    ContributorContributorUsers?: IContributor[];
    FinancialRiskUserGroups?: IUserGroup[];
}

export class User extends EntityWithStatus implements IUser {
    public Username = '';
    public EmailAddress = '';
    public IsServiceAccount = false;
}