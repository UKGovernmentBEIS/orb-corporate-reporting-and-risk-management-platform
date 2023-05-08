using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using ORB.Core;
using ORB.Core.Models;
using ORB.Core.Repositories;
using System;
using System.Linq;
using System.Security.Principal;
using System.Threading.Tasks;

namespace ORB.Data.Repositories
{
    public class UserRepository : EntityRepository<User>, IUserRepository
    {
        public UserRepository(ApiPrincipal user, OrbContext context, IOptions<UserSettings> options)
        : base(user, context, options) { }

        public override IQueryable<User> Entities
        {
            get
            {
                return OrbContext.Users;
            }
        }

        public async Task<User> Edit(int keyValue)
        {
            if (ApiUserIsAdmin)
            {
                return await Entities.SingleOrDefaultAsync(u => u.ID == keyValue);
            }
            return null;
        }

        public User Add(User user)
        {
            if (ApiUserIsAdmin)
            {
                OrbContext.Users.Add(user);
                return user;
            }
            return null;
        }

        public User Remove(User user)
        {
            if (ApiUserIsAdmin)
            {
                OrbContext.Users.Remove(user);
                return user;
            }
            return null;
        }

        public string FirstRequest()
        {
            if (OrbContext.Database.CanConnect())
            {
                var user = OrbContext.Users.SingleOrDefault(u => u.Username == Username);
                if (user == null)
                {
                    return Username;
                }
                else
                {
                    if (user.EntityStatusID == (int)EntityStatuses.Closed)
                    {
                        return "db_user_disabled";
                    }
                    else
                    {
                        return "ok";
                    }
                }
            }
            else
            {
                return "db_connect_error";
            }
        }
    }
}