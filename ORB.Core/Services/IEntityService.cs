using Microsoft.AspNet.OData;
using ORB.Core.Models;
using System.Linq;
using System.Threading.Tasks;

namespace ORB.Core.Services
{
    public interface IEntityService<TEntity> : IEntityAddService<TEntity> where TEntity : ObjectWithId
    {
        Task<TEntity> Edit(int id, Delta<TEntity> patch);
        Task<TEntity> Remove(TEntity entity);
    }
}