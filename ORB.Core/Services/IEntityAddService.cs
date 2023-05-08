using Microsoft.AspNet.OData;
using ORB.Core.Models;
using System.Linq;
using System.Threading.Tasks;

namespace ORB.Core.Services
{
    public interface IEntityAddService<TEntity> : IEntityReadService<TEntity> where TEntity : ObjectWithId
    {
        Task<TEntity> Add(TEntity entity);
    }
}