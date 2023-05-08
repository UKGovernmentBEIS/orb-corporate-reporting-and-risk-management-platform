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
    public class FinancialRiskMitigationActionUpdateRepository
    : EntityUpdateRepository<FinancialRiskMitigationActionUpdate>, IEntityUpdateRepository<FinancialRiskMitigationActionUpdate>
    {
        public FinancialRiskMitigationActionUpdateRepository(ApiPrincipal user, OrbContext context, IOptions<UserSettings> options)
        : base(user, context, options) { }

        public override IQueryable<FinancialRiskMitigationActionUpdate> Entities
        {
            get
            {
                return from u in OrbContext.FinancialRiskMitigationActionUpdates
                       where OrbContext.UserRoles.Any(ur => ur.UserID == ApiUser.ID && ur.RoleID == (int)AdminRoles.FinancialRiskAdmin)
                       || u.FinancialRiskMitigationAction.FinancialRisk.Group.UserGroups.Any(ug => ug.UserID == ApiUser.ID)
                       || u.FinancialRiskMitigationAction.FinancialRisk.RiskOwnerUserID == ApiUser.ID
                       || u.FinancialRiskMitigationAction.FinancialRisk.ReportApproverUserID == ApiUser.ID
                       || u.FinancialRiskMitigationAction.FinancialRisk.Contributors.Any(c => c.ContributorUserID == ApiUser.ID)
                       || u.FinancialRiskMitigationAction.FinancialRiskRiskMitigationActions.SelectMany(rrma => rrma.Risk.Group.UserGroups).Any(ug => ug.UserID == ApiUser.ID)
                       || u.FinancialRiskMitigationAction.FinancialRiskRiskMitigationActions.Any(rrma => rrma.Risk.RiskOwnerUserID == ApiUser.ID)
                       || u.FinancialRiskMitigationAction.FinancialRiskRiskMitigationActions.Any(rrma => rrma.Risk.ReportApproverUserID == ApiUser.ID)
                       || u.FinancialRiskMitigationAction.FinancialRiskRiskMitigationActions.SelectMany(rrma => rrma.Risk.Contributors).Any(c => c.ContributorUserID == ApiUser.ID)
                       || u.FinancialRiskMitigationAction.OwnerUserID == ApiUser.ID
                       || u.FinancialRiskMitigationAction.Contributors.Any(c => c.ContributorUserID == ApiUser.ID)
                       select u;
            }
        }

        public FinancialRiskMitigationActionUpdate Add(FinancialRiskMitigationActionUpdate riskMitigationActionUpdate)
        {
            var riskAction = OrbContext.FinancialRiskMitigationActions
                .Include(a => a.FinancialRisk).ThenInclude(r => r.Contributors)
                .Include(a => a.FinancialRiskRiskMitigationActions).ThenInclude(rrma => rrma.Risk).ThenInclude(r => r.Contributors)
                .Include(a => a.Contributors)
                .SingleOrDefault(a => a.ID == riskMitigationActionUpdate.RiskMitigationActionID);

            if (riskAction != null)
            {
                if (ApiUserIsFinancialRiskManager
                    || (riskAction.FinancialRisk.OwnedByMultipleGroups != true && ApiUserFinancialRiskGroups.Contains((int)riskAction.FinancialRisk.GroupID))
                    || riskAction.OwnerUserID == ApiUser.ID
                    || riskAction.Contributors.Any(c => c.ContributorUserID == ApiUser.ID)
                    || riskAction.FinancialRisk.RiskOwnerUserID == ApiUser.ID
                    || riskAction.FinancialRisk.ReportApproverUserID == ApiUser.ID
                    || riskAction.FinancialRisk.Contributors.Any(c => c.ContributorUserID == ApiUser.ID)
                )
                {
                    OrbContext.FinancialRiskMitigationActionUpdates.Add(riskMitigationActionUpdate);
                    return riskMitigationActionUpdate;
                }
                
                foreach (var rrma in riskAction.FinancialRiskRiskMitigationActions)
                {
                    if ((rrma.Risk.OwnedByMultipleGroups != true && ApiUserFinancialRiskGroups.Contains((int)rrma.Risk.GroupID))
                        || rrma.Risk.RiskOwnerUserID == ApiUser.ID
                        || rrma.Risk.ReportApproverUserID == ApiUser.ID
                        || rrma.Risk.Contributors.Any(c => c.ContributorUserID == ApiUser.ID)
                    )
                    {
                        OrbContext.FinancialRiskMitigationActionUpdates.Add(riskMitigationActionUpdate);
                        return riskMitigationActionUpdate;
                    }
                }
            }
            return null;
        }
    }
}