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
    public class RiskProbabilityRepository : EntityRepository<RiskProbability>, IEntityRepository<RiskProbability>
    {
        public RiskProbabilityRepository(ApiPrincipal user, OrbContext context, IOptions<UserSettings> options)
        : base(user, context, options) { }

        public override IQueryable<RiskProbability> Entities
        {
            get
            {
                return OrbContext.RiskProbabilities;
            }
        }

        public async Task<RiskProbability> Edit(int keyValue)
        {
            if (ApiUserIsAdmin)
            {
                return await Entities.SingleOrDefaultAsync(e => e.ID == keyValue);
            }
            return null;
        }

        public RiskProbability Add(RiskProbability risk)
        {
            if (ApiUserIsAdmin)
            {
                OrbContext.RiskProbabilities.Add(risk);
                return risk;
            }
            return null;
        }

        public RiskProbability Remove(RiskProbability risk)
        {
            if (ApiUserIsAdmin)
            {
                OrbContext.RiskProbabilities.Remove(risk);
                return risk;
            }
            return null;
        }
    }
}