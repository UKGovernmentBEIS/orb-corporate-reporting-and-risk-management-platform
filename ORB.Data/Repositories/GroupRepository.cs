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
    public class GroupRepository : EntityRepository<Group>, IEntityRepository<Group>
    {
        public GroupRepository(ApiPrincipal user, OrbContext context, IOptions<UserSettings> options)
        : base(user, context, options) { }

        public override IQueryable<Group> Entities
        {
            get
            {
                return OrbContext.Groups;
            }
        }

        public async Task<Group> Edit(int keyValue)
        {
            var group = await Entities.SingleOrDefaultAsync(m => m.ID == keyValue);

            if (ApiUserIsAdmin || (group != null && ApiUserAdminGroups.Contains(group.ID)))
            {
                return group;
            }
            return null;
        }

        public Group Add(Group group)
        {
            if (ApiUserIsAdmin)
            {
                OrbContext.Groups.Add(group);
                return group;
            }
            return null;
        }

        public Group Remove(Group group)
        {
            if (ApiUserIsAdmin)
            {
                OrbContext.Groups.Remove(group);
                return group;
            }
            return null;
        }
    }
}