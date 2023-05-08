import { IContributor } from "./Contributor";
import { IDirectorate } from "./Directorate";
import { IFinancialRisk } from "./FinancialRisk";
import { IPartnerOrganisation } from "./PartnerOrganisation";
import { IProject } from "./Project";
import { IRisk } from "./Risk";
import { IUserEntities, UserEntities } from "./UserEntities";

export interface IUserContext {
    UserId: number;
    Username: string;
    UserEntities: IUserEntities;
    DirectorOf: IDirectorate[];
    ApproverOfDirectorates: IDirectorate[];
    SROOf: IProject[];
    ApproverOfProjects: IProject[];
    RiskOwnerOf: IRisk[];
    AlternativeApproverOfRisks?: IRisk[];
    AlternativeApproverOfFinancialRisks?: IFinancialRisk[];
    LeadPolicySponsorOfPartnerOrgs: IPartnerOrganisation[];
    ReportAuthorOfPartnerOrgs: IPartnerOrganisation[];
    ContributorTo: IContributor[];
}

export class UserContext implements IUserContext {
    public UserId = null;
    public Username = null;
    public UserEntities = new UserEntities();
    public DirectorOf = [];
    public ApproverOfDirectorates = [];
    public SROOf = [];
    public ApproverOfProjects = [];
    public RiskOwnerOf = [];
    public AlternativeApproverOfRisks = [];
    public AlternativeApproverOfFinancialRisks = [];
    public LeadPolicySponsorOfPartnerOrgs = [];
    public ReportAuthorOfPartnerOrgs = [];
    public ContributorTo = [];
}
