using System.Collections.Generic;
using models = ORB.Core.Models;

namespace ORB.Core.Repositories
{
    public interface IAttributeRepository : IEntityRepository<models.Attribute>
    {
        void RemoveRange(IEnumerable<models.Attribute> attributes);
    }
}