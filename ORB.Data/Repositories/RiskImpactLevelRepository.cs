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
    public class RiskImpactLevelRepository : EntityRepository<RiskImpactLevel>, IEntityRepository<RiskImpactLevel>
    {
        public RiskImpactLevelRepository(ApiPrincipal user, OrbContext context, IOptions<UserSettings> options)
        : base(user, context, options) { }

        public override IQueryable<RiskImpactLevel> Entities
        {
            get
            {
                return OrbContext.RiskImpactLevels;
            }
        }

        public RiskImpactLevel Add(RiskImpactLevel risk)
        {
            if (ApiUserIsAdmin)
            {
                OrbContext.RiskImpactLevels.Add(risk);
                return risk;
            }
            return null;
        }

        public async Task<RiskImpactLevel> Edit(int keyValue)
        {
            if (ApiUserIsAdmin)
            {
                return await Entities.SingleOrDefaultAsync(e => e.ID == keyValue);
            }
            return null;
        }

        public RiskImpactLevel Remove(RiskImpactLevel risk)
        {
            if (ApiUserIsAdmin)
            {
                OrbContext.RiskImpactLevels.Remove(risk);
                return risk;
            }
            return null;
        }
    }
}