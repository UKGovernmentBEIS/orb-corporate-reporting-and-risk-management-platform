using ORB.Core.Models;
using System.Linq;
using System.Threading.Tasks;

namespace ORB.Core.Services
{
    public interface IEntityReadService<out TEntity> where TEntity : ObjectWithId
    {
        IQueryable<TEntity> Entities { get; }
        IQueryable<TEntity> Find(int id);
    }

}