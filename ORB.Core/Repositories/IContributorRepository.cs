using System.Collections.Generic;
using ORB.Core.Models;

namespace ORB.Core.Repositories
{
    public interface IContributorRepository : IEntityRepository<Contributor>
    {
        void RemoveRange(IEnumerable<Contributor> contributors);
    }
}