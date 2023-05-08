using System.Linq;
using System.Threading.Tasks;
using ORB.Core.Models;

namespace ORB.Core.Services
{
    public interface IEntityUpdateService<TEntity> : IEntityAddService<TEntity> where TEntity : EntityUpdate { }
}