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
    public class KeyWorkAreaRepository : EntityRepository<KeyWorkArea>, IEntityRepository<KeyWorkArea>
    {
        public KeyWorkAreaRepository(ApiPrincipal user, OrbContext context, IOptions<UserSettings> options)
        : base(user, context, options) { }

        public override IQueryable<KeyWorkArea> Entities
        {
            get
            {
                if (ApiUserIsAdmin)
                {
                    // Departmental Reporting Admins can see all Key Work Areas
                    return OrbContext.KeyWorkAreas;
                }
                else
                {
                    return from kwa in OrbContext.KeyWorkAreas
                           from ud in kwa.Directorate.UserDirectorates
                           where ud.User.Username == Username
                           select kwa;
                }
            }
        }

        public async Task<KeyWorkArea> Edit(int keyValue)
        {
            var keyWorkArea = await Entities.Include(k => k.Directorate).SingleOrDefaultAsync(k => k.ID == keyValue);

            if (ApiUserIsAdmin || (keyWorkArea != null && (
                ApiUserAdminDirectorates.Contains(keyWorkArea.DirectorateID)
                || keyWorkArea.Directorate.DirectorUserID == ApiUser.ID
                || keyWorkArea.Directorate.ReportApproverUserID == ApiUser.ID
                )))
            {
                return keyWorkArea;
            }
            return null;
        }

        public KeyWorkArea Add(KeyWorkArea keyWorkArea)
        {
            if (ApiUserIsAdmin || ApiUserAdminDirectorates.Contains(keyWorkArea.DirectorateID))
            {
                OrbContext.KeyWorkAreas.Add(keyWorkArea);
                return keyWorkArea;
            }
            return null;
        }

        public KeyWorkArea Remove(KeyWorkArea keyWorkArea)
        {
            if (ApiUserIsAdmin || ApiUserAdminDirectorates.Contains(keyWorkArea.DirectorateID))
            {
                OrbContext.KeyWorkAreas.Remove(keyWorkArea);
                return keyWorkArea;
            }
            return null;
        }
    }
}