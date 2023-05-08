using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using ORB.Core;
using ORB.Core.Models;
using ORB.Core.Repositories;
using System.Linq;
using System.Security.Principal;
using System.Threading.Tasks;

namespace ORB.Data.Repositories
{
    public class DepartmentalObjectiveRepository : EntityRepository<DepartmentalObjective>, IEntityRepository<DepartmentalObjective>
    {
        public DepartmentalObjectiveRepository(ApiPrincipal user, OrbContext context, IOptions<UserSettings> options)
        : base(user, context, options) { }

        public override IQueryable<DepartmentalObjective> Entities
        {
            get
            {
                return OrbContext.DepartmentalObjectives;
            }
        }

        public async Task<DepartmentalObjective> Edit(int keyValue)
        {
            if (ApiUserIsAdmin)
            {
                return await Entities.SingleOrDefaultAsync(m => m.ID == keyValue);
            }
            return null;
        }

        public DepartmentalObjective Add(DepartmentalObjective objective)
        {
            if (ApiUserIsAdmin)
            {
                OrbContext.DepartmentalObjectives.Add(objective);
                return objective;
            }
            return null;
        }

        public DepartmentalObjective Remove(DepartmentalObjective objective)
        {
            if (ApiUserIsAdmin)
            {
                OrbContext.DepartmentalObjectives.Remove(objective);
                return objective;
            }
            return null;
        }
    }
}