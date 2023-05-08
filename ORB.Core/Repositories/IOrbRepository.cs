using ORB.Core.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ORB.Core.Repositories
{
    public interface IOrbRepository<TEntity> : IRepository<TEntity> where TEntity : ObjectWithId
    {
        IQueryable<TEntity> Entities { get; }
        TEntity Find(int id);
        User ApiUser { get; }
    }
}