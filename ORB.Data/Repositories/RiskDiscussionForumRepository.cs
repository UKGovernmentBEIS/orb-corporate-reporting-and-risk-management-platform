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
    public class RiskDiscussionForumRepository : EntityRepository<RiskDiscussionForum>, IEntityRepository<RiskDiscussionForum>
    {
        public RiskDiscussionForumRepository(ApiPrincipal user, OrbContext context, IOptions<UserSettings> options)
        : base(user, context, options) { }

        public override IQueryable<RiskDiscussionForum> Entities
        {
            get
            {
                return OrbContext.RiskDiscussionForums;
            }
        }

        public async Task<RiskDiscussionForum> Edit(int keyValue)
        {
            if (ApiUserIsAdmin || ApiUserIsDepartmentRiskManager)
            {
                return await Entities.SingleOrDefaultAsync(e => e.ID == keyValue);
            }
            return null;
        }

        public RiskDiscussionForum Add(RiskDiscussionForum riskDiscussionForum)
        {
            if (ApiUserIsAdmin || ApiUserIsDepartmentRiskManager)
            {
                OrbContext.RiskDiscussionForums.Add(riskDiscussionForum);
                return riskDiscussionForum;
            }
            return null;
        }

        public RiskDiscussionForum Remove(RiskDiscussionForum riskDiscussionForum)
        {
            if (ApiUserIsAdmin || ApiUserIsDepartmentRiskManager)
            {
                OrbContext.RiskDiscussionForums.Remove(riskDiscussionForum);
                return riskDiscussionForum;
            }
            return null;
        }
    }
}