using ORB.Core.Models;
using System.Threading.Tasks;

namespace ORB.Core.Repositories
{
    public interface IEntityRepository<TEntity> : IEntityAddRepository<TEntity> where TEntity : ObjectWithId
    {
        Task<TEntity> Edit(int keyValue);
        TEntity Remove(TEntity entity);
    }
}