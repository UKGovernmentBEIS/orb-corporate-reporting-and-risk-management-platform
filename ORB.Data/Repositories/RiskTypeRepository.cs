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
    public class RiskTypeRepository : EntityRepository<RiskType>, IEntityRepository<RiskType>
    {
        public RiskTypeRepository(ApiPrincipal user, OrbContext context, IOptions<UserSettings> options)
        : base(user, context, options) { }

        public override IQueryable<RiskType> Entities
        {
            get
            {
                return OrbContext.RiskTypes;
            }
        }

        public async Task<RiskType> Edit(int keyValue)
        {
            if (ApiUserIsAdmin)
            {
                return await Entities.SingleOrDefaultAsync(e => e.ID == keyValue);
            }
            return null;
        }

        public RiskType Add(RiskType riskType)
        {
            if (ApiUserIsAdmin)
            {
                OrbContext.RiskTypes.Add(riskType);
                return riskType;
            }
            return null;
        }

        public RiskType Remove(RiskType riskType)
        {
            if (ApiUserIsAdmin)
            {
                OrbContext.RiskTypes.Remove(riskType);
                return riskType;
            }
            return null;
        }
    }
}