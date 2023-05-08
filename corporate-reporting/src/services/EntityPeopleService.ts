import { IEntityRole } from "../types/EntityRole";
import { DirectorateService } from "./DirectorateService";
import { PartnerOrganisationService } from "./PartnerOrganisationService";
import { ProjectService } from "./ProjectService";
import { CorporateRiskService } from "./CorporateRiskService";
import { UserDirectorateService } from "./UserDirectorateService";
import { UserPartnerOrganisationService } from "./UserPartnerOrganisationService";
import { UserProjectService } from "./UserProjectService";
import { FinancialRiskService } from "./FinancialRiskService";

export class EntityPeopleService {
    public static GetProjectEntityPeople = async (
        { projectService, userProjectService, projectId }: { projectService: ProjectService, userProjectService: UserProjectService, projectId: number }
    ): Promise<IEntityRole[]> => {
        const people = [];
        const promProjectPeople = projectService.readProjectApprovers(projectId);
        const promAdmins = userProjectService.readProjectAdmins(projectId);
        const projectPeople = await promProjectPeople;
        const admins = await promAdmins;

        if (projectPeople) {
            if (projectPeople.SeniorResponsibleOwnerUser)
                people.push({ role: 'Approver', names: [projectPeople.SeniorResponsibleOwnerUser.Title] });
            if (projectPeople.ReportApproverUser)
                people.push({ role: 'Alternative approver', names: [projectPeople.ReportApproverUser.Title] });
            if (projectPeople.ReportingLeadUser)
                people.push({ role: 'Project reporting lead', names: [projectPeople.ReportingLeadUser.Title] });
        }
        if (admins && admins.length > 0)
            people.push({ role: 'Project admins', names: admins.map(a => a.User && a.User.Title) });

        return people;
    }

    public static GetDirectorateEntityPeople = async (
        { directorateService, userDirectorateService, directorateId }: { directorateService: DirectorateService, userDirectorateService: UserDirectorateService, directorateId: number }
    ): Promise<IEntityRole[]> => {
        const people = [];
        const promDirectoratePeople = directorateService.readDirectorateApprovers(directorateId);
        const promAdmins = userDirectorateService.readDirectorateAdmins(directorateId);
        const directoratePeople = await promDirectoratePeople;
        const admins = await promAdmins;

        if (directoratePeople) {
            if (directoratePeople.DirectorUser)
                people.push({ role: 'Approver', names: [directoratePeople.DirectorUser.Title] });
            if (directoratePeople.ReportApproverUser)
                people.push({ role: 'Alternative approver', names: [directoratePeople.ReportApproverUser.Title] });
            if (directoratePeople.ReportingLeadUser)
                people.push({ role: 'Directorate reporting lead', names: [directoratePeople.ReportingLeadUser.Title] });
        }
        if (admins && admins.length > 0)
            people.push({ role: 'Directorate admins', names: admins.map(ud => ud.User && ud.User.Title) });

        return people;
    }

    public static GetPartnerOrganisationEntityPeople = async (
        { partnerOrganisationService, userPartnerOrganisationService, partnerOrganisationId }: { partnerOrganisationService: PartnerOrganisationService, userPartnerOrganisationService: UserPartnerOrganisationService, partnerOrganisationId: number }
    ): Promise<IEntityRole[]> => {
        const people = [];
        const promPartnerOrgPeople = partnerOrganisationService.readPartnerOrganisationApprovers(partnerOrganisationId);
        const promAdmins = userPartnerOrganisationService.readPartnerOrganisationAdmins(partnerOrganisationId);
        const partnerOrgPeople = await promPartnerOrgPeople;
        const admins = await promAdmins;

        if (partnerOrgPeople && partnerOrgPeople.LeadPolicySponsorUser)
            people.push({ role: 'Approver', names: [partnerOrgPeople.LeadPolicySponsorUser.Title] });
        if (partnerOrgPeople && partnerOrgPeople.ReportAuthorUser)
            people.push({ role: 'Alternative approver', names: [partnerOrgPeople.ReportAuthorUser.Title] });
        if (admins && admins.length > 0)
            people.push({ role: 'Partner organisation admins', names: admins.map(a => a.User && a.User.Title) });

        return people;
    }

    public static GetRiskEntityPeople = async (
        { riskService, riskId }: { riskService: CorporateRiskService | FinancialRiskService, riskId: number }
    ): Promise<IEntityRole[]> => {
        const people = [];
        const risk = await riskService.readRiskPeople(riskId);

        if (risk) {
            if (risk.RiskOwnerUser)
                people.push({ role: 'Risk owner (approver)', names: [risk.RiskOwnerUser.Title] });
            if (risk.ReportApproverUser)
                people.push({ role: 'Alternative risk approver', names: [risk.ReportApproverUser.Title] });
        }

        return people;
    }
}
