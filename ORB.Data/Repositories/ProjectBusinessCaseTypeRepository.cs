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
    public class ProjectBusinessCaseTypeRepository : EntityRepository<ProjectBusinessCaseType>, IEntityRepository<ProjectBusinessCaseType>
    {
        public ProjectBusinessCaseTypeRepository(ApiPrincipal user, OrbContext context, IOptions<UserSettings> options)
        : base(user, context, options) { }

        public override IQueryable<ProjectBusinessCaseType> Entities
        {
            get
            {
                return OrbContext.ProjectBusinessCaseTypes;
            }
        }

        public async Task<ProjectBusinessCaseType> Edit(int keyValue)
        {
            if (ApiUserIsAdmin)
            {
                return await Entities.SingleOrDefaultAsync(e => e.ID == keyValue);
            }
            return null;
        }

        public ProjectBusinessCaseType Add(ProjectBusinessCaseType projectBusinessCaseType)
        {
            if (ApiUserIsAdmin)
            {
                OrbContext.ProjectBusinessCaseTypes.Add(projectBusinessCaseType);
                return projectBusinessCaseType;
            }
            return null;
        }

        public ProjectBusinessCaseType Remove(ProjectBusinessCaseType projectBusinessCaseType)
        {
            if (ApiUserIsAdmin)
            {
                OrbContext.ProjectBusinessCaseTypes.Remove(projectBusinessCaseType);
                return projectBusinessCaseType;
            }
            return null;
        }
    }
}