using ORB.Core.Models;
using System.Threading.Tasks;

namespace ORB.Core.Repositories
{
    public interface IEntityUpdateRepository<TEntity> : IEntityAddRepository<TEntity> where TEntity : EntityUpdate { }
}