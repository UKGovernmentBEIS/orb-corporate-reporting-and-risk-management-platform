using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using ORB.Core;
using ORB.Core.Models;
using ORB.Core.Repositories;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Principal;
using System.Threading.Tasks;

namespace ORB.Data.Repositories
{
    public class UserDirectorateRepository : EntityRepository<UserDirectorate>, IUserMappingRepository<UserDirectorate>
    {
        public UserDirectorateRepository(ApiPrincipal user, OrbContext context, IOptions<UserSettings> options)
        : base(user, context, options) { }

        public override IQueryable<UserDirectorate> Entities
        {
            get
            {
                return OrbContext.UserDirectorates;
            }
        }

        public async Task<UserDirectorate> Edit(int keyValue)
        {
            if (ApiUserIsAdmin)
            {
                return await Entities.SingleOrDefaultAsync(u => u.ID == keyValue);
            }
            return null;
        }

        public UserDirectorate Add(UserDirectorate userDirectorate)
        {
            if (ApiUserIsAdmin)
            {
                OrbContext.UserDirectorates.Add(userDirectorate);
                return userDirectorate;
            }
            return null;
        }

        public UserDirectorate Remove(UserDirectorate userDirectorate)
        {
            if (ApiUserIsAdmin)
            {
                OrbContext.UserDirectorates.Remove(userDirectorate);
                return userDirectorate;
            }
            return null;
        }

        public void RemoveRange(IEnumerable<UserDirectorate> userDirectorates)
        {
            if (ApiUserIsAdmin)
            {
                OrbContext.UserDirectorates.RemoveRange(userDirectorates);
            }
        }
    }
}