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
    public class ThresholdRepository : EntityRepository<Threshold>, IEntityRepository<Threshold>
    {
        public ThresholdRepository(ApiPrincipal user, OrbContext context, IOptions<UserSettings> options)
        : base(user, context, options) { }

        public override IQueryable<Threshold> Entities
        {
            get
            {
                return OrbContext.Thresholds;
            }
        }

        public async Task<Threshold> Edit(int keyValue)
        {
            if (ApiUserIsAdmin)
            {
                return await Entities.SingleOrDefaultAsync(e => e.ID == keyValue);
            }
            return null;
        }

        public Threshold Add(Threshold threshold)
        {
            if (ApiUserIsAdmin)
            {
                OrbContext.Thresholds.Add(threshold);
                return threshold;
            }
            return null;
        }

        public Threshold Remove(Threshold threshold)
        {
            if (ApiUserIsAdmin)
            {
                OrbContext.Thresholds.Remove(threshold);
                return threshold;
            }
            return null;
        }
    }
}