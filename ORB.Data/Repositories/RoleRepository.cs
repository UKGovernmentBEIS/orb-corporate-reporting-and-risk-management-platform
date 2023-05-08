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
    public class RoleRepository : EntityRepository<Role>, IEntityRepository<Role>
    {
        public RoleRepository(ApiPrincipal user, OrbContext context, IOptions<UserSettings> options)
        : base(user, context, options) { }

        public override IQueryable<Role> Entities
        {
            get
            {
                return OrbContext.Roles;
            }
        }

        public async Task<Role> Edit(int keyValue)
        {
            if (ApiUserIsAdmin)
            {
                return await Entities.SingleOrDefaultAsync(e => e.ID == keyValue);
            }
            return null;
        }

        public Role Add(Role role)
        {
            if (ApiUserIsAdmin)
            {
                OrbContext.Roles.Add(role);
                return role;
            }
            return null;
        }

        public Role Remove(Role role)
        {
            if (ApiUserIsAdmin)
            {
                OrbContext.Roles.Remove(role);
                return role;
            }
            return null;
        }
    }
}