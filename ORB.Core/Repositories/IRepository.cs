using System;
using System.Threading.Tasks;

namespace ORB.Core.Repositories
{
    public interface IRepository<TEntity> where TEntity : class
    {
        Task<int> SaveChanges();
    }
}