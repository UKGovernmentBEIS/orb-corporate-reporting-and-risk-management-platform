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
    public class UserRoleRepository : EntityRepository<UserRole>, IUserMappingRepository<UserRole>
    {
        public UserRoleRepository(ApiPrincipal user, OrbContext context, IOptions<UserSettings> options)
        : base(user, context, options) { }

        public override IQueryable<UserRole> Entities
        {
            get
            {
                if (ApiUserIsAdmin)
                {
                    return OrbContext.UserRoles;
                }
                return Enumerable.Empty<UserRole>().AsQueryable();
            }
        }

        public async Task<UserRole> Edit(int keyValue)
        {
            if (ApiUserIsAdmin)
            {
                return await Entities.SingleOrDefaultAsync(u => u.ID == keyValue);
            }
            return null;
        }

        public UserRole Add(UserRole userRole)
        {
            if (ApiUserIsAdmin)
            {
                OrbContext.UserRoles.Add(userRole);
                return userRole;
            }
            return null;
        }

        public UserRole Remove(UserRole userRole)
        {
            if (ApiUserIsAdmin)
            {
                OrbContext.UserRoles.Remove(userRole);
                return userRole;
            }
            return null;
        }

        public void RemoveRange(IEnumerable<UserRole> userRoles)
        {
            if (ApiUserIsAdmin)
            {
                OrbContext.UserRoles.RemoveRange(userRoles);
            }
        }
    }
}