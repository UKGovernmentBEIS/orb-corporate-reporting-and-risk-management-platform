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
    public class DirectorateRepository : EntityRepository<Directorate>, IEntityRepository<Directorate>
    {
        public DirectorateRepository(ApiPrincipal user, OrbContext context, IOptions<UserSettings> options)
        : base(user, context, options) { }

        public override IQueryable<Directorate> Entities
        {
            get
            {
                if (ApiUserIsAdmin || ApiUserIsDepartmentRiskManager || ApiUserIsDepartmentalPartnerOrgAdmin)
                {
                    // Departmental Reporting Admins and Departmental Risk Admins can see all Directorates
                    return OrbContext.Directorates;
                }
                else
                {
                    // Directorates for Groups
                    var directoratesFromGroups = from d in OrbContext.Directorates
                                                 from ug in d.Group.UserGroups
                                                 from ugf in d.Group.FinancialRiskUserGroups
                                                 where ug.User.Username == Username || ugf.User.Username == Username
                                                 select d;

                    // Directorates linked directly
                    var directorates = from d in OrbContext.Directorates
                                       from ud in d.UserDirectorates
                                       where ud.User.Username == Username
                                       select d;

                    return directorates
                        .Union(directoratesFromGroups);
                }
            }
        }

        public async Task<Directorate> Edit(int keyValue)
        {
            var directorate = await Entities.SingleOrDefaultAsync(d => d.ID == keyValue);

            if (ApiUserIsAdmin || (directorate != null && ApiUserAdminDirectorates.Contains(directorate.ID)))
            {
                return directorate;
            }
            return null;
        }

        public Directorate Add(Directorate directorate)
        {
            if (ApiUserIsAdmin)
            {
                OrbContext.Directorates.Add(directorate);
                return directorate;
            }
            return null;
        }

        public Directorate Remove(Directorate directorate)
        {
            if (ApiUserIsAdmin)
            {
                OrbContext.Directorates.Remove(directorate);
                return directorate;
            }
            return null;
        }
    }
}