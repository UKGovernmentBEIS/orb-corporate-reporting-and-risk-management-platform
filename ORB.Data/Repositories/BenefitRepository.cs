using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using ORB.Core;
using ORB.Core.Models;
using ORB.Core.Repositories;
using System.Linq;
using System.Security.Principal;
using System.Threading.Tasks;

namespace ORB.Data.Repositories
{
    public class BenefitRepository : EntityRepository<Benefit>, IEntityRepository<Benefit>
    {
        public BenefitRepository(ApiPrincipal user, OrbContext context, IOptions<UserSettings> options)
        : base(user, context, options) { }

        public override IQueryable<Benefit> Entities
        {
            get
            {
                if (ApiUserIsAdmin)
                {
                    // Departmental Reporting Admins can see all Benefits
                    return OrbContext.Benefits;
                }
                else
                {
                    return from b in OrbContext.Benefits
                           from up in b.Project.UserProjects
                           where up.User.Username == Username
                           select b;
                }
            }
        }

        public async Task<Benefit> Edit(int keyValue)
        {
            var benefit = await Entities.Include(b => b.Project).SingleOrDefaultAsync(b => b.ID == keyValue);

            if (ApiUserIsAdmin || (benefit != null && (
                ApiUserAdminProjects.Contains(benefit.ProjectID)
                || benefit.Project.SeniorResponsibleOwnerUserID == ApiUser.ID
                || benefit.Project.ReportApproverUserID == ApiUser.ID
            )))
            {
                return benefit;
            }
            return null;
        }

        public Benefit Add(Benefit benefit)
        {
            if (ApiUserIsAdmin || ApiUserAdminProjects.Contains(benefit.ProjectID))
            {
                OrbContext.Benefits.Add(benefit);
                return benefit;
            }
            return null;
        }

        public Benefit Remove(Benefit benefit)
        {
            if (ApiUserIsAdmin || ApiUserAdminProjects.Contains(benefit.ProjectID))
            {
                OrbContext.Benefits.Remove(benefit);
                return benefit;
            }
            return null;
        }
    }
}