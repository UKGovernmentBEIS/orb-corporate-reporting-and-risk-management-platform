using Microsoft.EntityFrameworkCore;
using ORB.Core;
using ORB.Core.Models;
using ORB.Core.Services;
using ORB.Services.Validations;
using System.Collections.Generic;
using System.Linq;

namespace ORB.Services
{
    public class UserService : EntityWithStatusService<User>, IUserService
    {
        public UserService(IUnitOfWork unitOfWork) : base(unitOfWork, unitOfWork.Users, new UserValidator(unitOfWork)) { }

        public string FirstRequest()
        {
            return _unitOfWork.Users.FirstRequest();
        }

        protected override void BeforeClose(User entity)
        {
            base.BeforeClose(entity);
            RemoveUserPermissions(entity);
        }

        private void RemoveUserPermissions(User userEntity)
        {
            var user = _repository.Entities.Where(u => u.ID == userEntity.ID)
                .Include(u => u.UserDirectorates)
                .Include(u => u.UserGroups)
                .Include(u => u.UserPartnerOrganisations)
                .Include(u => u.UserProjects)
                .Include(u => u.UserRoles)
                .SingleOrDefault();
            if (user != null)
            {


                foreach (var ud in user.UserDirectorates.ToList())
                {
                    _unitOfWork.UserDirectorates.Remove(ud);
                }
                foreach (var ug in user.UserGroups.ToList())
                {
                    _unitOfWork.UserGroups.Remove(ug);
                }
                foreach (var upo in user.UserPartnerOrganisations.ToList())
                {
                    _unitOfWork.UserPartnerOrganisations.Remove(upo);
                }
                foreach (var up in user.UserProjects.ToList())
                {
                    _unitOfWork.UserProjects.Remove(up);
                }
                foreach (var ur in user.UserRoles.ToList())
                {
                    _unitOfWork.UserRoles.Remove(ur);
                }
            }
        }

        /// <summary>
        /// Get user permissions for UI context.
        /// </summary>
        /// <param name="username">A user's username</param>
        /// <returns>User object with related entities/mappings</returns>
        public User GetUserPermissions(string username)
        {
            return _repository.Entities
                        .Include(u => u.UserRoles)
                        .Include(u => u.UserGroups).ThenInclude(ug => ug.Group)
                        .Include(u => u.UserDirectorates).ThenInclude(ud => ud.Directorate)
                        .Include(u => u.UserProjects).ThenInclude(up => up.Project)
                        .Include(u => u.UserPartnerOrganisations).ThenInclude(upo => upo.PartnerOrganisation)
                        .Include(u => u.DirectorateDirectorUsers)
                        .Include(u => u.DirectorateReportApproverUsers)
                        .Include(u => u.ProjectSeniorResponsibleOwnerUsers)
                        .Include(u => u.ProjectReportApproverUsers)
                        .Include(u => u.CorporateRiskRiskOwnerUsers)
                        .Include(u => u.CorporateRiskReportApproverUsers)
                        .Include(u => u.FinancialRiskRiskOwnerUsers)
                        .Include(u => u.FinancialRiskReportApproverUsers)
                        .Include(u => u.ContributorContributorUsers).ThenInclude(c => c.CorporateRisk)
                        .Include(u => u.ContributorContributorUsers).ThenInclude(c => c.FinancialRisk)
                        .Include(u => u.PartnerOrganisationLeadPolicySponsorUsers)
                        .Include(u => u.PartnerOrganisationReportAuthorUsers)
                        .Include(u => u.FinancialRiskUserGroups).ThenInclude(ug => ug.Group)
                        .AsSplitQuery()
                        .OrderBy(u => u.ID)
                        .SingleOrDefault(u => u.Username == username);
        }

        /// <summary>
        /// Users associated with a project. Used for reminder email distribution list.
        /// </summary>
        /// <param name="project"></param>
        /// <returns></returns>
        public IEnumerable<User> AuthorUsersInProject(Project project)
        {
            var projectUserIds = new List<int>();

            var dependencies = _unitOfWork.Dependencies.Entities.Include(d => d.Contributors).Where(d => d.ProjectID == project.ID && d.EntityStatusID == (int)EntityStatuses.Open);
            foreach (var d in dependencies)
            {
                if (d.LeadUserID != null) projectUserIds.Add((int)d.LeadUserID);
                AddContributors(projectUserIds, d.Contributors);
            }

            var milestones = _unitOfWork.Milestones.Entities.Include(m => m.Contributors).Where(m => m.WorkStream.ProjectID == project.ID && m.EntityStatusID == (int)EntityStatuses.Open);
            foreach (var m in milestones)
            {
                if (m.LeadUserID != null) projectUserIds.Add((int)m.LeadUserID);
                AddContributors(projectUserIds, m.Contributors);
            }

            var workStreams = _unitOfWork.WorkStreams.Entities.Include(w => w.Contributors).Where(w => w.ProjectID == project.ID && w.EntityStatusID == (int)EntityStatuses.Open);
            foreach (var w in workStreams)
            {
                if (w.LeadUserID != null) projectUserIds.Add((int)w.LeadUserID);
                AddContributors(projectUserIds, w.Contributors);
            }

            var risks = _unitOfWork.CorporateRisks.Entities.Include(r => r.Contributors).Where(r => r.IsProjectRisk == true && r.ProjectID == project.ID && r.EntityStatusID == (int)EntityStatuses.Open);
            foreach (var r in risks)
            {
                if (r.RiskOwnerUserID != null) projectUserIds.Add((int)r.RiskOwnerUserID);
                AddContributors(projectUserIds, r.Contributors);
            }

            var actions = _unitOfWork.CorporateRiskMitigationActions.Entities.Include(a => a.Contributors).Where(a => a.Risk.IsProjectRisk == true && a.Risk.ProjectID == project.ID && a.EntityStatusID == (int)EntityStatuses.Open);
            foreach (var a in actions)
            {
                if (a.OwnerUserID != null) projectUserIds.Add((int)a.OwnerUserID);
                AddContributors(projectUserIds, a.Contributors);
            }

            // Project admins
            projectUserIds.AddRange(_unitOfWork.UserProjects.Entities.Where(u => u.IsAdmin && u.ProjectID == project.ID).Select(u => u.UserID));

            return _repository.Entities.Where(u => u.EntityStatusID == (int)EntityStatuses.Open && projectUserIds.Contains(u.ID));
        }

        /// <summary>
        /// Users who approve project reports. Used for reminder email distribution list.
        /// </summary>
        /// <param name="project"></param>
        /// <returns></returns>
        public IEnumerable<User> ApproverUsersInProject(Project project)
        {
            var projectUserIds = new List<int>();

            if (project.SeniorResponsibleOwnerUserID != null) projectUserIds.Add((int)project.SeniorResponsibleOwnerUserID);
            if (project.ReportApproverUserID != null) projectUserIds.Add((int)project.ReportApproverUserID);

            return _repository.Entities.Where(u => u.EntityStatusID == (int)EntityStatuses.Open && projectUserIds.Contains(u.ID));
        }

        /// <summary>
        /// Users associated with directorates. Used for reminder email distribution list.
        /// </summary>
        /// <param name="directorate"></param>
        /// <returns></returns>
        public IEnumerable<User> AuthorUsersInDirectorate(Directorate directorate)
        {
            var directorateUserIds = new List<int>();

            var commitments = _unitOfWork.Commitments.Entities.Include(c => c.Contributors).Where(c => c.DirectorateID == directorate.ID && c.EntityStatusID == (int)EntityStatuses.Open);
            foreach (var c in commitments)
            {
                if (c.LeadUserID != null) directorateUserIds.Add((int)c.LeadUserID);
                AddContributors(directorateUserIds, c.Contributors);
            }

            var keyWorkAreas = _unitOfWork.KeyWorkAreas.Entities.Include(k => k.Contributors).Where(k => k.DirectorateID == directorate.ID && k.EntityStatusID == (int)EntityStatuses.Open);
            foreach (var k in keyWorkAreas)
            {
                if (k.LeadUserID != null) directorateUserIds.Add((int)k.LeadUserID);
                AddContributors(directorateUserIds, k.Contributors);
            }

            var milestones = _unitOfWork.Milestones.Entities.Include(m => m.Contributors).Where(m => m.KeyWorkArea.DirectorateID == directorate.ID && m.EntityStatusID == (int)EntityStatuses.Open);
            foreach (var m in milestones)
            {
                if (m.LeadUserID != null) directorateUserIds.Add((int)m.LeadUserID);
                AddContributors(directorateUserIds, m.Contributors);
            }

            var risks = _unitOfWork.CorporateRisks.Entities.Include(r => r.Contributors).Where(r => r.IsProjectRisk == false && r.DirectorateID == directorate.ID && r.EntityStatusID == (int)EntityStatuses.Open);
            foreach (var r in risks)
            {
                if (r.RiskOwnerUserID != null) directorateUserIds.Add((int)r.RiskOwnerUserID);
                AddContributors(directorateUserIds, r.Contributors);
            }

            var actions = _unitOfWork.CorporateRiskMitigationActions.Entities.Include(a => a.Contributors).Where(a => a.Risk.IsProjectRisk == false && a.Risk.DirectorateID == directorate.ID && a.EntityStatusID == (int)EntityStatuses.Open);
            foreach (var a in actions)
            {
                if (a.OwnerUserID != null) directorateUserIds.Add((int)a.OwnerUserID);
                AddContributors(directorateUserIds, a.Contributors);
            }

            // Directorate admins
            directorateUserIds.AddRange(_unitOfWork.UserDirectorates.Entities.Where(u => u.IsAdmin && u.DirectorateID == directorate.ID).Select(u => u.UserID));

            return _repository.Entities.Where(u => u.EntityStatusID == (int)EntityStatuses.Open && directorateUserIds.Contains(u.ID));
        }

        /// <summary>
        /// Users who approve directorate reports. Used for reminder email distribution list.
        /// </summary>
        /// <param name="directorate"></param>
        /// <returns></returns>
        public IEnumerable<User> ApproverUsersInDirectorate(Directorate directorate)
        {
            var directorateUserIds = new List<int>();

            if (directorate.DirectorUserID != null) directorateUserIds.Add((int)directorate.DirectorUserID);
            if (directorate.ReportApproverUserID != null) directorateUserIds.Add((int)directorate.ReportApproverUserID);

            return _repository.Entities.Where(u => u.EntityStatusID == (int)EntityStatuses.Open && directorateUserIds.Contains(u.ID));
        }

        /// <summary>
        /// Users associated with a partner organisation. Used for reminder email distribution list.
        /// </summary>
        /// <param name="partnerOrganisation"></param>
        /// <returns></returns>
        public IEnumerable<User> AuthorUsersInPartnerOrganisation(PartnerOrganisation partnerOrganisation)
        {
            var partnerOrgUserIds = new List<int>();

            if (partnerOrganisation.LeadPolicySponsorUserID != null) partnerOrgUserIds.Add((int)partnerOrganisation.LeadPolicySponsorUserID);
            if (partnerOrganisation.ReportAuthorUserID != null) partnerOrgUserIds.Add((int)partnerOrganisation.ReportAuthorUserID);

            var milestones = _unitOfWork.Milestones.Entities.Include(m => m.Contributors).Where(m => m.PartnerOrganisationID == partnerOrganisation.ID && m.EntityStatusID == (int)EntityStatuses.Open);
            foreach (var m in milestones)
            {
                if (m.LeadUserID != null) partnerOrgUserIds.Add((int)m.LeadUserID);
                AddContributors(partnerOrgUserIds, m.Contributors);
            }

            var risks = _unitOfWork.PartnerOrganisationRisks.Entities.Include(r => r.Contributors).Where(r => r.PartnerOrganisationID == partnerOrganisation.ID && r.EntityStatusID == (int)EntityStatuses.Open);
            foreach (var r in risks)
            {
                if (r.RiskOwnerUserID != null) partnerOrgUserIds.Add((int)r.RiskOwnerUserID);
                if (r.BeisRiskOwnerUserID != null) partnerOrgUserIds.Add((int)r.BeisRiskOwnerUserID);
                AddContributors(partnerOrgUserIds, r.Contributors);
            }

            var actions = _unitOfWork.PartnerOrganisationRiskMitigationActions.Entities.Include(a => a.Contributors).Where(a => a.PartnerOrganisationRisk.PartnerOrganisationID == partnerOrganisation.ID && a.EntityStatusID == (int)EntityStatuses.Open);
            foreach (var a in actions)
            {
                if (a.OwnerUserID != null) partnerOrgUserIds.Add((int)a.OwnerUserID);
                AddContributors(partnerOrgUserIds, a.Contributors);
            }

            return _repository.Entities.Where(u => u.EntityStatusID == (int)EntityStatuses.Open && partnerOrgUserIds.Contains(u.ID));
        }

        /// <summary>
        /// Users who approve partner organisation reports. Used for reminder email distribution list.
        /// </summary>
        /// <param name="partnerOrganisation"></param>
        /// <returns></returns>
        public IEnumerable<User> ApproverUsersInPartnerOrganisation(PartnerOrganisation partnerOrganisation)
        {
            var partnerOrgUserIds = new List<int>();

            if (partnerOrganisation.LeadPolicySponsorUserID != null) partnerOrgUserIds.Add((int)partnerOrganisation.LeadPolicySponsorUserID);
            if (partnerOrganisation.ReportAuthorUserID != null) partnerOrgUserIds.Add((int)partnerOrganisation.ReportAuthorUserID);

            var risks = _unitOfWork.PartnerOrganisationRisks.Entities.Where(r => r.PartnerOrganisationID == partnerOrganisation.ID && r.EntityStatusID == (int)EntityStatuses.Open);
            partnerOrgUserIds.AddRange(risks.Where(r => r.RiskOwnerUserID != null).Select(r => (int)r.RiskOwnerUserID));

            return _repository.Entities.Where(u => u.EntityStatusID == (int)EntityStatuses.Open && partnerOrgUserIds.Contains(u.ID));
        }

        /// <summary>
        /// Users associated with a benefit. Used for reminder email distribution list.
        /// </summary>
        /// <param name="benefit"></param>
        /// <returns></returns>
        public IEnumerable<User> AuthorUsersInBenefit(Benefit benefit)
        {
            var benefitUserIds = new List<int>();
            if (benefit.LeadUserID != null) benefitUserIds.Add((int)benefit.LeadUserID);
            AddContributors(benefitUserIds, _unitOfWork.Contributors.Entities.Where(c => c.BenefitID == benefit.ID).ToList());

            return _repository.Entities.Where(u => u.EntityStatusID == (int)EntityStatuses.Open && benefitUserIds.Contains(u.ID));
        }

        /// <summary>
        /// Users associated with a metric. Used for reminder email distribution list.
        /// </summary>
        /// <param name="metric"></param>
        /// <returns></returns>
        public IEnumerable<User> AuthorUsersInMetric(Metric metric)
        {
            var metricUserIds = new List<int>();
            if (metric.LeadUserID != null) metricUserIds.Add((int)metric.LeadUserID);
            AddContributors(metricUserIds, _unitOfWork.Contributors.Entities.Where(c => c.MetricID == metric.ID).ToList());

            return _repository.Entities.Where(u => u.EntityStatusID == (int)EntityStatuses.Open && metricUserIds.Contains(u.ID));
        }

        /// <summary>
        /// Users associated with a financial risk. Used for reminder email distribution list.
        /// </summary>
        /// <param name="risk"></param>
        /// <returns></returns>
        public IEnumerable<User> AuthorUsersInFinancialRisk(FinancialRisk risk)
        {
            var riskUserIds = new List<int>();
            if (risk.RiskOwnerUserID != null) riskUserIds.Add((int)risk.RiskOwnerUserID);
            if (risk.ReportApproverUserID != null) riskUserIds.Add((int)risk.ReportApproverUserID);
            AddContributors(riskUserIds, _unitOfWork.Contributors.Entities.Where(c => c.RiskID == risk.ID).ToList());

            var actions = _unitOfWork.FinancialRiskMitigationActions.Entities.Where(a => a.RiskID == risk.ID).ToList();
            foreach (var action in actions)
            {
                if (action.OwnerUserID != null) riskUserIds.Add((int)action.OwnerUserID);
                AddContributors(riskUserIds, _unitOfWork.Contributors.Entities.Where(c => c.RiskMitigationActionID == action.ID).ToList());
            }

            return _repository.Entities.Where(u => u.EntityStatusID == (int)EntityStatuses.Open && riskUserIds.Contains(u.ID));
        }

        /// <summary>
        /// Users associated with a financial risk. Used for reminder email distribution list.
        /// </summary>
        /// <param name="risk"></param>
        /// <returns></returns>
        public IEnumerable<User> ApproverUsersInFinancialRisk(FinancialRisk risk)
        {
            var riskUserIds = new List<int>();
            if (risk.RiskOwnerUserID != null) riskUserIds.Add((int)risk.RiskOwnerUserID);
            if (risk.ReportApproverUserID != null) riskUserIds.Add((int)risk.ReportApproverUserID);
            return _repository.Entities.Where(u => u.EntityStatusID == (int)EntityStatuses.Open && riskUserIds.Contains(u.ID));
        }

        private static void AddContributors(List<int> idList, ICollection<Contributor> contributors)
        {
            idList.AddRange(contributors.Where(c => c.ContributorUserID != null).Select(c => (int)c.ContributorUserID));
        }
    }
}
