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
    public class ThresholdAppetiteRepository : OrbRepository<ThresholdAppetite>, IThresholdAppetiteRepository
    {
        public ThresholdAppetiteRepository(ApiPrincipal user, OrbContext context, IOptions<UserSettings> options)
        : base(user, context, options) { }

        public override IQueryable<ThresholdAppetite> Entities
        {
            get
            {
                return OrbContext.ThresholdAppetites;
            }
        }

        public async Task<ThresholdAppetite> Edit(int keyValue)
        {
            if (ApiUserIsAdmin)
            {
                return await Entities.SingleOrDefaultAsync(u => u.ID == keyValue);
            }
            return null;
        }

        public ThresholdAppetite Add(ThresholdAppetite thresholdAppetite)
        {
            if (ApiUserIsAdmin)
            {
                OrbContext.ThresholdAppetites.Add(thresholdAppetite);
                return thresholdAppetite;
            }
            return null;
        }

        public ThresholdAppetite Remove(ThresholdAppetite thresholdAppetite)
        {
            if (ApiUserIsAdmin)
            {
                OrbContext.ThresholdAppetites.Remove(thresholdAppetite);
                return thresholdAppetite;
            }
            return null;
        }

        public void RemoveRange(IEnumerable<ThresholdAppetite> thresholdAppetites)
        {
            OrbContext.ThresholdAppetites.RemoveRange(thresholdAppetites);
        }
    }
}

