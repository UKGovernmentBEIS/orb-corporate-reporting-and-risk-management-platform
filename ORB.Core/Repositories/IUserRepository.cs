using System.Linq;
using ORB.Core.Models;

namespace ORB.Core.Repositories
{
    public interface IUserRepository : IEntityRepository<User>
    {
        string FirstRequest();
    }
}