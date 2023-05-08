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
    public class BenefitUpdateRepository : EntityUpdateRepository<BenefitUpdate>, IEntityUpdateRepository<BenefitUpdate>
    {
        public BenefitUpdateRepository(ApiPrincipal user, OrbContext context, IOptions<UserSettings> options) 
        : base(user, context, options) { }

        public override IQueryable<BenefitUpdate> Entities
        {
            get
            {
                var userId = ApiUser.ID;
                return (from b in OrbContext.BenefitUpdates
                        join up in OrbContext.UserProjects on b.Benefit.ProjectID equals up.ProjectID into ups
                        from up in ups.DefaultIfEmpty()
                        join c in OrbContext.Contributors on b.BenefitID equals c.BenefitID into cs
                        from c in cs.DefaultIfEmpty()
                        from ur in OrbContext.UserRoles
                        where up.UserID == userId || c.ContributorUserID == userId || (ur.RoleID == (int)AdminRoles.SystemAdmin && ur.UserID == userId)
                        select b).Distinct();
            }
        }

        public BenefitUpdate Add(BenefitUpdate benefitUpdate)
        {
            var userId = ApiUser.ID;

            var benefit = OrbContext.Benefits.Include(b => b.Contributors).Include(b => b.Project).SingleOrDefault(b => b.ID == benefitUpdate.BenefitID);
            if (benefit != null && (ApiUserIsAdmin
                || ApiUserAdminProjects.Contains(benefit.ProjectID)
                || benefit.Contributors.Select(c => c.ContributorUserID).Contains(userId)
                || userId == benefit.Project.SeniorResponsibleOwnerUserID
                || userId == benefit.Project.ReportApproverUserID
                || userId == benefit.LeadUserID))
            {
                OrbContext.BenefitUpdates.Add(benefitUpdate);
                return benefitUpdate;
            }
            return null;
        }
    }
}