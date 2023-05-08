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
    public class ProjectUpdateRepository : EntityUpdateRepository<ProjectUpdate>, IEntityUpdateRepository<ProjectUpdate>
    {
        public ProjectUpdateRepository(ApiPrincipal user, OrbContext context, IOptions<UserSettings> options)
        : base(user, context, options) { }

        public override IQueryable<ProjectUpdate> Entities
        {
            get
            {
                if (ApiUserIsAdmin)
                {
                    // Departmental Reporting Admins can see all Project Updates
                    return OrbContext.ProjectUpdates;
                }
                else
                {
                    return from pu in OrbContext.ProjectUpdates
                           where pu.Project.UserProjects.Any(up => up.User.Username == Username)
                           select pu;
                }
            }
        }

        public ProjectUpdate Add(ProjectUpdate projectUpdate)
        {
            var project = OrbContext.Projects.Include(p => p.Contributors).SingleOrDefault(p => p.ID == projectUpdate.ProjectID);
            if (project != null && (
                ApiUserIsAdmin
                || ApiUserAdminProjects.Contains(project.ID)
                || ApiUser.ID == project.SeniorResponsibleOwnerUserID
                || ApiUser.ID == project.ReportApproverUserID
                || ApiUser.ID == project.ProjectManagerUserID
                || ApiUser.ID == project.ReportingLeadUserID
                || project.Contributors.Any(c => c.ContributorUserID == ApiUser.ID)
                ))
            {
                OrbContext.ProjectUpdates.Add(projectUpdate);
                return projectUpdate;
            }
            return null;
        }
    }
}