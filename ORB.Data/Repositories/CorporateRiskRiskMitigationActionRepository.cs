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
    public class CorporateRiskRiskMitigationActionRepository : EntityRepository<CorporateRiskRiskMitigationAction>, IRiskRiskMitigationActionRepository<CorporateRiskRiskMitigationAction>
    {
        public CorporateRiskRiskMitigationActionRepository(ApiPrincipal user, OrbContext context, IOptions<UserSettings> options)
        : base(user, context, options) { }

        public override IQueryable<CorporateRiskRiskMitigationAction> Entities
        {
            get
            {
                return OrbContext.CorporateRiskRiskMitigationActions;
            }
        }

        public async Task<CorporateRiskRiskMitigationAction> Edit(int keyValue)
        {
            return await Entities.SingleOrDefaultAsync(e => e.ID == keyValue);
        }

        public CorporateRiskRiskMitigationAction Add(CorporateRiskRiskMitigationAction corporateRiskRiskMitigationAction)
        {
            if (ApiUserIsDepartmentRiskManager)
            {
                OrbContext.CorporateRiskRiskMitigationActions.Add(corporateRiskRiskMitigationAction);
                return corporateRiskRiskMitigationAction;
            }

            OrbContext.CorporateRiskRiskMitigationActions.Add(corporateRiskRiskMitigationAction);
            return corporateRiskRiskMitigationAction;
        }

        public CorporateRiskRiskMitigationAction Remove(CorporateRiskRiskMitigationAction corporateRiskRiskMitigationAction)
        {
            if (ApiUserIsDepartmentRiskManager)
            {
                OrbContext.CorporateRiskRiskMitigationActions.Remove(corporateRiskRiskMitigationAction);
                return corporateRiskRiskMitigationAction;
            }

            OrbContext.CorporateRiskRiskMitigationActions.Remove(corporateRiskRiskMitigationAction);
            return corporateRiskRiskMitigationAction;
        }

        public void RemoveRange(IEnumerable<CorporateRiskRiskMitigationAction> corporateRiskRiskMitigationActions)
        {
            OrbContext.CorporateRiskRiskMitigationActions.RemoveRange(corporateRiskRiskMitigationActions);
        }
    }
}