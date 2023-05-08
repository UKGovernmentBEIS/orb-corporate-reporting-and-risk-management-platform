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
    public class PartnerOrganisationRepository : EntityRepository<PartnerOrganisation>, IEntityRepository<PartnerOrganisation>
    {
        public PartnerOrganisationRepository(ApiPrincipal user, OrbContext context, IOptions<UserSettings> options)
        : base(user, context, options) { }

        public override IQueryable<PartnerOrganisation> Entities
        {
            get
            {
                var adminPartnerOrgs = from po in OrbContext.PartnerOrganisations
                                       from ur in OrbContext.UserRoles
                                       where ur.User.Username == Username &&
                                           (ur.RoleID == (int)AdminRoles.SystemAdmin || ur.RoleID == (int)AdminRoles.RiskAdmin || ur.RoleID == (int)AdminRoles.PartnerOrganisationAdmin)
                                       select po;

                var assignedPartnerOrgs = from po in OrbContext.PartnerOrganisations
                                          from upo in po.UserPartnerOrganisations
                                          where upo.User.Username == Username
                                          select po;

                return adminPartnerOrgs
                    .Union(assignedPartnerOrgs);
            }
        }

        public async Task<PartnerOrganisation> Edit(int keyValue)
        {
            var partnerOrg = await Entities.SingleOrDefaultAsync(m => m.ID == keyValue);

            if (ApiUserIsAdmin || ApiUserIsDepartmentalPartnerOrgAdmin
                || (partnerOrg != null && ApiUserAdminPartnerOrganisations.Contains(partnerOrg.ID)))
            {
                return partnerOrg;
            }
            return null;
        }

        public PartnerOrganisation Add(PartnerOrganisation partnerOrganisation)
        {
            if (ApiUserIsAdmin || ApiUserIsDepartmentalPartnerOrgAdmin)
            {
                OrbContext.PartnerOrganisations.Add(partnerOrganisation);
                return partnerOrganisation;
            }
            return null;
        }

        public PartnerOrganisation Remove(PartnerOrganisation partnerOrganisation)
        {
            if (ApiUserIsAdmin || ApiUserIsDepartmentalPartnerOrgAdmin)
            {
                OrbContext.PartnerOrganisations.Remove(partnerOrganisation);
                return partnerOrganisation;
            }
            return null;
        }
    }
}