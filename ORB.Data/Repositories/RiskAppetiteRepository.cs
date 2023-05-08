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
    public class RiskAppetiteRepository : EntityRepository<RiskAppetite>, IEntityRepository<RiskAppetite>
    {
        public RiskAppetiteRepository(ApiPrincipal user, OrbContext context, IOptions<UserSettings> options)
        : base(user, context, options) { }

        public override IQueryable<RiskAppetite> Entities
        {
            get
            {
                return OrbContext.RiskAppetites;
            }
        }

        public RiskAppetite Add(RiskAppetite risk)
        {
            if (ApiUserIsAdmin)
            {
                OrbContext.RiskAppetites.Add(risk);
                return risk;
            }
            return null;
        }

        public async Task<RiskAppetite> Edit(int keyValue)
        {
            if (ApiUserIsAdmin)
            {
                return await Entities.SingleOrDefaultAsync(e => e.ID == keyValue);
            }
            return null;
        }

        public RiskAppetite Remove(RiskAppetite risk)
        {
            if (ApiUserIsAdmin)
            {
                OrbContext.RiskAppetites.Remove(risk);
                return risk;
            }
            return null;
        }
    }
}