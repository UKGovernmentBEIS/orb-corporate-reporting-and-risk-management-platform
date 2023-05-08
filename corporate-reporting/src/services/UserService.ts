import { WebPartContext } from '@microsoft/sp-webpart-base';
import { EntityWithStatusService } from './EntityWithStatusService';
import { ContextService } from './ContextService';
import { IUser, IDataAPI, IEntityChildren } from '../types';
import { EntityStatus } from '../refData/EntityStatus';

export class UserService extends EntityWithStatusService<IUser> {
    private _username: string;

    constructor(spfxContext: WebPartContext, api: IDataAPI) {
        super(spfxContext, api, `/Users`);
        this._username = spfxContext.pageContext.user.loginName;
    }

    get Username(): string {
        return ContextService.alterUsername(this._username);
    }

    public async readMyPermissions(): Promise<IUser> {
        return await this.getEntity(
            `${this.entityUrl}/GetUserPermissions(Username='${encodeURIComponent(this.Username)}')?$select=ID,Title,Username,EntityStatusID`
            + `&$expand=UserRoles($select=ID,UserID,RoleID)`
            + `,UserGroups($select=ID,UserID,GroupID,IsRiskAdmin;$expand=Group($select=ID,Title))`
            + `,UserDirectorates($select=ID,UserID,DirectorateID,IsAdmin,IsRiskAdmin;$expand=Directorate($select=ID,Title))`
            + `,UserProjects($select=ID,UserID,ProjectID,IsAdmin,IsRiskAdmin;$expand=Project($select=ID,Title))`
            + `,UserPartnerOrganisations($select=ID,UserID,PartnerOrganisationID,IsAdmin,HideHeadlines,HideMilestones,HideCustomSections;$expand=PartnerOrganisation($select=ID,Title))`
            + `,DirectorateDirectorUsers($select=ID,Title)`
            + `,DirectorateReportApproverUsers($select=ID,Title)`
            + `,ProjectSeniorResponsibleOwnerUsers($select=ID,Title)`
            + `,ProjectReportApproverUsers($select=ID,Title)`
            + `,CorporateRiskRiskOwnerUsers($select=ID,Title)`
            + `,CorporateRiskReportApproverUsers($select=ID,Title)`
            + `,FinancialRiskRiskOwnerUsers($select=ID,Title)`
            + `,FinancialRiskReportApproverUsers($select=ID,Title)`
            + `,ContributorContributorUsers($expand=CorporateRisk($select=ID,Title),FinancialRisk($select=ID,Title))`
            + `,PartnerOrganisationLeadPolicySponsorUsers($select=ID,Title)`
            + `,PartnerOrganisationReportAuthorUsers($select=ID,Title)`
            + `,FinancialRiskUserGroups($select=ID,UserID,GroupID;$expand=Group($select=ID,Title))`
        );
    }

    public readUsersByUsername(username: string): Promise<IUser[]> {
        return this.readAll(
            `?$select=ID,Title,Username`
            + `&$filter=toLower(Username) eq '${encodeURIComponent(username?.toLowerCase())}'`
        );
    }

    public readUsersByEmailAddress(emailAddress: string): Promise<IUser[]> {
        return this.readAll(
            `?$select=ID,Title,EmailAddress`
            + `&$filter=toLower(EmailAddress) eq '${encodeURIComponent(emailAddress?.toLowerCase())}'`
        );
    }

    public readForLookup(id: number): Promise<IUser> {
        return this.read(id, false, false, [], `(${id})?$select=ID,Title,Username`);
    }

    public readAllForLookup(includeClosed?: boolean): Promise<IUser[]> {
        return this.readAll(
            `?$select=ID,Title,Username`
            + `&$orderby=Title`
            + (includeClosed ? `` : `&$filter=EntityStatusID eq ${EntityStatus.Open}`)
        );
    }

    public readAllForList(includeDisabledUsers?: boolean): Promise<IUser[]> {
        return this.readAll(
            `?$select=ID,Title,Username,EmailAddress,EntityStatusID`
            + `&$orderby=Username`
            + (includeDisabledUsers ? `` : `&$filter=EntityStatusID eq ${EntityStatus.Open}`)
        );
    }

    public search(query: string): Promise<IUser[]> {
        return this.readAll(`?$select=ID,Title,Username&$filter=contains(Title,'${query}') or contains(Username,'${query}')&$orderby=Title`);
    }

    public async entityChildren(id: number): Promise<IEntityChildren[]> {
        const userUrl = `${this.entityUrl}(${id})`;
        const qs = `?$select=ID&$top=10`;
        const attributes = this.getEntities(`${userUrl}/Attributes${qs}`);
        const benefits = this.getEntities(`${userUrl}/BenefitLeadUsers${qs}`);
        const benefitsModified = this.getEntities(`${userUrl}/BenefitModifiedByUsers${qs}`);
        const benefitUpdates = this.getEntities(`${userUrl}/BenefitUpdates${qs}`);
        const businessPartnerGroups = this.getEntities(`${userUrl}/GroupBusinessPartnerUsers${qs}`);
        const commitments = this.getEntities(`${userUrl}/CommitmentLeadUsers${qs}`);
        const commitmentsModified = this.getEntities(`${userUrl}/CommitmentModifiedByUsers${qs}`);
        const commitmentUpdates = this.getEntities(`${userUrl}/CommitmentUpdates${qs}`);
        const contributors = this.getEntities(`${userUrl}/ContributorContributorUsers?$select=BenefitID,CommitmentID,DependencyID,KeyWorkAreaID,MetricID,MilestoneID,PartnerOrganisationID,PartnerOrganisationRiskID,PartnerOrganisationRiskMitigationActionID,RiskID,RiskMitigationActionID,WorkStreamID&$top=10`);
        const contributorsModified = this.getEntities(`${userUrl}/ContributorModifiedByUsers?$select=BenefitID,CommitmentID,DependencyID,KeyWorkAreaID,MetricID,MilestoneID,PartnerOrganisationID,PartnerOrganisationRiskID,PartnerOrganisationRiskMitigationActionID,RiskID,RiskMitigationActionID,WorkStreamID&$top=10`);
        const dependencies = this.getEntities(`${userUrl}/DependencyLeadUsers${qs}`);
        const dependenciesModified = this.getEntities(`${userUrl}/DependencyModifiedByUsers${qs}`);
        const dependencyUpdates = this.getEntities(`${userUrl}/DependencyUpdates${qs}`);
        const directorates = this.getEntities(`${userUrl}/DirectorateDirectorUsers${qs}`);
        const directoratesModified = this.getEntities(`${userUrl}/DirectorateModifiedByUsers${qs}`);
        const directoratesReportApprover = this.getEntities(`${userUrl}/DirectorateReportApproverUsers${qs}`);
        const directoratesReportingLead = this.getEntities(`${userUrl}/DirectorateReportingLeadUsers${qs}`);
        const directorateUpdates = this.getEntities(`${userUrl}/DirectorateUpdates${qs}`);
        const groups = this.getEntities(`${userUrl}/GroupDirectorGeneralUsers${qs}`);
        const groupsModified = this.getEntities(`${userUrl}/GroupModifiedByUsers${qs}`);
        const keyWorkAreas = this.getEntities(`${userUrl}/KeyWorkAreaLeadUsers${qs}`);
        const keyWorkAreasModified = this.getEntities(`${userUrl}/KeyWorkAreaModifiedByUsers${qs}`);
        const keyWorkAreaUpdates = this.getEntities(`${userUrl}/KeyWorkAreaUpdates${qs}`);
        const metrics = this.getEntities(`${userUrl}/MetricLeadUsers${qs}`);
        const metricsModified = this.getEntities(`${userUrl}/MetricModifiedByUsers${qs}`);
        const metricUpdates = this.getEntities(`${userUrl}/MetricUpdates${qs}`);
        const milestones = this.getEntities(`${userUrl}/MilestoneLeadUsers${qs}`);
        const milestonesModified = this.getEntities(`${userUrl}/MilestoneModifiedByUsers${qs}`);
        const milestoneUpdates = this.getEntities(`${userUrl}/MilestoneUpdates${qs}`);
        const modifiedByUser = this.getEntities(`${userUrl}/UsersModifiedByUser${qs}`);
        const partnerOrganisationLeadPolicySponsor = this.getEntities(`${userUrl}/PartnerOrganisationLeadPolicySponsorUsers${qs}`);
        const partnerOrganisationRiskMitigationActions = this.getEntities(`${userUrl}/PartnerOrganisationRiskMitigationActionModifiedByUsers${qs}`);
        const partnerOrganisationRiskMitigationActionsOwner = this.getEntities(`${userUrl}/PartnerOrganisationRiskMitigationActionOwnerUsers${qs}`);
        const partnerOrganisationRiskMitigationActionUpdates = this.getEntities(`${userUrl}/PartnerOrganisationRiskMitigationActionUpdates${qs}`);
        const partnerOrganisationRiskRiskTypes = this.getEntities(`${userUrl}/PartnerOrganisationRiskRiskTypes${qs}`);
        const partnerOrganisationRisksBeisRiskOwner = this.getEntities(`${userUrl}/PartnerOrganisationRiskBeisRiskOwnerUsers${qs}`);
        const partnerOrganisationRisksModified = this.getEntities(`${userUrl}/PartnerOrganisationRiskModifiedByUsers${qs}`);
        const partnerOrganisationRisksRiskOwner = this.getEntities(`${userUrl}/PartnerOrganisationRiskRiskOwnerUsers${qs}`);
        const partnerOrganisationRiskUpdates = this.getEntities(`${userUrl}/PartnerOrganisationRiskUpdates${qs}`);
        const partnerOrganisationsModified = this.getEntities(`${userUrl}/PartnerOrganisationModifiedByUsers${qs}`);
        const partnerOrganisationsReportAuthor = this.getEntities(`${userUrl}/PartnerOrganisationReportAuthorUsers${qs}`);
        const partnerOrganisationUpdates = this.getEntities(`${userUrl}/PartnerOrganisationUpdates${qs}`);
        const projectManagerProjects = this.getEntities(`${userUrl}/ProjectProjectManagerUsers${qs}`);
        const projectsModified = this.getEntities(`${userUrl}/ProjectModifiedByUsers${qs}`);
        const projectsReportApprover = this.getEntities(`${userUrl}/ProjectReportApproverUsers${qs}`);
        const projectsReportingLead = this.getEntities(`${userUrl}/ProjectReportingLeadUsers${qs}`);
        const projectUpdates = this.getEntities(`${userUrl}/ProjectUpdates${qs}`);
        const riskChampionGroups = this.getEntities(`${userUrl}/GroupRiskChampionDeputyDirectorUsers${qs}`);
        const riskMitigationActions = this.getEntities(`${userUrl}/RiskMitigationActionOwnerUsers${qs}`);
        const riskMitigationActionsModified = this.getEntities(`${userUrl}/RiskMitigationActionModifiedByUsers${qs}`);
        const risks = this.getEntities(`${userUrl}/CorporateRiskRiskOwnerUsers${qs}`);
        const risksModifiedByUsers = this.getEntities(`${userUrl}/CorporateRiskModifiedByUsers${qs}`);
        const risksReportApprovers = this.getEntities(`${userUrl}/CorporateRiskReportApproverUsers${qs}`);
        const riskUpdates = this.getEntities(`${userUrl}/CorporateRiskUpdates${qs}`);
        const seniorResponsibleOwnerProjects = this.getEntities(`${userUrl}/ProjectSeniorResponsibleOwnerUsers${qs}`);
        const signOffs = this.getEntities(`${userUrl}/SignOffs${qs}`);
        const userDirectorates = this.getEntities(`${userUrl}/UserDirectorates${qs}`);
        const userDirectoratesModified = this.getEntities(`${userUrl}/UserDirectorateModifiedByUsers${qs}`);
        const userGroups = this.getEntities(`${userUrl}/UserGroups${qs}`);
        const userGroupsModified = this.getEntities(`${userUrl}/UserGroupModifiedByUsers${qs}`);
        const userPartnerOrganisations = this.getEntities(`${userUrl}/UserPartnerOrganisations${qs}`);
        const userPartnerOrganisationsModified = this.getEntities(`${userUrl}/UserPartnerOrganisationModifiedByUsers${qs}`);
        const userProjects = this.getEntities(`${userUrl}/UserProjects${qs}`);
        const userProjectsModified = this.getEntities(`${userUrl}/UserProjectModifiedByUsers${qs}`);
        const userRiskMitigationActionUpdates = this.getEntities(`${userUrl}/CorporateRiskMitigationActionUpdates${qs}`);
        const userRoles = this.getEntities(`${userUrl}/UserRoles${qs}`);
        const userRolesModified = this.getEntities(`${userUrl}/UserRoleModifiedByUsers${qs}`);
        const workStreams = this.getEntities(`${userUrl}/WorkStreamLeadUsers${qs}`);
        const workStreamsModified = this.getEntities(`${userUrl}/WorkStreamModifiedByUsers${qs}`);
        const workStreamUpdates = this.getEntities(`${userUrl}/WorkStreamUpdates${qs}`);

        return [
            { ChildType: 'Attributes', CanBeAdopted: true, ChildIDs: (await attributes).map(a => a.ID) },
            { ChildType: 'Benefits', CanBeAdopted: true, ChildIDs: (await benefits).map(b => b.ID) },
            { ChildType: 'Benefits', CanBeAdopted: true, ChildIDs: (await benefitsModified).map(b => b.ID) },
            { ChildType: 'Benefit updates', CanBeAdopted: false, ChildIDs: (await benefitUpdates).map(b => b.ID) },
            { ChildType: 'Groups', CanBeAdopted: true, ChildIDs: (await businessPartnerGroups).map(b => b.ID) },
            { ChildType: 'Commitments', CanBeAdopted: true, ChildIDs: (await commitments).map(c => c.ID) },
            { ChildType: 'CommitmentsModified', CanBeAdopted: true, ChildIDs: (await commitmentsModified).map(c => c.ID) },
            { ChildType: 'CommitmentUpdates', CanBeAdopted: true, ChildIDs: (await commitmentUpdates).map(c => c.ID) },
            { ChildType: 'Contributor benefits', CanBeAdopted: true, ChildIDs: (await contributors).filter(c => c['BenefitID']).map(c => c['BenefitID']) },
            { ChildType: 'Contributor commitments', CanBeAdopted: true, ChildIDs: (await contributors).filter(c => c['CommitmentID']).map(c => c['CommitmentID']) },
            { ChildType: 'Contributor dependencies', CanBeAdopted: true, ChildIDs: (await contributors).filter(c => c['DependencyID']).map(c => c['DependencyID']) },
            { ChildType: 'Contributor key work areas', CanBeAdopted: true, ChildIDs: (await contributors).filter(c => c['KeyWorkAreaID']).map(c => c['KeyWorkAreaID']) },
            { ChildType: 'Contributor metrics', CanBeAdopted: true, ChildIDs: (await contributors).filter(c => c['MetricID']).map(c => c['MetricID']) },
            { ChildType: 'Contributor milestones', CanBeAdopted: true, ChildIDs: (await contributors).filter(c => c['MilestoneID']).map(c => c['MilestoneID']) },
            { ChildType: 'Contributor partner organisations', CanBeAdopted: true, ChildIDs: (await contributors).filter(c => c['PartnerOrganisationID']).map(c => c['PartnerOrganisationID']) },
            { ChildType: 'Contributor partner organisation risks', CanBeAdopted: true, ChildIDs: (await contributors).filter(c => c['PartnerOrganisationRiskID']).map(c => c['PartnerOrganisationRiskID']) },
            { ChildType: 'Contributor partner organisation risk mitigation actions', CanBeAdopted: true, ChildIDs: (await contributors).filter(c => c['PartnerOrganisationRiskMitigationActionID']).map(c => c['PartnerOrganisationRiskMitigationActionID']) },
            { ChildType: 'Contributor risks', CanBeAdopted: true, ChildIDs: (await contributors).filter(c => c['RiskID']).map(c => c['RiskID']) },
            { ChildType: 'Contributor risk mitigating actions', CanBeAdopted: true, ChildIDs: (await contributors).filter(c => c['RiskMitigationActionID']).map(c => c['RiskMitigationActionID']) },
            { ChildType: 'Contributor work streams', CanBeAdopted: true, ChildIDs: (await contributors).filter(c => c['WorkStreamID']).map(c => c['WorkStreamID']) },
            { ChildType: 'Contributors modified', CanBeAdopted: false, ChildIDs: (await contributorsModified).filter(c => c['BenefitID']).map(c => c['BenefitID']) },
            { ChildType: 'Contributors modified', CanBeAdopted: false, ChildIDs: (await contributorsModified).filter(c => c['CommitmentID']).map(c => c['CommitmentID']) },
            { ChildType: 'Contributors modified', CanBeAdopted: false, ChildIDs: (await contributorsModified).filter(c => c['DependencyID']).map(c => c['DependencyID']) },
            { ChildType: 'Contributors modified', CanBeAdopted: false, ChildIDs: (await contributorsModified).filter(c => c['KeyWorkAreaID']).map(c => c['KeyWorkAreaID']) },
            { ChildType: 'Contributors modified', CanBeAdopted: false, ChildIDs: (await contributorsModified).filter(c => c['MetricID']).map(c => c['MetricID']) },
            { ChildType: 'Contributors modified', CanBeAdopted: false, ChildIDs: (await contributorsModified).filter(c => c['MilestoneID']).map(c => c['MilestoneID']) },
            { ChildType: 'Contributors modified', CanBeAdopted: false, ChildIDs: (await contributorsModified).filter(c => c['PartnerOrganisationID']).map(c => c['PartnerOrganisationID']) },
            { ChildType: 'Contributors modified', CanBeAdopted: false, ChildIDs: (await contributorsModified).filter(c => c['PartnerOrganisationRiskID']).map(c => c['PartnerOrganisationRiskID']) },
            { ChildType: 'Contributors modified', CanBeAdopted: false, ChildIDs: (await contributorsModified).filter(c => c['PartnerOrganisationRiskMitigationActionID']).map(c => c['PartnerOrganisationRiskMitigationActionID']) },
            { ChildType: 'Contributors modified', CanBeAdopted: false, ChildIDs: (await contributorsModified).filter(c => c['RiskID']).map(c => c['RiskID']) },
            { ChildType: 'Contributors modified', CanBeAdopted: false, ChildIDs: (await contributorsModified).filter(c => c['RiskMitigationActionID']).map(c => c['RiskMitigationActionID']) },
            { ChildType: 'Contributors modified', CanBeAdopted: false, ChildIDs: (await contributorsModified).filter(c => c['WorkStreamID']).map(c => c['WorkStreamID']) },
            { ChildType: 'Dependencies', CanBeAdopted: true, ChildIDs: (await dependencies).map(c => c.ID) },
            { ChildType: 'Dependencies modified', CanBeAdopted: false, ChildIDs: (await dependenciesModified).map(c => c.ID) },
            { ChildType: 'Dependency updates', CanBeAdopted: false, ChildIDs: (await dependencyUpdates).map(c => c.ID) },
            { ChildType: 'Directorates', CanBeAdopted: true, ChildIDs: (await directorates).map(c => c.ID) },
            { ChildType: 'Directorates modified', CanBeAdopted: false, ChildIDs: (await directoratesModified).map(c => c.ID) },
            { ChildType: 'Directorates', CanBeAdopted: true, ChildIDs: (await directoratesReportApprover).map(c => c.ID) },
            { ChildType: 'Directorates', CanBeAdopted: true, ChildIDs: (await directoratesReportingLead).map(c => c.ID) },
            { ChildType: 'Directorate updates', CanBeAdopted: false, ChildIDs: (await directorateUpdates).map(c => c.ID) },
            { ChildType: 'Groups', CanBeAdopted: true, ChildIDs: (await groups).map(c => c.ID) },
            { ChildType: 'Groups modified', CanBeAdopted: false, ChildIDs: (await groupsModified).map(c => c.ID) },
            { ChildType: 'Key work areas', CanBeAdopted: true, ChildIDs: (await keyWorkAreas).map(c => c.ID) },
            { ChildType: 'Key work areas modified', CanBeAdopted: false, ChildIDs: (await keyWorkAreasModified).map(c => c.ID) },
            { ChildType: 'Key work area updates', CanBeAdopted: false, ChildIDs: (await keyWorkAreaUpdates).map(c => c.ID) },
            { ChildType: 'Metrics', CanBeAdopted: true, ChildIDs: (await metrics).map(c => c.ID) },
            { ChildType: 'Metrics modified', CanBeAdopted: false, ChildIDs: (await metricsModified).map(c => c.ID) },
            { ChildType: 'Metric updates', CanBeAdopted: false, ChildIDs: (await metricUpdates).map(c => c.ID) },
            { ChildType: 'Milestones', CanBeAdopted: true, ChildIDs: (await milestones).map(c => c.ID) },
            { ChildType: 'Milestones modified', CanBeAdopted: false, ChildIDs: (await milestonesModified).map(c => c.ID) },
            { ChildType: 'Milestone updates', CanBeAdopted: false, ChildIDs: (await milestoneUpdates).map(c => c.ID) },
            { ChildType: 'Modified users', CanBeAdopted: false, ChildIDs: (await modifiedByUser).map(c => c.ID) },
            { ChildType: 'Partner organisations', CanBeAdopted: true, ChildIDs: (await partnerOrganisationLeadPolicySponsor).map(c => c.ID) },
            { ChildType: 'Partner organisation risk mitigation actions', CanBeAdopted: true, ChildIDs: (await partnerOrganisationRiskMitigationActions).map(c => c.ID) },
            { ChildType: 'Partner organisation risk mitigation actions', CanBeAdopted: true, ChildIDs: (await partnerOrganisationRiskMitigationActionsOwner).map(c => c.ID) },
            { ChildType: 'Partner organisation risk mitigation action updates', CanBeAdopted: false, ChildIDs: (await partnerOrganisationRiskMitigationActionUpdates).map(c => c.ID) },
            { ChildType: 'Partner organisation risks', CanBeAdopted: true, ChildIDs: (await partnerOrganisationRiskRiskTypes).map(c => c.ID) },
            { ChildType: 'Partner organisation risks', CanBeAdopted: true, ChildIDs: (await partnerOrganisationRisksBeisRiskOwner).map(c => c.ID) },
            { ChildType: 'Partner organisation risks modified', CanBeAdopted: false, ChildIDs: (await partnerOrganisationRisksModified).map(c => c.ID) },
            { ChildType: 'Partner organisation risks', CanBeAdopted: true, ChildIDs: (await partnerOrganisationRisksRiskOwner).map(c => c.ID) },
            { ChildType: 'Partner organisation risk updates', CanBeAdopted: false, ChildIDs: (await partnerOrganisationRiskUpdates).map(c => c.ID) },
            { ChildType: 'Partner organisations modified', CanBeAdopted: false, ChildIDs: (await partnerOrganisationsModified).map(c => c.ID) },
            { ChildType: 'Partner organisations', CanBeAdopted: true, ChildIDs: (await partnerOrganisationsReportAuthor).map(c => c.ID) },
            { ChildType: 'Partner organisation updates', CanBeAdopted: false, ChildIDs: (await partnerOrganisationUpdates).map(c => c.ID) },
            { ChildType: 'Projects', CanBeAdopted: true, ChildIDs: (await projectManagerProjects).map(c => c.ID) },
            { ChildType: 'Projects modified', CanBeAdopted: false, ChildIDs: (await projectsModified).map(c => c.ID) },
            { ChildType: 'Projects', CanBeAdopted: true, ChildIDs: (await projectsReportApprover).map(c => c.ID) },
            { ChildType: 'Projects', CanBeAdopted: true, ChildIDs: (await projectsReportingLead).map(c => c.ID) },
            { ChildType: 'Project updates', CanBeAdopted: false, ChildIDs: (await projectUpdates).map(c => c.ID) },
            { ChildType: 'Groups', CanBeAdopted: true, ChildIDs: (await riskChampionGroups).map(c => c.ID) },
            { ChildType: 'Risk mitigation actions', CanBeAdopted: true, ChildIDs: (await riskMitigationActions).map(c => c.ID) },
            { ChildType: 'Risk mitigation actions modified', CanBeAdopted: false, ChildIDs: (await riskMitigationActionsModified).map(c => c.ID) },
            { ChildType: 'Risks', CanBeAdopted: true, ChildIDs: (await risks).map(c => c.ID) },
            { ChildType: 'Risks modified by users', CanBeAdopted: false, ChildIDs: (await risksModifiedByUsers).map(c => c.ID) },
            { ChildType: 'Risks report approvers', CanBeAdopted: true, ChildIDs: (await risksReportApprovers).map(c => c.ID) },
            { ChildType: 'Risk updates', CanBeAdopted: false, ChildIDs: (await riskUpdates).map(c => c.ID) },
            { ChildType: 'Senior responsible owner projects', CanBeAdopted: true, ChildIDs: (await seniorResponsibleOwnerProjects).map(c => c.ID) },
            { ChildType: 'Reports', CanBeAdopted: false, ChildIDs: (await signOffs).map(c => c.ID) },
            { ChildType: 'User directorates', CanBeAdopted: true, ChildIDs: (await userDirectorates).map(c => c.ID) },
            { ChildType: 'User directorates modified', CanBeAdopted: false, ChildIDs: (await userDirectoratesModified).map(c => c.ID) },
            { ChildType: 'User groups', CanBeAdopted: true, ChildIDs: (await userGroups).map(c => c.ID) },
            { ChildType: 'User groups modified', CanBeAdopted: false, ChildIDs: (await userGroupsModified).map(c => c.ID) },
            { ChildType: 'User partner organisations', CanBeAdopted: true, ChildIDs: (await userPartnerOrganisations).map(c => c.ID) },
            { ChildType: 'User partner organisations modified', CanBeAdopted: false, ChildIDs: (await userPartnerOrganisationsModified).map(c => c.ID) },
            { ChildType: 'User projects', CanBeAdopted: true, ChildIDs: (await userProjects).map(c => c.ID) },
            { ChildType: 'User projects modified', CanBeAdopted: false, ChildIDs: (await userProjectsModified).map(c => c.ID) },
            { ChildType: 'User risk mitigation action updates', CanBeAdopted: false, ChildIDs: (await userRiskMitigationActionUpdates).map(c => c.ID) },
            { ChildType: 'User roles', CanBeAdopted: true, ChildIDs: (await userRoles).map(c => c.ID) },
            { ChildType: 'User roles modified', CanBeAdopted: false, ChildIDs: (await userRolesModified).map(c => c.ID) },
            { ChildType: 'Work streams', CanBeAdopted: true, ChildIDs: (await workStreams).map(c => c.ID) },
            { ChildType: 'Work streams modified', CanBeAdopted: false, ChildIDs: (await workStreamsModified).map(c => c.ID) },
            { ChildType: 'Work stream updates', CanBeAdopted: false, ChildIDs: (await workStreamUpdates).map(c => c.ID) }
        ];
    }
}