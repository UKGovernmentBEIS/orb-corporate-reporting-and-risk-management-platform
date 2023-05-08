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
    public class WorkStreamUpdateRepository : EntityUpdateRepository<WorkStreamUpdate>, IEntityUpdateRepository<WorkStreamUpdate>
    {
        public WorkStreamUpdateRepository(ApiPrincipal user, OrbContext context, IOptions<UserSettings> options)
        : base(user, context, options) { }

        public IQueryable<WorkStreamUpdate> WorkStreamUpdates { get { return Entities; } }

        public override IQueryable<WorkStreamUpdate> Entities
        {
            get
            {
                if (ApiUserIsAdmin)
                {
                    // Departmental Reporting Admins can see all Workstream Updates
                    return OrbContext.WorkStreamUpdates;
                }
                else
                {
                    return from wu in OrbContext.WorkStreamUpdates
                           from up in wu.WorkStream.Project.UserProjects
                           where up.User.Username == Username
                           select wu;
                }
            }
        }

        public WorkStreamUpdate Add(WorkStreamUpdate workStreamUpdate)
        {
            var userId = ApiUser.ID;

            var ws = OrbContext.WorkStreams
                .Include(w => w.Contributors)
                .Include(w => w.Project)
                .SingleOrDefault(w => w.ID == workStreamUpdate.WorkStreamID);
            if (ws != null && (ApiUserIsAdmin
                || ApiUserAdminProjects.Contains(ws.ProjectID)
                || ws.Contributors.Select(c => c.ContributorUserID).Contains(userId)
                || userId == ws.Project.SeniorResponsibleOwnerUserID
                || userId == ws.Project.ReportApproverUserID
                || userId == ws.LeadUserID))
            {
                OrbContext.WorkStreamUpdates.Add(workStreamUpdate);
                return workStreamUpdate;
            }
            return null;
        }

        public WorkStreamUpdate Remove(WorkStreamUpdate workStreamUpdate)
        {
            var workStream = OrbContext.WorkStreams.Find(workStreamUpdate.WorkStreamID);
            if (ApiUserIsAdmin || ApiUserAdminProjects.Contains(workStream.ProjectID))
            {
                OrbContext.WorkStreamUpdates.Remove(workStreamUpdate);
                return workStreamUpdate;
            }
            return null;
        }
    }
}