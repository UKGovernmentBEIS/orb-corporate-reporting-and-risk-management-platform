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
    public class WorkStreamRepository : EntityRepository<WorkStream>, IEntityRepository<WorkStream>
    {
        public WorkStreamRepository(ApiPrincipal user, OrbContext context, IOptions<UserSettings> options)
        : base(user, context, options) { }

        public override IQueryable<WorkStream> Entities
        {
            get
            {
                if (ApiUserIsAdmin)
                {
                    // Departmental Reporting Admins can see all WorkStreams
                    return OrbContext.WorkStreams;
                }
                else
                {
                    return from w in OrbContext.WorkStreams
                           from up in w.Project.UserProjects
                           where up.User.Username == Username
                           select w;
                }
            }
        }

        public async Task<WorkStream> Edit(int keyValue)
        {
            var workStream = await Entities.Include(w => w.Project).SingleOrDefaultAsync(w => w.ID == keyValue);

            if (ApiUserIsAdmin || (workStream != null && (
                ApiUserAdminProjects.Contains(workStream.ProjectID)
                || workStream.Project.SeniorResponsibleOwnerUserID == ApiUser.ID
                || workStream.Project.ReportApproverUserID == ApiUser.ID
                )))
            {
                return workStream;
            }
            return null;
        }

        public WorkStream Add(WorkStream workStream)
        {
            if (ApiUserIsAdmin || ApiUserAdminProjects.Contains(workStream.ProjectID))
            {
                OrbContext.WorkStreams.Add(workStream);
                return workStream;
            }
            return null;
        }

        public WorkStream Remove(WorkStream workStream)
        {
            if (ApiUserIsAdmin || ApiUserAdminProjects.Contains(workStream.ProjectID))
            {
                OrbContext.WorkStreams.Remove(workStream);
                return workStream;
            }
            return null;
        }
    }
}