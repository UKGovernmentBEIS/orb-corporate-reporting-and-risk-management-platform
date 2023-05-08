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
    public class PartnerOrganisationRiskUpdateRepository : EntityUpdateRepository<PartnerOrganisationRiskUpdate>, IEntityUpdateRepository<PartnerOrganisationRiskUpdate>
    {
        public PartnerOrganisationRiskUpdateRepository(ApiPrincipal user, OrbContext context, IOptions<UserSettings> options)
        : base(user, context, options) { }

        public override IQueryable<PartnerOrganisationRiskUpdate> Entities
        {
            get
            {
                if (ApiUserIsDepartmentRiskManager || ApiUserIsDepartmentalPartnerOrgAdmin)
                {
                    // Department Risk Admins can see all Partner Organisation Risk Updates
                    return OrbContext.PartnerOrganisationRiskUpdates;
                }
                else
                {
                    return from poru in OrbContext.PartnerOrganisationRiskUpdates
                           from upo in poru.PartnerOrganisationRisk.PartnerOrganisation.UserPartnerOrganisations
                           where upo.User.Username == Username
                           select poru;
                }
            }
        }

        public PartnerOrganisationRiskUpdate Add(PartnerOrganisationRiskUpdate riskUpdate)
        {
            var risk = OrbContext.PartnerOrganisationRisks
                .Include(r => r.PartnerOrganisation)
                .Include(r => r.Contributors)
                .SingleOrDefault(r => r.ID == riskUpdate.PartnerOrganisationRiskID);

            if (risk != null)
            {
                if (ApiUserIsDepartmentRiskManager || ApiUserIsDepartmentalPartnerOrgAdmin
                    || ApiUserAdminPartnerOrganisations.Contains(risk.PartnerOrganisationID)
                    || risk.PartnerOrganisation.LeadPolicySponsorUserID == ApiUser.ID
                    || risk.PartnerOrganisation.ReportAuthorUserID == ApiUser.ID
                    || risk.BeisRiskOwnerUserID == ApiUser.ID
                    || risk.RiskOwnerUserID == ApiUser.ID
                    || risk.Contributors.Select(c => c.ContributorUserID).Contains(ApiUser.ID))
                {
                    OrbContext.PartnerOrganisationRiskUpdates.Add(riskUpdate);
                    return riskUpdate;
                }
            }

            return null;
        }
    }
}