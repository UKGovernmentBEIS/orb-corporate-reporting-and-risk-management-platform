using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using ORB.Core;
using ORB.Core.Models;
using ORB.Core.Repositories;
using System;
using System.Linq;
using System.Security.Principal;
using System.Threading.Tasks;

namespace ORB.Data.Repositories
{
    public class ReportingEntityUpdateRepository : EntityUpdateRepository<CustomReportingEntityUpdate>, IEntityUpdateRepository<CustomReportingEntityUpdate>
    {
        public ReportingEntityUpdateRepository(ApiPrincipal user, OrbContext context, IOptions<UserSettings> options)
        : base(user, context, options) { }

        public override IQueryable<CustomReportingEntityUpdate> Entities
        {
            get
            {
                return from reu in OrbContext.ReportingEntityUpdates
                       where OrbContext.UserRoles.Any(ur => ur.User.Username == Username && ur.RoleID == (int)AdminRoles.SystemAdmin)
                       || (reu.ReportingEntity.PartnerOrganisationID != null && OrbContext.UserRoles.Any(ur => ur.User.Username == Username && ur.RoleID == (int)AdminRoles.PartnerOrganisationAdmin))
                       || reu.ReportingEntity.Directorate.UserDirectorates.Any(ud => ud.User.Username == Username)
                       || reu.ReportingEntity.Project.UserProjects.Any(up => up.User.Username == Username)
                       || reu.ReportingEntity.PartnerOrganisation.UserPartnerOrganisations.Any(upo => upo.User.Username == Username)
                       select reu;
            }
        }

        public CustomReportingEntityUpdate Add(CustomReportingEntityUpdate reportingEntityUpdate)
        {
            var userId = ApiUser.ID;
            var re = OrbContext.ReportingEntities
                .Include(re => re.Contributors)
                .Include(re => re.Directorate)
                .Include(re => re.Project)
                .Include(re => re.PartnerOrganisation)
                .SingleOrDefault(re => re.ID == reportingEntityUpdate.ReportingEntityID);

            if (re != null && (ApiUserIsAdmin
                || (re.DirectorateID != null && ApiUserAdminDirectorates.Contains((int)re.DirectorateID))
                || (re.ProjectID != null && ApiUserAdminProjects.Contains((int)re.ProjectID))
                || (re.PartnerOrganisationID != null && ApiUserAdminPartnerOrganisations.Contains((int)re.PartnerOrganisationID))
                || (re.Directorate != null && (userId == re.Directorate.DirectorUserID || userId == re.Directorate.ReportApproverUserID))
                || (re.Project != null && (userId == re.Project.SeniorResponsibleOwnerUserID || userId == re.Project.ReportApproverUserID))
                || (re.PartnerOrganisation != null && (userId == re.PartnerOrganisation.LeadPolicySponsorUserID || userId == re.PartnerOrganisation.ReportAuthorUserID))
                || re.Contributors.Any(c => c.ContributorUserID == userId)
                || userId == re.LeadUserID))
            {
                OrbContext.ReportingEntityUpdates.Add(reportingEntityUpdate);
                return reportingEntityUpdate;
            }

            return null;
        }
    }
}