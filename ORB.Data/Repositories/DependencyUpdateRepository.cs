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
    public class DependencyUpdateRepository : EntityUpdateRepository<DependencyUpdate>, IEntityUpdateRepository<DependencyUpdate>
    {
        public DependencyUpdateRepository(ApiPrincipal user, OrbContext context, IOptions<UserSettings> options)
        : base(user, context, options) { }

        public IQueryable<DependencyUpdate> DependencyUpdates { get { return Entities; } }

        public override IQueryable<DependencyUpdate> Entities
        {
            get
            {
                if (ApiUserIsAdmin)
                {
                    // Department Reporting Admins can see all Dependency Updates
                    return OrbContext.DependencyUpdates;
                }
                else
                {
                    return (from up in OrbContext.UserProjects
                            where up.User.Username == Username
                            from d in up.Project.Dependencies
                            from du in d.DependencyUpdates
                            select du);
                }
            }
        }

        public DependencyUpdate Add(DependencyUpdate dependencyUpdate)
        {
            var userId = ApiUser.ID;

            var dependency = OrbContext.Dependencies.Include(d => d.Contributors).Include(d => d.Project).SingleOrDefault(d => d.ID == dependencyUpdate.DependencyID);
            if (dependency != null && (ApiUserIsAdmin
                || ApiUserAdminProjects.Contains(dependency.ProjectID)
                || dependency.Contributors.Select(c => c.ContributorUserID).Contains(userId)
                || userId == dependency.Project.SeniorResponsibleOwnerUserID
                || userId == dependency.Project.ReportApproverUserID
                || userId == dependency.LeadUserID))
            {
                OrbContext.DependencyUpdates.Add(dependencyUpdate);
                return dependencyUpdate;
            }
            return null;
        }
    }
}