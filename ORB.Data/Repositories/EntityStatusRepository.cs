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
    public class EntityStatusRepository : EntityRepository<EntityStatus>, IEntityRepository<EntityStatus>
    {
        public EntityStatusRepository(ApiPrincipal user, OrbContext context, IOptions<UserSettings> options)
        : base(user, context, options) { }

        public IQueryable<EntityStatus> EntityStatuses { get { return Entities; } }

        public override IQueryable<EntityStatus> Entities
        {
            get
            {
                return OrbContext.EntityStatuses;
            }
        }

        public async Task<EntityStatus> Edit(int keyValue)
        {
            if (ApiUserIsAdmin)
            {
                return await Entities.SingleOrDefaultAsync(e => e.ID == keyValue);
            }
            return null;
        }

        public EntityStatus Add(EntityStatus entityStatus)
        {
            if (ApiUserIsAdmin)
            {
                OrbContext.EntityStatuses.Add(entityStatus);
                return entityStatus;
            }
            return null;
        }

        public EntityStatus Remove(EntityStatus entityStatus)
        {
            if (ApiUserIsAdmin)
            {
                OrbContext.EntityStatuses.Remove(entityStatus);
                return entityStatus;
            }
            return null;
        }
    }
}