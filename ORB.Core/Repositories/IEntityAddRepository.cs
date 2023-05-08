using ORB.Core.Models;
using System.Threading.Tasks;

namespace ORB.Core.Repositories
{
    public interface IEntityAddRepository<TEntity> : IOrbRepository<TEntity> where TEntity : ObjectWithId
    {
        TEntity Add(TEntity entity);
    }
}