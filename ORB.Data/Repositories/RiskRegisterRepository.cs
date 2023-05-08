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
    public class RiskRegisterRepository : EntityRepository<RiskRegister>, IEntityRepository<RiskRegister>
    {
        public RiskRegisterRepository(ApiPrincipal user, OrbContext context, IOptions<UserSettings> options)
        : base(user, context, options) { }

        public override IQueryable<RiskRegister> Entities
        {
            get
            {
                return OrbContext.RiskRegisters;
            }
        }

        public async Task<RiskRegister> Edit(int keyValue)
        {
            if (ApiUserIsAdmin)
            {
                return await Entities.SingleOrDefaultAsync(e => e.ID == keyValue);
            }
            return null;
        }

        public RiskRegister Add(RiskRegister riskRegister)
        {
            if (ApiUserIsAdmin)
            {
                OrbContext.RiskRegisters.Add(riskRegister);
                return riskRegister;
            }
            return null;
        }

        public RiskRegister Remove(RiskRegister riskRegister)
        {
            if (ApiUserIsAdmin)
            {
                OrbContext.RiskRegisters.Remove(riskRegister);
                return riskRegister;
            }
            return null;
        }
    }
}