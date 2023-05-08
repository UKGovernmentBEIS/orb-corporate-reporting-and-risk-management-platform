using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using ORB.Core;
using ORB.Core.Models;
using ORB.Core.Repositories;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Principal;
using System.Threading.Tasks;

namespace ORB.Data.Repositories
{
    public class UserProjectRepository : EntityRepository<UserProject>, IUserMappingRepository<UserProject>
    {
        public UserProjectRepository(ApiPrincipal user, OrbContext context, IOptions<UserSettings> options)
        : base(user, context, options) { }

        public override IQueryable<UserProject> Entities
        {
            get
            {
                return OrbContext.UserProjects;
            }
        }

        public async Task<UserProject> Edit(int keyValue)
        {
            if (ApiUserIsAdmin)
            {
                return await Entities.SingleOrDefaultAsync(u => u.ID == keyValue);
            }
            return null;
        }

        public UserProject Add(UserProject userProject)
        {
            if (ApiUserIsAdmin)
            {
                OrbContext.UserProjects.Add(userProject);
                return userProject;
            }
            return null;
        }

        public UserProject Remove(UserProject userProject)
        {
            if (ApiUserIsAdmin)
            {
                OrbContext.UserProjects.Remove(userProject);
                return userProject;
            }
            return null;
        }

        public void RemoveRange(IEnumerable<UserProject> userProjects)
        {
            if (ApiUserIsAdmin)
            {
                OrbContext.UserProjects.RemoveRange(userProjects);
            }
        }
    }
}