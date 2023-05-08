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
    public class MilestoneTypeRepository : EntityRepository<MilestoneType>, IEntityRepository<MilestoneType>
    {
        public MilestoneTypeRepository(ApiPrincipal user, OrbContext context, IOptions<UserSettings> options)
        : base(user, context, options) { }

        public IQueryable<MilestoneType> MilestoneTypes { get { return Entities; } }

        public override IQueryable<MilestoneType> Entities
        {
            get
            {
                return OrbContext.MilestoneTypes;
            }
        }

        public async Task<MilestoneType> Edit(int keyValue)
        {
            if (ApiUserIsAdmin)
            {
                return await MilestoneTypes.SingleOrDefaultAsync(m => m.ID == keyValue);
            }
            return null;
        }

        public MilestoneType Add(MilestoneType milestoneType)
        {
            if (ApiUserIsAdmin)
            {
                OrbContext.MilestoneTypes.Add(milestoneType);
                return milestoneType;
            }
            return null;
        }

        public MilestoneType Remove(MilestoneType milestoneType)
        {
            if (ApiUserIsAdmin)
            {
                OrbContext.MilestoneTypes.Remove(milestoneType);
                return milestoneType;
            }
            return null;
        }
    }
}