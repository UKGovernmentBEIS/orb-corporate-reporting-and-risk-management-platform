using Microsoft.AspNet.OData;
using Microsoft.AspNet.OData.Routing;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using ORB.Core.Models;
using ORB.Core.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ORB.API.Controllers
{
    [Authorize]
    public class UsersController : BaseEntityController<User>
    {
        private readonly IUserService _userService;

        public UsersController(ILogger<UsersController> logger, IUserService service) : base(logger, service)
        {
            _userService = service;
        }

        // GET: odata/Users/GetUserPermissions(Username=andrew.lott2@beis.gov.uk)
        [EnableQuery]
        [ODataRoute("Users/GetUserPermissions(Username={username})")]
        public ActionResult<User> GetUserPermissions([FromODataUri] string username)
        {
            var userPerms = _userService.GetUserPermissions(username);

            if (userPerms == null)
            {
                return NotFound($"User not found: {username}");
            }

            return userPerms;
        }

        #region Navigation property methods

        // GET: odata/Users(5)/Attributes
        [EnableQuery]
        public IQueryable<ORB.Core.Models.Attribute> GetAttributes([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.Attributes);
        }

        // GET: odata/Users(5)/BenefitLeadUsers
        [EnableQuery]
        public IQueryable<Benefit> GetBenefitLeadUsers([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.BenefitLeadUsers);
        }

        // GET: odata/Users(5)/BenefitModifiedByUsers
        [EnableQuery]
        public IQueryable<Benefit> GetBenefitModifiedByUsers([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.BenefitModifiedByUsers);
        }

        // GET: odata/Users(5)/BenefitUpdates
        [EnableQuery]
        public IQueryable<BenefitUpdate> GetBenefitUpdates([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.BenefitUpdates);
        }

        // GET: odata/Users(5)/GroupBusinessPartnerUsers
        [EnableQuery]
        public IQueryable<Group> GetGroupBusinessPartnerUsers([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.GroupBusinessPartnerUsers);
        }

        // GET: odata/Users(5)/CommitmentLeadUsers
        [EnableQuery]
        public IQueryable<Commitment> GetCommitmentLeadUsers([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.CommitmentLeadUsers);
        }

        // GET: odata/Users(5)/CommitmentModifiedByUsers
        [EnableQuery]
        public IQueryable<Commitment> GetCommitmentModifiedByUsers([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.CommitmentModifiedByUsers);
        }

        // GET: odata/Users(5)/CommitmentUpdates
        [EnableQuery]
        public IQueryable<CommitmentUpdate> GetCommitmentUpdates([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.CommitmentUpdates);
        }

        // GET: odata/Users(5)/ContributorContributorUsers
        [EnableQuery]
        public IQueryable<Contributor> GetContributorContributorUsers([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.ContributorContributorUsers);
        }

        // GET: odata/Users(5)/ContributorModifiedByUsers
        [EnableQuery]
        public IQueryable<Contributor> GetContributorModifiedByUsers([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.ContributorModifiedByUsers);
        }

        // GET: odata/Users(5)/DependencyLeadUsers
        [EnableQuery]
        public IQueryable<Dependency> GetDependencyLeadUsers([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.DependencyLeadUsers);
        }

        // GET: odata/Users(5)/DependencyModifiedByUsers
        [EnableQuery]
        public IQueryable<Dependency> GetDependencyModifiedByUsers([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.DependencyModifiedByUsers);
        }

        // GET: odata/Users(5)/DependencyUpdates
        [EnableQuery]
        public IQueryable<DependencyUpdate> GetDependencyUpdates([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.DependencyUpdates);
        }

        // GET: odata/Users(5)/DirectorateDirectorUsers
        [EnableQuery]
        public IQueryable<Directorate> GetDirectorateDirectorUsers([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.DirectorateDirectorUsers);
        }

        // GET: odata/Users(5)/DirectorateModifiedByUsers
        [EnableQuery]
        public IQueryable<Directorate> GetDirectorateModifiedByUsers([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.DirectorateModifiedByUsers);
        }

        // GET: odata/Users(5)/DirectorateReportApproverUsers
        [EnableQuery]
        public IQueryable<Directorate> GetDirectorateReportApproverUsers([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.DirectorateReportApproverUsers);
        }

        // GET: odata/Users(5)/DirectorateReportingLeadUsers
        [EnableQuery]
        public IQueryable<Directorate> GetDirectorateReportingLeadUsers([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.DirectorateReportingLeadUsers);
        }

        // GET: odata/Users(5)/DirectorateUpdates
        [EnableQuery]
        public IQueryable<DirectorateUpdate> GetDirectorateUpdates([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.DirectorateUpdates);
        }

        // GET: odata/Users(5)/GroupDirectorGeneralUsers
        [EnableQuery]
        public IQueryable<Group> GetGroupDirectorGeneralUsers([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.GroupDirectorGeneralUsers);
        }

        // GET: odata/Users(5)/GroupModifiedByUsers
        [EnableQuery]
        public IQueryable<Group> GetGroupModifiedByUsers([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.GroupModifiedByUsers);
        }

        // GET: odata/Users(5)/KeyWorkAreaLeadUsers
        [EnableQuery]
        public IQueryable<KeyWorkArea> GetKeyWorkAreaLeadUsers([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.KeyWorkAreaLeadUsers);
        }

        // GET: odata/Users(5)/KeyWorkAreaModifiedByUsers
        [EnableQuery]
        public IQueryable<KeyWorkArea> GetKeyWorkAreaModifiedByUsers([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.KeyWorkAreaModifiedByUsers);
        }

        // GET: odata/Users(5)/KeyWorkAreaUpdates
        [EnableQuery]
        public IQueryable<KeyWorkAreaUpdate> GetKeyWorkAreaUpdates([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.KeyWorkAreaUpdates);
        }

        // GET: odata/Users(5)/MetricLeadUsers
        [EnableQuery]
        public IQueryable<Metric> GetMetricLeadUsers([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.MetricLeadUsers);
        }

        // GET: odata/Users(5)/MetricModifiedByUsers
        [EnableQuery]
        public IQueryable<Metric> GetMetricModifiedByUsers([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.MetricModifiedByUsers);
        }

        // GET: odata/Users(5)/MetricUpdates
        [EnableQuery]
        public IQueryable<MetricUpdate> GetMetricUpdates([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.MetricUpdates);
        }

        // GET: odata/Users(5)/MilestoneLeadUsers
        [EnableQuery]
        public IQueryable<Milestone> GetMilestoneLeadUsers([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.MilestoneLeadUsers);
        }

        // GET: odata/Users(5)/MilestoneModifiedByUsers
        [EnableQuery]
        public IQueryable<Milestone> GetMilestoneModifiedByUsers([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.MilestoneModifiedByUsers);
        }

        // GET: odata/Users(5)/MilestoneUpdates
        [EnableQuery]
        public IQueryable<MilestoneUpdate> GetMilestoneUpdates([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.MilestoneUpdates);
        }

        // GET: odata/Users(5)/UsersModifiedByUser
        [EnableQuery]
        public IQueryable<User> GetUsersModifiedByUser([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.UsersModifiedByUser);
        }

        // GET: odata/Users(5)/PartnerOrganisationLeadPolicySponsorUsers
        [EnableQuery]
        public IQueryable<PartnerOrganisation> GetPartnerOrganisationLeadPolicySponsorUsers([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.PartnerOrganisationLeadPolicySponsorUsers);
        }

        // GET: odata/Users(5)/PartnerOrganisationRiskMitigationActionOwnerUsers
        [EnableQuery]
        public IQueryable<PartnerOrganisationRiskMitigationAction> GetPartnerOrganisationRiskMitigationActionOwnerUsers([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.PartnerOrganisationRiskMitigationActionOwnerUsers);
        }

        // GET: odata/Users(5)/PartnerOrganisationRiskMitigationActionModifiedByUsers
        [EnableQuery]
        public IQueryable<PartnerOrganisationRiskMitigationAction> GetPartnerOrganisationRiskMitigationActionModifiedByUsers([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.PartnerOrganisationRiskMitigationActionModifiedByUsers);
        }

        // GET: odata/Users(5)/PartnerOrganisationRiskMitigationActionUpdates
        [EnableQuery]
        public IQueryable<PartnerOrganisationRiskMitigationActionUpdate> GetPartnerOrganisationRiskMitigationActionUpdates([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.PartnerOrganisationRiskMitigationActionUpdates);
        }

        // GET: odata/Users(5)/PartnerOrganisationRiskRiskTypes
        [EnableQuery]
        public IQueryable<PartnerOrganisationRiskRiskType> GetPartnerOrganisationRiskRiskTypes([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.PartnerOrganisationRiskRiskTypes);
        }

        // GET: odata/Users(5)/PartnerOrganisationRiskBeisRiskOwnerUsers
        [EnableQuery]
        public IQueryable<PartnerOrganisationRisk> GetPartnerOrganisationRiskBeisRiskOwnerUsers([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.PartnerOrganisationRiskBeisRiskOwnerUsers);
        }

        // GET: odata/Users(5)/PartnerOrganisationRiskModifiedByUsers
        [EnableQuery]
        public IQueryable<PartnerOrganisationRisk> GetPartnerOrganisationRiskModifiedByUsers([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.PartnerOrganisationRiskModifiedByUsers);
        }

        // GET: odata/Users(5)/PartnerOrganisationRiskRiskOwnerUsers
        [EnableQuery]
        public IQueryable<PartnerOrganisationRisk> GetPartnerOrganisationRiskRiskOwnerUsers([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.PartnerOrganisationRiskRiskOwnerUsers);
        }

        // GET: odata/Users(5)/PartnerOrganisationRiskUpdates
        [EnableQuery]
        public IQueryable<PartnerOrganisationRiskUpdate> GetPartnerOrganisationRiskUpdates([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.PartnerOrganisationRiskUpdates);
        }

        // GET: odata/Users(5)/PartnerOrganisationModifiedByUsers
        [EnableQuery]
        public IQueryable<PartnerOrganisation> GetPartnerOrganisationModifiedByUsers([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.PartnerOrganisationModifiedByUsers);
        }

        // GET: odata/Users(5)/PartnerOrganisationReportAuthorUsers
        [EnableQuery]
        public IQueryable<PartnerOrganisation> GetPartnerOrganisationReportAuthorUsers([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.PartnerOrganisationReportAuthorUsers);
        }

        // GET: odata/Users(5)/PartnerOrganisationUpdates
        [EnableQuery]
        public IQueryable<PartnerOrganisationUpdate> GetPartnerOrganisationUpdates([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.PartnerOrganisationUpdates);
        }

        // GET: odata/Users(5)/ProjectProjectManagerUsers
        [EnableQuery]
        public IQueryable<Project> GetProjectProjectManagerUsers([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.ProjectProjectManagerUsers);
        }

        // GET: odata/Users(5)/ProjectModifiedByUsers
        [EnableQuery]
        public IQueryable<Project> GetProjectModifiedByUsers([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.ProjectModifiedByUsers);
        }

        // GET: odata/Users(5)/ProjectReportApproverUsers
        [EnableQuery]
        public IQueryable<Project> GetProjectReportApproverUsers([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.ProjectReportApproverUsers);
        }

        // GET: odata/Users(5)/ProjectReportingLeadUsers
        [EnableQuery]
        public IQueryable<Project> GetProjectReportingLeadUsers([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.ProjectReportingLeadUsers);
        }

        // GET: odata/Users(5)/ProjectUpdates
        [EnableQuery]
        public IQueryable<ProjectUpdate> GetProjectUpdates([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.ProjectUpdates);
        }

        // GET: odata/Users(5)/GroupRiskChampionDeputyDirectorUsers
        [EnableQuery]
        public IQueryable<Group> GetGroupRiskChampionDeputyDirectorUsers([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.GroupRiskChampionDeputyDirectorUsers);
        }

        // GET: odata/Users(5)/RiskMitigationActionOwnerUsers
        [EnableQuery]
        public IQueryable<RiskMitigationAction> GetRiskMitigationActionOwnerUsers([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.RiskMitigationActionOwnerUsers);
        }

        // GET: odata/Users(5)/RiskMitigationActionModifiedByUsers
        [EnableQuery]
        public IQueryable<RiskMitigationAction> GetRiskMitigationActionModifiedByUsers([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.RiskMitigationActionModifiedByUsers);
        }

        // GET: odata/Users(5)/CorporateRiskRiskOwnerUsers
        [EnableQuery]
        public IQueryable<CorporateRisk> GetCorporateRiskRiskOwnerUsers([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.CorporateRiskRiskOwnerUsers);
        }

        // GET: odata/Users(5)/CorporateRiskModifiedByUsers
        [EnableQuery]
        public IQueryable<CorporateRisk> GetCorporateRiskModifiedByUsers([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.CorporateRiskModifiedByUsers);
        }

        // GET: odata/Users(5)/CorporateRiskReportApproverUsers
        [EnableQuery]
        public IQueryable<CorporateRisk> GetCorporateRiskReportApproverUsers([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.CorporateRiskReportApproverUsers);
        }

        // GET: odata/Users(5)/CorporateRiskUpdates
        [EnableQuery]
        public IQueryable<CorporateRiskUpdate> GetCorporateRiskUpdates([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.CorporateRiskUpdates);
        }

        // GET: odata/Users(5)/FinancialRiskRiskOwnerUsers
        [EnableQuery]
        public IQueryable<FinancialRisk> GetFinancialRiskRiskOwnerUsers([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.FinancialRiskRiskOwnerUsers);
        }

        // GET: odata/Users(5)/FinancialRiskModifiedByUsers
        [EnableQuery]
        public IQueryable<FinancialRisk> GetFinancialRiskModifiedByUsers([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.FinancialRiskModifiedByUsers);
        }

        // GET: odata/Users(5)/FinancialRiskReportApproverUsers
        [EnableQuery]
        public IQueryable<FinancialRisk> GetFinancialRiskReportApproverUsers([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.FinancialRiskReportApproverUsers);
        }

        // GET: odata/Users(5)/FinancialRiskUpdates
        [EnableQuery]
        public IQueryable<FinancialRiskUpdate> GetFinancialRiskUpdates([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.FinancialRiskUpdates);
        }

        // GET: odata/Users(5)/ProjectSeniorResponsibleOwnerUsers
        [EnableQuery]
        public IQueryable<Project> GetProjectSeniorResponsibleOwnerUsers([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.ProjectSeniorResponsibleOwnerUsers);
        }

        // GET: odata/Users(5)/SignOffs
        [EnableQuery]
        public IQueryable<SignOff> GetSignOffs([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.SignOffs);
        }

        // GET: odata/Users(5)/UserDirectorates
        [EnableQuery]
        public IQueryable<UserDirectorate> GetUserDirectorates([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.UserDirectorates);
        }

        // GET: odata/Users(5)/UserDirectorateModifiedByUsers
        [EnableQuery]
        public IQueryable<UserDirectorate> GetUserDirectorateModifiedByUsers([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.UserDirectorateModifiedByUsers);
        }

        // GET: odata/Users(5)/UserGroups
        [EnableQuery]
        public IQueryable<UserGroup> GetUserGroups([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.UserGroups);
        }

        // GET: odata/Users(5)/UserGroupModifiedByUsers
        [EnableQuery]
        public IQueryable<UserGroup> GetUserGroupModifiedByUsers([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.UserGroupModifiedByUsers);
        }

        // GET: odata/Users(5)/UserPartnerOrganisations
        [EnableQuery]
        public IQueryable<UserPartnerOrganisation> GetUserPartnerOrganisations([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.UserPartnerOrganisations);
        }

        // GET: odata/Users(5)/UserPartnerOrganisationModifiedByUsers
        [EnableQuery]
        public IQueryable<UserPartnerOrganisation> GetUserPartnerOrganisationModifiedByUsers([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.UserPartnerOrganisationModifiedByUsers);
        }

        // GET: odata/Users(5)/UserProjects
        [EnableQuery]
        public IQueryable<UserProject> GetUserProjects([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.UserProjects);
        }

        // GET: odata/Users(5)/UserProjectModifiedByUsers
        [EnableQuery]
        public IQueryable<UserProject> GetUserProjectModifiedByUsers([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.UserProjectModifiedByUsers);
        }

        // GET: odata/Users(5)/CorporateRiskMitigationActionUpdates
        [EnableQuery]
        public IQueryable<RiskMitigationActionUpdate> GetCorporateRiskMitigationActionUpdates([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.CorporateRiskMitigationActionUpdates);
        }

        // GET: odata/Users(5)/FinancialRiskMitigationActionUpdates
        [EnableQuery]
        public IQueryable<RiskMitigationActionUpdate> GetFinancialRiskMitigationActionUpdates([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.FinancialRiskMitigationActionUpdates);
        }

        // GET: odata/Users(5)/UserRoles
        [EnableQuery]
        public IQueryable<UserRole> GetUserRoles([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.UserRoles);
        }

        // GET: odata/Users(5)/UserRoleModifiedByUsers
        [EnableQuery]
        public IQueryable<UserRole> GetUserRoleModifiedByUsers([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.UserRoleModifiedByUsers);
        }

        // GET: odata/Users(5)/WorkStreamLeadUsers
        [EnableQuery]
        public IQueryable<WorkStream> GetWorkStreamLeadUsers([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.WorkStreamLeadUsers);
        }

        // GET: odata/Users(5)/WorkStreamModifiedByUsers
        [EnableQuery]
        public IQueryable<WorkStream> GetWorkStreamModifiedByUsers([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.WorkStreamModifiedByUsers);
        }

        // GET: odata/Users(5)/WorkStreamUpdates
        [EnableQuery]
        public IQueryable<WorkStreamUpdate> GetWorkStreamUpdates([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.WorkStreamUpdates);
        }

        #endregion
    }
}
