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
    public class BenefitTypeRepository : EntityRepository<BenefitType>, IEntityRepository<BenefitType>
    {
        public BenefitTypeRepository(ApiPrincipal user, OrbContext context, IOptions<UserSettings> options)
        : base(user, context, options) { }

        public override IQueryable<BenefitType> Entities
        {
            get
            {
                return OrbContext.BenefitTypes;
            }
        }

        public async Task<BenefitType> Edit(int keyValue)
        {
            if (ApiUserIsAdmin)
            {
                return await Entities.SingleOrDefaultAsync(m => m.ID == keyValue);
            }
            return null;
        }

        public BenefitType Add(BenefitType benefitTypes)
        {
            if (ApiUserIsAdmin)
            {
                OrbContext.BenefitTypes.Add(benefitTypes);
                return benefitTypes;
            }
            return null;
        }

        public BenefitType Remove(BenefitType benefitTypes)
        {
            if (ApiUserIsAdmin)
            {
                OrbContext.BenefitTypes.Remove(benefitTypes);
                return benefitTypes;
            }
            return null;
        }
    }
}