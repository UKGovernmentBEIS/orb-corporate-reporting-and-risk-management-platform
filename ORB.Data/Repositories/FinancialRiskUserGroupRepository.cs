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
    public class FinancialRiskUserGroupRepository : EntityRepository<FinancialRiskUserGroup>, IUserMappingRepository<FinancialRiskUserGroup>
    {
        public FinancialRiskUserGroupRepository(ApiPrincipal user, OrbContext context, IOptions<UserSettings> options)
        : base(user, context, options) { }

        public override IQueryable<FinancialRiskUserGroup> Entities
        {
            get
            {
                return OrbContext.FinancialRiskUserGroups;
            }
        }

        public async Task<FinancialRiskUserGroup> Edit(int keyValue)
        {
            if (ApiUserIsFinancialRiskManager)
            {
                return await Entities.SingleOrDefaultAsync(u => u.ID == keyValue);
            }
            return null;
        }

        public FinancialRiskUserGroup Add(FinancialRiskUserGroup userGroup)
        {
            if (ApiUserIsFinancialRiskManager)
            {
                OrbContext.FinancialRiskUserGroups.Add(userGroup);
                return userGroup;
            }
            return null;
        }

        public FinancialRiskUserGroup Remove(FinancialRiskUserGroup userGroup)
        {
            if (ApiUserIsFinancialRiskManager)
            {
                OrbContext.FinancialRiskUserGroups.Remove(userGroup);
                return userGroup;
            }
            return null;
        }

        public void RemoveRange(IEnumerable<FinancialRiskUserGroup> userGroups)
        {
            if (ApiUserIsFinancialRiskManager)
            {
                OrbContext.FinancialRiskUserGroups.RemoveRange(userGroups);
            }
        }
    }
}