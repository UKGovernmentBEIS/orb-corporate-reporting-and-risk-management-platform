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
    public class ReportStagingRepository : EntityUpdateRepository<ReportStaging>, IReportStagingRepository
    {
        public ReportStagingRepository(ApiPrincipal user, OrbContext context, IOptions<UserSettings> options)
        : base(user, context, options) { }

        public override IQueryable<ReportStaging> Entities
        {
            get
            {
                if (ApiUserIsAdmin)
                {
                    return OrbContext.ReportStagings;
                }

                return from up in OrbContext.UserProjects
                       where up.IsAdmin && up.User.Username == Username
                       from rs in up.Project.ReportStagings
                       select rs;
            }
        }

        public ReportStaging Add(ReportStaging report)
        {
            if (ApiUserIsAdmin || ApiUserAdminProjects.Contains(report.ProjectID))
            {
                OrbContext.ReportStagings.Add(report);
                return report;
            }

            return null;
        }
    }
}