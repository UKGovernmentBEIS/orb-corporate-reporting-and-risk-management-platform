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
    public class KeyWorkAreaUpdateRepository : EntityUpdateRepository<KeyWorkAreaUpdate>, IEntityUpdateRepository<KeyWorkAreaUpdate>
    {
        public KeyWorkAreaUpdateRepository(ApiPrincipal user, OrbContext context, IOptions<UserSettings> options)
        : base(user, context, options) { }

        public override IQueryable<KeyWorkAreaUpdate> Entities
        {
            get
            {
                if (ApiUserIsAdmin)
                {
                    // Departmental Reporting Admins can see all Key Work Area Updates
                    return OrbContext.KeyWorkAreaUpdates;
                }
                else
                {
                    return (from ud in OrbContext.UserDirectorates
                            where ud.User.Username == Username
                            from kwa in ud.Directorate.KeyWorkAreas
                            from kwau in kwa.KeyWorkAreaUpdates
                            select kwau);
                }
            }
        }

        public KeyWorkAreaUpdate Add(KeyWorkAreaUpdate keyWorkAreaUpdate)
        {
            var userId = ApiUser.ID;

            var kwa = OrbContext.KeyWorkAreas.Include(k => k.Contributors).Include(k => k.Directorate).SingleOrDefault(k => k.ID == keyWorkAreaUpdate.KeyWorkAreaID);
            if (kwa != null && (ApiUserIsAdmin
                || ApiUserAdminDirectorates.Contains(kwa.DirectorateID)
                || kwa.Contributors.Select(c => c.ContributorUserID).Contains(userId)
                || userId == kwa.Directorate.DirectorUserID
                || userId == kwa.Directorate.ReportApproverUserID
                || userId == kwa.LeadUserID))
            {
                OrbContext.KeyWorkAreaUpdates.Add(keyWorkAreaUpdate);
                return keyWorkAreaUpdate;
            }
            
            return null;
        }
    }
}