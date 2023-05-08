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
    public class DependencyRepository : EntityRepository<Dependency>, IEntityRepository<Dependency>
    {
        public DependencyRepository(ApiPrincipal user, OrbContext context, IOptions<UserSettings> options)
        : base(user, context, options) { }

        public override IQueryable<Dependency> Entities
        {
            get
            {
                if (ApiUserIsAdmin)
                {
                    // Departmental Reporting Admins can see all Dependencies
                    return OrbContext.Dependencies;
                }
                else
                {
                    return from d in OrbContext.Dependencies
                           from up in d.Project.UserProjects
                           where up.User.Username == Username
                           select d;
                }
            }
        }

        public async Task<Dependency> Edit(int keyValue)
        {
            var dependency = await Entities.Include(d => d.Project).SingleOrDefaultAsync(m => m.ID == keyValue);

            if (ApiUserIsAdmin || (dependency != null && (
                ApiUserAdminProjects.Contains(dependency.ProjectID)
                || dependency.Project.SeniorResponsibleOwnerUserID == ApiUser.ID
                || dependency.Project.ReportApproverUserID == ApiUser.ID
                )))
            {
                return dependency;
            }
            return null;
        }

        public Dependency Add(Dependency dependency)
        {
            if (ApiUserIsAdmin || ApiUserAdminProjects.Contains(dependency.ProjectID))
            {
                OrbContext.Dependencies.Add(dependency);
                return dependency;
            }
            return null;
        }

        public Dependency Remove(Dependency dependency)
        {
            if (ApiUserIsAdmin || ApiUserAdminProjects.Contains(dependency.ProjectID))
            {
                OrbContext.Dependencies.Remove(dependency);
                return dependency;
            }
            return null;
        }
    }
}