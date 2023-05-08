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
    public class UserGroupRepository : EntityRepository<UserGroup>, IUserMappingRepository<UserGroup>
    {
        public UserGroupRepository(ApiPrincipal user, OrbContext context, IOptions<UserSettings> options)
        : base(user, context, options) { }

        public override IQueryable<UserGroup> Entities
        {
            get
            {
                return OrbContext.UserGroups;
            }
        }

        public async Task<UserGroup> Edit(int keyValue)
        {
            if (ApiUserIsAdmin)
            {
                return await Entities.SingleOrDefaultAsync(u => u.ID == keyValue);
            }
            return null;
        }

        public UserGroup Add(UserGroup userGroup)
        {
            if (ApiUserIsAdmin)
            {
                OrbContext.UserGroups.Add(userGroup);
                return userGroup;
            }
            return null;
        }

        public UserGroup Remove(UserGroup userGroup)
        {
            if (ApiUserIsAdmin)
            {
                OrbContext.UserGroups.Remove(userGroup);
                return userGroup;
            }
            return null;
        }

        public void RemoveRange(IEnumerable<UserGroup> userGroups)
        {
            if (ApiUserIsAdmin)
            {
                OrbContext.UserGroups.RemoveRange(userGroups);
            }
        }
    }
}