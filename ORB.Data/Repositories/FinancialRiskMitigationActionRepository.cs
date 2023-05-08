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
    public class FinancialRiskMitigationActionRepository : EntityRepository<FinancialRiskMitigationAction>, IEntityRepository<FinancialRiskMitigationAction>
    {
        public FinancialRiskMitigationActionRepository(ApiPrincipal user, OrbContext context, IOptions<UserSettings> options)
        : base(user, context, options) { }

        public override IQueryable<FinancialRiskMitigationAction> Entities
        {
            get
            {
                return from a in OrbContext.FinancialRiskMitigationActions
                       where ApiUserIsClientService
                        || OrbContext.UserRoles.Any(ur => ur.UserID == ApiUser.ID && ur.RoleID == (int)AdminRoles.FinancialRiskAdmin)
                        || a.FinancialRisk.Group.FinancialRiskUserGroups.Any(ug => ug.UserID == ApiUser.ID)
                        || a.FinancialRisk.RiskOwnerUserID == ApiUser.ID
                        || a.FinancialRisk.ReportApproverUserID == ApiUser.ID
                        || a.FinancialRisk.Contributors.Any(c => c.ContributorUserID == ApiUser.ID)
                        || a.FinancialRiskRiskMitigationActions.SelectMany(rrma => rrma.Risk.Group.FinancialRiskUserGroups).Any(ug => ug.UserID == ApiUser.ID)
                        || a.FinancialRiskRiskMitigationActions.Any(rrma => rrma.Risk.RiskOwnerUserID == ApiUser.ID)
                        || a.FinancialRiskRiskMitigationActions.Any(rrma => rrma.Risk.ReportApproverUserID == ApiUser.ID)
                        || a.FinancialRiskRiskMitigationActions.SelectMany(rrma => rrma.Risk.Contributors).Any(c => c.ContributorUserID == ApiUser.ID)
                        || a.OwnerUserID == ApiUser.ID
                        || a.Contributors.Any(c => c.ContributorUserID == ApiUser.ID)
                       select a;
            }
        }

        public async Task<FinancialRiskMitigationAction> Edit(int keyValue)
        {
            return await Entities
                .Include(a => a.FinancialRisk).ThenInclude(r => r.Directorate)
                .Include(a => a.FinancialRiskRiskMitigationActions).ThenInclude(rrma => rrma.Risk).ThenInclude(r => r.Directorate)
                .SingleOrDefaultAsync(p => p.ID == keyValue);
        }

        public FinancialRiskMitigationAction Add(FinancialRiskMitigationAction riskMitigationAction)
        {
            var risk = OrbContext.FinancialRisks.Find(riskMitigationAction.RiskID);
            if (ApiUserIsFinancialRiskManager || (risk != null && risk.OwnedByMultipleGroups != true && ApiUserFinancialRiskGroups.Contains((int)risk.GroupID)))
            {
                OrbContext.FinancialRiskMitigationActions.Add(riskMitigationAction);
                return riskMitigationAction;
            }
            return null;
        }

        public FinancialRiskMitigationAction Remove(FinancialRiskMitigationAction riskMitigationAction)
        {
            var risk = OrbContext.FinancialRisks.Find(riskMitigationAction.RiskID);
            if (ApiUserIsFinancialRiskManager || (risk != null && risk.OwnedByMultipleGroups != true && ApiUserFinancialRiskGroups.Contains((int)risk.GroupID)))
            {
                OrbContext.FinancialRiskMitigationActions.Remove(riskMitigationAction);
                return riskMitigationAction;
            }
            return null;
        }
    }
}