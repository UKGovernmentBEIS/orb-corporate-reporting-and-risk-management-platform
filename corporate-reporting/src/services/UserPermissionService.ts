import { RiskRegister } from "../refData/RiskRegister";
import { Role } from "../refData/Role";
import {
    IBenefit, ICommitment, IDependency, IFinancialRisk, IKeyWorkArea, IMetric, IMilestone,
    IPartnerOrganisation, IPartnerOrganisationRisk, IPartnerOrganisationRiskMitigationAction,
    IRisk, IRiskMitigationAction, IUserContext, IWorkStream
} from "../types";

export interface IUserPermissionService {
    UserIsSystemAdmin: () => boolean;
    UserIsPartnerOrganisationAdmin: () => boolean;
    UserIsFinancialRiskAdmin: () => boolean;
    UserIsCustomSectionsAdmin: () => boolean;
    UserCanViewDirectorateEntities: () => boolean;
    UserCanViewProjectEntities: () => boolean;
    UserCanViewPartnerOrganisationEntities: () => boolean;
    UserCanViewRiskEntities: () => boolean;
    UserCanViewFinancialRiskEntities: () => boolean;
    UserCanSubmitBenefitUpdates: (benefit: IBenefit) => boolean;
    UserCanSubmitCommitmentUpdates: (commitment: ICommitment) => boolean;
    UserCanSubmitDependencyUpdates: (dependency: IDependency) => boolean;
    UserCanSubmitDirectorateUpdates: (directorateId: number) => boolean;
    UserCanSubmitKeyWorkAreaUpdates: (keyWorkArea: IKeyWorkArea) => boolean;
    UserCanSubmitMetricUpdates: (metric: IMetric) => boolean;
    UserCanSubmitMilestoneUpdates: ({ milestone, keyWorkArea, workStream }: { milestone: IMilestone, keyWorkArea?: IKeyWorkArea, workStream?: IWorkStream }) => boolean;
    UserCanSubmitPartnerOrganisationRiskMitigationActionUpdates: (partnerOrganisationRiskMitigationAction: IPartnerOrganisationRiskMitigationAction, partnerOrganisationRisk: IPartnerOrganisationRisk) => boolean;
    UserCanSubmitPartnerOrganisationRiskUpdates: (partnerOrganisationRisk: IPartnerOrganisationRisk) => boolean;
    UserCanSubmitPartnerOrganisationUpdates: (partnerOrganisation: IPartnerOrganisation) => boolean;
    UserCanSubmitProjectUpdates: (projectId: number) => boolean;
    UserCanSubmitRiskMitigationActionUpdates: (riskMitigationAction: IRiskMitigationAction, risk: IRisk) => boolean;
    UserCanSubmitRiskUpdates: (risk: IRisk) => boolean;
    UserCanSubmitFinancialRiskUpdates: (risk: IFinancialRisk) => boolean;
    UserCanSubmitWorkStreamUpdates: (workStream: IWorkStream) => boolean;
}

export class UserPermissionService implements IUserPermissionService {
    private _context: IUserContext;

    constructor(context: IUserContext) {
        this._context = context;
    }

    public UserIsSystemAdmin = (): boolean => this.UserIs.Admin();

    public UserIsFinancialRiskAdmin = (): boolean => this.UserIs.FinancialRiskAdmin();

    public UserIsPartnerOrganisationAdmin = (): boolean => this.UserIs.Admin() || this.UserIs.DepartmentalPartnerOrgAdmin();

    public UserIsCustomSectionsAdmin = (): boolean => this.UserIs.CustomSectionsAdmin();

    public UserCanViewDirectorateEntities = (): boolean => this.UserIs.Admin() || this.UserAdminDirectorates().length > 0;

    public UserCanViewProjectEntities = (): boolean => this.UserIs.Admin() || this.UserAdminProjects().length > 0;

    public UserCanViewPartnerOrganisationEntities = (): boolean => this.UserIs.Admin() || this.UserAdminPartnerOrganisations().length > 0;

    public UserCanViewRiskEntities = (): boolean => {
        return this.UserIs.Admin() || this.UserAdminGroupRisks().length > 0 || this.UserAdminDirectorateRisks().length > 0 || this.UserAdminProjectRisks().length > 0;
    }

    public UserCanViewFinancialRiskEntities = (): boolean => this.UserIs.FinancialRiskAdmin() || this.UserFinancialRiskGroups().length > 0;

    public UserCanSubmitBenefitUpdates = (benefit: IBenefit): boolean => {
        return benefit && (
            this.UserIs.Admin()
            || this.UserIs.Project.Admin(benefit.ProjectID)
            || this.UserIs.ContributorTo.Benefit(benefit.ID)
            || this.UserIs.Project.SeniorResponsibleOwner(benefit.ProjectID)
            || this.UserIs.Project.Approver(benefit.ProjectID)
            || benefit.LeadUserID === this._context.UserId
        );
    }

    public UserCanSubmitCommitmentUpdates = (commitment: ICommitment): boolean => {
        return commitment && (
            this.UserIs.Admin()
            || this.UserIs.Directorate.Admin(commitment.DirectorateID)
            || this.UserIs.ContributorTo.Commitment(commitment.ID)
            || this.UserIs.Directorate.Director(commitment.DirectorateID)
            || this.UserIs.Directorate.Approver(commitment.DirectorateID)
            || commitment.LeadUserID === this._context.UserId
        );
    }

    public UserCanSubmitDependencyUpdates = (dependency: IDependency): boolean => {
        return dependency && (
            this.UserIs.Admin()
            || this.UserIs.Project.Admin(dependency.ProjectID)
            || this.UserIs.ContributorTo.Dependency(dependency.ID)
            || this.UserIs.Project.SeniorResponsibleOwner(dependency.ProjectID)
            || this.UserIs.Project.Approver(dependency.ProjectID)
            || dependency.LeadUserID === this._context.UserId
        );
    }

    public UserCanSubmitDirectorateUpdates = (directorateId: number): boolean => {
        return directorateId && (
            this.UserIs.Admin()
            || this.UserIs.Directorate.Admin(directorateId)
            || this.UserIs.Directorate.Director(directorateId)
            || this.UserIs.Directorate.Approver(directorateId)
        );
    }

    public UserCanSubmitKeyWorkAreaUpdates = (keyWorkArea: IKeyWorkArea): boolean => {
        return keyWorkArea && (
            this.UserIs.Admin()
            || this.UserIs.Directorate.Admin(keyWorkArea.DirectorateID)
            || this.UserIs.ContributorTo.KeyWorkArea(keyWorkArea.ID)
            || this.UserIs.Directorate.Director(keyWorkArea.DirectorateID)
            || this.UserIs.Directorate.Approver(keyWorkArea.DirectorateID)
            || keyWorkArea.LeadUserID === this._context.UserId
        );
    }

    public UserCanSubmitMetricUpdates = (metric: IMetric): boolean => {
        return metric && (
            this.UserIs.Admin()
            || this.UserIs.Directorate.Admin(metric.DirectorateID)
            || this.UserIs.ContributorTo.Metric(metric.ID)
            || this.UserIs.Directorate.Director(metric.DirectorateID)
            || this.UserIs.Directorate.Approver(metric.DirectorateID)
            || metric.LeadUserID === this._context.UserId
        );
    }

    public UserCanSubmitMilestoneUpdates = ({ milestone, keyWorkArea, workStream }
        : { milestone: IMilestone, keyWorkArea?: IKeyWorkArea, workStream?: IWorkStream }): boolean => {
        const userId = this._context.UserId;
        if (milestone?.KeyWorkAreaID) {
            return this.UserIs.Admin()
                || this.UserIs.Directorate.Admin(keyWorkArea?.DirectorateID)
                || this.UserIs.ContributorTo.Milestone(milestone.ID)
                || this.UserIs.Directorate.Director(keyWorkArea?.DirectorateID)
                || this.UserIs.Directorate.Approver(keyWorkArea?.DirectorateID)
                || milestone.LeadUserID === userId;
        }
        if (milestone?.WorkStreamID) {
            return this.UserIs.Admin()
                || this.UserIs.Project.Admin(workStream?.ProjectID)
                || this.UserIs.ContributorTo.Milestone(milestone.ID)
                || this.UserIs.Project.SeniorResponsibleOwner(workStream?.ProjectID)
                || this.UserIs.Project.Approver(workStream?.ProjectID)
                || milestone.LeadUserID === userId;
        }
        if (milestone?.PartnerOrganisationID) {
            return this.UserIs.Admin()
                || this.UserIs.DepartmentalPartnerOrgAdmin()
                || this.UserIs.PartnerOrganisation.Admin(milestone.PartnerOrganisationID)
                || this.UserIs.ContributorTo.Milestone(milestone.ID)
                || this.UserIs.PartnerOrganisation.LeadPolicySponsor(milestone.PartnerOrganisationID)
                || this.UserIs.PartnerOrganisation.ReportAuthor(milestone.PartnerOrganisationID)
                || milestone.LeadUserID === userId;
        }
    }

    public UserCanSubmitPartnerOrganisationRiskMitigationActionUpdates = (porma: IPartnerOrganisationRiskMitigationAction, por: IPartnerOrganisationRisk): boolean => {
        const userId = this._context.UserId;
        return porma && (
            this.UserIs.DepartmentRiskManager()
            || this.UserIs.DepartmentalPartnerOrgAdmin()
            || this.UserIs.PartnerOrganisation.Admin(por?.PartnerOrganisationID)
            || this.UserIs.PartnerOrganisation.LeadPolicySponsor(por?.PartnerOrganisationID)
            || this.UserIs.PartnerOrganisation.ReportAuthor(por?.PartnerOrganisationID)
            || this.UserIs.ContributorTo.PartnerOrganisationRisk(porma.PartnerOrganisationRiskID)
            || this.UserIs.ContributorTo.PartnerOrganisationRiskMitigationAction(porma.ID)
            || (por?.BeisRiskOwnerUserID === userId)
            || (por?.RiskOwnerUserID === userId)
            || porma.OwnerUserID === userId
        );
    }

    public UserCanSubmitPartnerOrganisationRiskUpdates = (por: IPartnerOrganisationRisk): boolean => {
        const userId = this._context.UserId;
        return por && (
            this.UserIs.DepartmentRiskManager()
            || this.UserIs.DepartmentalPartnerOrgAdmin()
            || this.UserIs.PartnerOrganisation.Admin(por.PartnerOrganisationID)
            || this.UserIs.PartnerOrganisation.LeadPolicySponsor(por.PartnerOrganisationID)
            || this.UserIs.PartnerOrganisation.ReportAuthor(por.PartnerOrganisationID)
            || this.UserIs.ContributorTo.PartnerOrganisationRisk(por.ID)
            || por.BeisRiskOwnerUserID === userId
            || por.RiskOwnerUserID === userId
        );
    }

    public UserCanSubmitPartnerOrganisationUpdates = (po: IPartnerOrganisation): boolean => {
        return po && (
            this.UserIs.Admin()
            || this.UserIs.DepartmentalPartnerOrgAdmin()
            || this.UserIs.PartnerOrganisation.Admin(po.ID)
            || this.UserIs.ContributorTo.PartnerOrganisation(po.ID)
            || this.UserIs.PartnerOrganisation.LeadPolicySponsor(po.ID)
            || this.UserIs.PartnerOrganisation.ReportAuthor(po.ID)
        );
    }

    public UserCanSubmitProjectUpdates = (projectId: number): boolean => {
        return projectId && (
            this.UserIs.Admin()
            || this.UserIs.Project.Admin(projectId)
            || this.UserIs.Project.SeniorResponsibleOwner(projectId)
            || this.UserIs.Project.Approver(projectId)
        );
    }

    public UserCanSubmitRiskMitigationActionUpdates = (rma: IRiskMitigationAction, risk: IRisk): boolean => {
        const userId = this._context.UserId;
        if (risk?.IsProjectRisk
            || risk?.RiskRegisterID === RiskRegister.Departmental
            || risk?.RiskRegisterID === RiskRegister.Group
            || risk?.RiskRegisterID === RiskRegister.Directorate) {
            if (this.UserIs.DepartmentRiskManager()) {
                return true;
            }
            if (risk?.IsProjectRisk) {
                return this.UserIs.Project.RiskAdmin(risk.ProjectID)
                    || this.UserIs.ContributorTo.Risk(rma.RiskID)
                    || this.UserIs.ContributorTo.RiskMitigationAction(rma.ID)
                    || risk.RiskOwnerUserID === userId
                    || risk.ReportApproverUserID === userId
                    || rma.OwnerUserID === userId;
            }
            if (risk?.RiskRegisterID === RiskRegister.Departmental) {
                return this.UserIs.Group.RiskAdmin(risk.Directorate?.GroupID)
                    || this.UserIs.Directorate.RiskAdmin(risk.DirectorateID)
                    || this.UserIs.ContributorTo.RiskMitigationAction(rma.ID)
                    || risk.RiskOwnerUserID === userId
                    || risk.ReportApproverUserID === userId
                    || rma.OwnerUserID === userId;
            }
            if (risk?.RiskRegisterID === RiskRegister.Group) {
                return this.UserIs.Group.RiskAdmin(risk.Directorate?.GroupID)
                    || this.UserIs.Directorate.RiskAdmin(risk.DirectorateID)
                    || this.UserIs.ContributorTo.RiskMitigationAction(rma.ID)
                    || risk.RiskOwnerUserID === userId
                    || risk.ReportApproverUserID === userId
                    || rma.OwnerUserID === userId;
            }
            if (risk?.RiskRegisterID === RiskRegister.Directorate) {
                return this.UserIs.Directorate.RiskAdmin(risk.DirectorateID)
                    || this.UserIs.ContributorTo.RiskMitigationAction(rma.ID)
                    || risk.RiskOwnerUserID === userId
                    || risk.ReportApproverUserID === userId
                    || rma.OwnerUserID === userId;
            }
        }
        if (risk?.RiskRegisterID === RiskRegister.Financial) {
            return this.UserIs.FinancialRiskAdmin()
                || this.UserIs.Group.FinancialRiskAdmin(risk.GroupID)
                || this.UserIs.ContributorTo.Risk(rma.RiskID)
                || this.UserIs.ContributorTo.RiskMitigationAction(rma.ID)
                || risk.RiskOwnerUserID === userId
                || risk.ReportApproverUserID === userId
                || rma.OwnerUserID === userId;
        }
    }

    public UserCanSubmitRiskUpdates = (risk: IRisk): boolean => {
        const userId = this._context.UserId;
        if (this.UserIs.DepartmentRiskManager()) {
            return true;
        }
        if (risk?.IsProjectRisk) {
            return this.UserIs.Project.RiskAdmin(risk.ProjectID)
                || this.UserIs.ContributorTo.Risk(risk.ID)
                || risk.RiskOwnerUserID === userId
                || risk.ReportApproverUserID === userId;
        }
        if (risk?.RiskRegisterID === RiskRegister.Departmental) {
            return this.UserIs.Group.RiskAdmin(risk.Directorate?.GroupID)
                || this.UserIs.Directorate.RiskAdmin(risk.DirectorateID)
                || this.UserIs.ContributorTo.Risk(risk.ID)
                || risk.RiskOwnerUserID === userId
                || risk.ReportApproverUserID === userId;
        }
        if (risk?.RiskRegisterID === RiskRegister.Group) {
            return this.UserIs.Group.RiskAdmin(risk.Directorate?.GroupID)
                || this.UserIs.Directorate.RiskAdmin(risk.DirectorateID)
                || this.UserIs.ContributorTo.Risk(risk.ID)
                || risk.RiskOwnerUserID === userId
                || risk.ReportApproverUserID === userId;
        }
        if (risk?.RiskRegisterID === RiskRegister.Directorate) {
            return this.UserIs.Directorate.RiskAdmin(risk.DirectorateID)
                || this.UserIs.ContributorTo.Risk(risk.ID)
                || risk.RiskOwnerUserID === userId
                || risk.ReportApproverUserID === userId;
        }
    }

    public UserCanSubmitFinancialRiskUpdates = (risk: IFinancialRisk): boolean => {
        const userId = this._context.UserId;
        return this.UserIs.FinancialRiskAdmin()
            || this.UserIs.Group.FinancialRiskAdmin(risk.GroupID)
            || this.UserIs.ContributorTo.Risk(risk.ID)
            || risk.RiskOwnerUserID === userId
            || risk.ReportApproverUserID === userId;
    }

    public UserCanSubmitWorkStreamUpdates = (workStream: IWorkStream): boolean => {
        return workStream && (
            this.UserIs.Admin()
            || this.UserIs.Project.Admin(workStream.ProjectID)
            || this.UserIs.ContributorTo.WorkStream(workStream.ID)
            || this.UserIs.Project.SeniorResponsibleOwner(workStream.ProjectID)
            || this.UserIs.Project.Approver(workStream.ProjectID)
            || workStream.LeadUserID === this._context.UserId
        );
    }

    private UserAdminDirectorates = (): number[] => {
        return this._context?.UserEntities?.UserDirectorates?.filter(ud => ud.IsAdmin).map(ud => ud.DirectorateID) || [];
    }

    private UserAdminProjects = (): number[] => {
        return this._context?.UserEntities?.UserProjects?.filter(up => up.IsAdmin).map(up => up.ProjectID) || [];
    }

    private UserAdminProjectRisks = (): number[] => {
        return this._context?.UserEntities?.UserProjects?.filter(up => up.IsRiskAdmin).map(up => up.ProjectID) || [];
    }

    private UserAdminGroupRisks = (): number[] => {
        return this._context?.UserEntities?.UserGroups?.filter(ug => ug.IsRiskAdmin).map(ug => ug.GroupID) || [];
    }

    private UserAdminDirectorateRisks = (): number[] => {
        return this._context?.UserEntities?.UserDirectorates?.filter(ud => ud.IsRiskAdmin).map(ud => ud.DirectorateID) || [];
    }

    private UserAdminPartnerOrganisations = (): number[] => {
        return this._context?.UserEntities?.UserPartnerOrganisations?.filter(upo => upo.IsAdmin).map(upo => upo.PartnerOrganisationID) || [];
    }

    private UserFinancialRiskGroups = (): number[] => {
        return this._context?.UserEntities?.FinancialRiskUserGroups?.map(frug => frug.GroupID) || [];
    }

    private UserIs = {
        Admin: () => this._context?.UserEntities?.UserRoles?.some(ur => ur.RoleID === Role.Admin),
        DepartmentRiskManager: (): boolean => this._context?.UserEntities?.UserRoles?.some(ur => ur.RoleID === Role.RiskManager),
        DepartmentalPartnerOrgAdmin: (): boolean => this._context?.UserEntities?.UserRoles?.some(ur => ur.RoleID === Role.PartnerOrganisationAdmin),
        FinancialRiskAdmin: (): boolean => this._context?.UserEntities?.UserRoles?.some(ur => ur.RoleID === Role.FinancialRiskAdmin),
        CustomSectionsAdmin: (): boolean => this._context?.UserEntities?.UserRoles?.some(ur => ur.RoleID === Role.CustomSectionsAdmin),
        ContributorTo: {
            Benefit: (benefitId: number): boolean => this._context?.ContributorTo?.some(c => c.BenefitID === benefitId && !c.IsReadOnly),
            Commitment: (commitmentId: number): boolean => this._context?.ContributorTo?.some(c => c.CommitmentID === commitmentId && !c.IsReadOnly),
            Dependency: (dependencyId: number): boolean => this._context?.ContributorTo?.some(c => c.DependencyID === dependencyId && !c.IsReadOnly),
            KeyWorkArea: (keyWorkAreaId: number): boolean => this._context?.ContributorTo?.some(c => c.KeyWorkAreaID === keyWorkAreaId && !c.IsReadOnly),
            Metric: (metricId: number): boolean => this._context?.ContributorTo?.some(c => c.MetricID === metricId && !c.IsReadOnly),
            Milestone: (milestoneId: number): boolean => this._context?.ContributorTo?.some(c => c.MilestoneID === milestoneId && !c.IsReadOnly),
            PartnerOrganisation: (partnerOrganisationId: number): boolean => this._context?.ContributorTo?.some(c => c.PartnerOrganisationID === partnerOrganisationId && !c.IsReadOnly),
            PartnerOrganisationRisk: (partnerOrganisationRiskId: number): boolean => this._context?.ContributorTo?.some(c => c.PartnerOrganisationRiskID === partnerOrganisationRiskId && !c.IsReadOnly),
            PartnerOrganisationRiskMitigationAction: (partnerOrganisationRiskMitigationActionId: number): boolean => this._context?.ContributorTo?.some(c => c.PartnerOrganisationRiskMitigationActionID === partnerOrganisationRiskMitigationActionId && !c.IsReadOnly),
            Risk: (riskId: number): boolean => this._context?.ContributorTo?.some(c => c.RiskID === riskId && !c.IsReadOnly),
            RiskMitigationAction: (riskMitigationActionId: number): boolean => this._context?.ContributorTo?.some(c => c.RiskMitigationActionID === riskMitigationActionId && !c.IsReadOnly),
            WorkStream: (workStreamId: number): boolean => this._context?.ContributorTo?.some(c => c.WorkStreamID === workStreamId && !c.IsReadOnly)
        },
        Group: {
            RiskAdmin: (groupId: number) => this.UserAdminGroupRisks().some(g => g === groupId),
            FinancialRiskAdmin: (groupId: number) => this.UserFinancialRiskGroups().some(g => g === groupId)
        },
        Directorate: {
            Admin: (directorateId: number) =>
                this.UserAdminDirectorates().some(d => d === directorateId),
            Director: (directorateId: number) => this._context?.DirectorOf?.some(d => d.ID === directorateId),
            Approver: (directorateId: number) => this._context?.ApproverOfDirectorates?.some(d => d.ID === directorateId),
            RiskAdmin: (directorateId: number) => this.UserAdminDirectorateRisks().some(d => d === directorateId)
        },
        Project: {
            Admin: (projectId: number) => this.UserAdminProjects().some(p => p === projectId),
            SeniorResponsibleOwner: (projectId: number) => this._context?.SROOf?.some(p => p.ID === projectId),
            Approver: (projectId: number) => this._context?.ApproverOfProjects?.some(p => p.ID === projectId),
            RiskAdmin: (projectId: number) => this.UserAdminProjectRisks().some(p => p === projectId)
        },
        PartnerOrganisation: {
            Admin: (partnerOrganisationId: number) =>
                this.UserAdminPartnerOrganisations().some(po => po === partnerOrganisationId),
            LeadPolicySponsor: (partnerOrganisationId: number) =>
                this._context?.LeadPolicySponsorOfPartnerOrgs?.some(po => po.ID === partnerOrganisationId),
            ReportAuthor: (partnerOrganisationId: number) =>
                this._context?.ReportAuthorOfPartnerOrgs?.some(po => po.ID === partnerOrganisationId)
        }
    };
}
