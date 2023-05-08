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
    public class PartnerOrganisationUpdateRepository : EntityUpdateRepository<PartnerOrganisationUpdate>, IEntityUpdateRepository<PartnerOrganisationUpdate>
    {
        public PartnerOrganisationUpdateRepository(ApiPrincipal user, OrbContext context, IOptions<UserSettings> options)
        : base(user, context, options) { }

        public override IQueryable<PartnerOrganisationUpdate> Entities
        {
            get
            {
                if (ApiUserIsAdmin || ApiUserIsDepartmentalPartnerOrgAdmin)
                {
                    // Departmental Reporting Admins can see all Partner Organisations
                    return OrbContext.PartnerOrganisationUpdates;
                }
                else
                {
                    return from pou in OrbContext.PartnerOrganisationUpdates
                           from upo in pou.PartnerOrganisation.UserPartnerOrganisations
                           where upo.User.Username == Username
                           select pou;
                }
            }
        }

        public PartnerOrganisationUpdate Add(PartnerOrganisationUpdate partnerOrganisationUpdate)
        {
            var partnerOrganisation = OrbContext.PartnerOrganisations.Include(p => p.Contributors).SingleOrDefault(d => d.ID == partnerOrganisationUpdate.PartnerOrganisationID);
            if (partnerOrganisation != null && (
                ApiUserIsAdmin
                || ApiUserIsDepartmentalPartnerOrgAdmin
                || ApiUserAdminPartnerOrganisations.Contains(partnerOrganisation.ID)
                || ApiUser.ID == partnerOrganisation.LeadPolicySponsorUserID
                || ApiUser.ID == partnerOrganisation.ReportAuthorUserID
                || partnerOrganisation.Contributors.Any(c => c.ContributorUserID == ApiUser.ID && c.IsReadOnly != true)
                ))
            {
                OrbContext.PartnerOrganisationUpdates.Add(partnerOrganisationUpdate);
                return partnerOrganisationUpdate;
            }
            return null;
        }
    }
}