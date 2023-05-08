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
    public class RagOptionRepository : OrbRepository<RagOption>, IEntityRepository<RagOption>
    {
        public RagOptionRepository(ApiPrincipal user, OrbContext context, IOptions<UserSettings> options)
        : base(user, context, options) { }

        public override IQueryable<RagOption> Entities
        {
            get
            {
                return OrbContext.RagOptions;
            }
        }

        public async Task<RagOption> Edit(int keyValue)
        {
            if (ApiUserIsAdmin)
            {
                return await Entities.SingleOrDefaultAsync(e => e.ID == keyValue);
            }
            return null;
        }

        public RagOption Add(RagOption ragOption)
        {
            if (ApiUserIsAdmin)
            {
                OrbContext.RagOptions.Add(ragOption);
                return ragOption;
            }
            return null;
        }

        public RagOption Remove(RagOption ragOption)
        {
            if (ApiUserIsAdmin)
            {
                OrbContext.RagOptions.Remove(ragOption);
                return ragOption;
            }
            return null;
        }
    }
}