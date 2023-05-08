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
    public class AttributeTypeRepository : EntityRepository<AttributeType>, IEntityRepository<AttributeType>
    {
        public AttributeTypeRepository(ApiPrincipal user, OrbContext context, IOptions<UserSettings> options)
        : base(user, context, options) { }

        public override IQueryable<AttributeType> Entities
        {
            get
            {
                return OrbContext.AttributeTypes;
            }
        }

        public async Task<AttributeType> Edit(int keyValue)
        {
            if (ApiUserIsAdmin)
            {
                return await Entities.SingleOrDefaultAsync(m => m.ID == keyValue);
            }
            return null;
        }

        public AttributeType Add(AttributeType attributeType)
        {
            if (ApiUserIsAdmin)
            {
                OrbContext.AttributeTypes.Add(attributeType);
                return attributeType;
            }
            return null;
        }

        public AttributeType Remove(AttributeType attributeType)
        {
            if (ApiUserIsAdmin)
            {
                OrbContext.AttributeTypes.Remove(attributeType);
                return attributeType;
            }
            return null;
        }
    }
}