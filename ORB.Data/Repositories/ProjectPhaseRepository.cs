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
    public class ProjectPhaseRepository : EntityRepository<ProjectPhase>, IEntityRepository<ProjectPhase>
    {
        public ProjectPhaseRepository(ApiPrincipal user, OrbContext context, IOptions<UserSettings> options)
        : base(user, context, options) { }

        public override IQueryable<ProjectPhase> Entities
        {
            get
            {
                return OrbContext.ProjectPhases;
            }
        }

        public async Task<ProjectPhase> Edit(int keyValue)
        {
            if (ApiUserIsAdmin)
            {
                return await Entities.SingleOrDefaultAsync(e => e.ID == keyValue);
            }
            return null;
        }

        public ProjectPhase Add(ProjectPhase projectPhase)
        {
            if (ApiUserIsAdmin)
            {
                OrbContext.ProjectPhases.Add(projectPhase);
                return projectPhase;
            }
            return null;
        }

        public ProjectPhase Remove(ProjectPhase projectPhase)
        {
            if (ApiUserIsAdmin)
            {
                OrbContext.ProjectPhases.Remove(projectPhase);
                return projectPhase;
            }
            return null;
        }
    }
}