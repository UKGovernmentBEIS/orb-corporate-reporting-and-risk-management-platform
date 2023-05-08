using System.Collections.Generic;
using ORB.Core.Models;

namespace ORB.Core.Repositories
{
    public interface IUserMappingRepository<TEntity> : IEntityRepository<TEntity> where TEntity : Entity
    {
        void RemoveRange(IEnumerable<TEntity> userMappings);
    }
}