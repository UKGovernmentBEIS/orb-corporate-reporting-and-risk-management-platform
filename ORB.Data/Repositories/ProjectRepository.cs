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
    public class ProjectRepository : EntityRepository<Project>, IEntityRepository<Project>
    {
        public ProjectRepository(ApiPrincipal user, OrbContext context, IOptions<UserSettings> options)
        : base(user, context, options) { }

        public override IQueryable<Project> Entities
        {
            get
            {
                if (ApiUserIsAdmin)
                {
                    // Departmental Reporting Admins can see all Projects
                    return OrbContext.Projects;
                }
                else
                {
                    return from p in OrbContext.Projects
                           from up in p.UserProjects
                           where up.User.Username == Username
                           select p;
                }
            }
        }

        public async Task<Project> Edit(int keyValue)
        {
            var project = await Entities.SingleOrDefaultAsync(p => p.ID == keyValue);

            if (ApiUserIsAdmin || (project != null && ApiUserAdminProjects.Contains(project.ID)))
            {
                return project;
            }
            return null;
        }

        public Project Add(Project project)
        {
            if (ApiUserIsAdmin)
            {
                OrbContext.Projects.Add(project);
                return project;
            }
            return null;
        }

        public Project Remove(Project project)
        {
            if (ApiUserIsAdmin)
            {
                OrbContext.Projects.Remove(project);
                return project;
            }
            return null;
        }
    }
}