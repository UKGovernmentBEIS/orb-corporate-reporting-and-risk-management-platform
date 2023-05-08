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
    public class UserPartnerOrganisationRepository : EntityRepository<UserPartnerOrganisation>, IUserMappingRepository<UserPartnerOrganisation>
    {
        public UserPartnerOrganisationRepository(ApiPrincipal user, OrbContext context, IOptions<UserSettings> options)
        : base(user, context, options) { }

        public override IQueryable<UserPartnerOrganisation> Entities
        {
            get
            {
                return OrbContext.UserPartnerOrganisations;
            }
        }

        public async Task<UserPartnerOrganisation> Edit(int keyValue)
        {
            if (ApiUserIsAdmin)
            {
                return await Entities.SingleOrDefaultAsync(u => u.ID == keyValue);
            }
            return null;
        }

        public UserPartnerOrganisation Add(UserPartnerOrganisation userPartnerOrganisation)
        {
            if (ApiUserIsAdmin)
            {
                OrbContext.UserPartnerOrganisations.Add(userPartnerOrganisation);
                return userPartnerOrganisation;
            }
            return null;
        }

        public UserPartnerOrganisation Remove(UserPartnerOrganisation userPartnerOrganisation)
        {
            if (ApiUserIsAdmin)
            {
                OrbContext.UserPartnerOrganisations.Remove(userPartnerOrganisation);
                return userPartnerOrganisation;
            }
            return null;
        }

        public void RemoveRange(IEnumerable<UserPartnerOrganisation> userPartnerOrganisations)
        {
            if (ApiUserIsAdmin)
            {
                OrbContext.UserPartnerOrganisations.RemoveRange(userPartnerOrganisations);
            }
        }
    }
}