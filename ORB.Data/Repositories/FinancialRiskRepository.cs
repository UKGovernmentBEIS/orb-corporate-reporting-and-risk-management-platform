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
    public class FinancialRiskRepository : EntityRepository<FinancialRisk>, IEntityRepository<FinancialRisk>
    {
        public FinancialRiskRepository(ApiPrincipal user, OrbContext context, IOptions<UserSettings> options)
        : base(user, context, options) { }

        public override IQueryable<FinancialRisk> Entities
        {
            get
            {
                return (
                    from fr in OrbContext.FinancialRisks
                    where ApiUserIsClientService
                        || OrbContext.UserRoles.Any(ur => ur.UserID == ApiUser.ID && ur.RoleID == (int)AdminRoles.FinancialRiskAdmin)
                        || fr.Group.FinancialRiskUserGroups.Any(ug => ug.UserID == ApiUser.ID)
                        || fr.RiskOwnerUserID == ApiUser.ID
                        || fr.ReportApproverUserID == ApiUser.ID
                        || fr.Contributors.Any(c => c.ContributorUserID == ApiUser.ID)
                    select fr
                );
            }
        }

        public async Task<FinancialRisk> Edit(int keyValue)
        {
            return await Entities.Include(r => r.Directorate).ThenInclude(d => d.Group).SingleOrDefaultAsync(p => p.ID == keyValue);
        }

        public FinancialRisk Add(FinancialRisk risk)
        {
            if (ApiUserIsFinancialRiskManager || (risk.OwnedByMultipleGroups != true && ApiUserFinancialRiskGroups.Contains((int)risk.GroupID)))
            {
                OrbContext.FinancialRisks.Add(risk);
                return risk;
            }
            return null;
        }

        public FinancialRisk Remove(FinancialRisk risk)
        {
            if (ApiUserIsFinancialRiskManager || (risk.OwnedByMultipleGroups != true && ApiUserFinancialRiskGroups.Contains((int)risk.GroupID)))
            {
                OrbContext.FinancialRisks.Remove(risk);
                return risk;
            }
            return null;
        }
    }
}