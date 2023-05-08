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
    public class FinancialRiskUpdateRepository : EntityUpdateRepository<FinancialRiskUpdate>, IEntityUpdateRepository<FinancialRiskUpdate>
    {
        public FinancialRiskUpdateRepository(ApiPrincipal user, OrbContext context, IOptions<UserSettings> options)
        : base(user, context, options) { }

        public override IQueryable<FinancialRiskUpdate> Entities
        {
            get
            {
                return from u in OrbContext.FinancialRiskUpdates
                       where OrbContext.UserRoles.Any(ur => ur.UserID == ApiUser.ID && ur.RoleID == (int)AdminRoles.FinancialRiskAdmin)
                           || u.FinancialRisk.Group.FinancialRiskUserGroups.Any(ug => ug.UserID == ApiUser.ID)
                           || u.FinancialRisk.RiskOwnerUserID == ApiUser.ID
                           || u.FinancialRisk.ReportApproverUserID == ApiUser.ID
                           || u.FinancialRisk.Contributors.Any(c => c.ContributorUserID == ApiUser.ID)
                       select u;
            }
        }

        public FinancialRiskUpdate Add(FinancialRiskUpdate riskUpdate)
        {
            var risk = OrbContext.FinancialRisks.Include(r => r.Contributors).SingleOrDefault(r => r.ID == riskUpdate.RiskID);
            if (risk != null)
            {
                if (ApiUserIsFinancialRiskManager
                || (risk.OwnedByMultipleGroups != true && ApiUserFinancialRiskGroups.Contains((int)risk.GroupID))
                || risk.RiskOwnerUserID == ApiUser.ID
                || risk.ReportApproverUserID == ApiUser.ID
                || risk.Contributors.Any(c => c.ContributorUserID == ApiUser.ID))
                {
                    OrbContext.FinancialRiskUpdates.Add(riskUpdate);
                    return riskUpdate;
                }
            }

            return null;
        }
    }
}