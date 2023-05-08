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
    public class DirectorateUpdateRepository : EntityUpdateRepository<DirectorateUpdate>, IEntityUpdateRepository<DirectorateUpdate>
    {
        public DirectorateUpdateRepository(ApiPrincipal user, OrbContext context, IOptions<UserSettings> options)
        : base(user, context, options) { }

        public override IQueryable<DirectorateUpdate> Entities
        {
            get
            {
                if (ApiUserIsAdmin)
                {
                    // Departmental Reporting Admins can see all Directorate Updates
                    return OrbContext.DirectorateUpdates;
                }
                else
                {
                    return from du in OrbContext.DirectorateUpdates
                           where du.Directorate.UserDirectorates.Any(ud => ud.User.Username == Username)
                           select du;
                }
            }
        }

        public DirectorateUpdate Add(DirectorateUpdate directorateUpdate)
        {
            var directorate = OrbContext.Directorates.Include(d => d.Contributors).SingleOrDefault(d => d.ID == directorateUpdate.DirectorateID);
            if (directorate != null && (
                ApiUserIsAdmin
                || ApiUserAdminDirectorates.Contains(directorate.ID)
                || ApiUser.ID == directorate.DirectorUserID
                || ApiUser.ID == directorate.ReportApproverUserID
                || ApiUser.ID == directorate.ReportingLeadUserID
                || directorate.Contributors.Any(c => c.ContributorUserID == ApiUser.ID)
                ))
            {
                OrbContext.DirectorateUpdates.Add(directorateUpdate);
                return directorateUpdate;
            }
            return null;
        }
    }
}