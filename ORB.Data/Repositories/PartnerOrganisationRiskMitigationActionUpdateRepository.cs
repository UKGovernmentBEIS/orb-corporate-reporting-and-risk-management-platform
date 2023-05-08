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
    public class PartnerOrganisationRiskMitigationActionUpdateRepository : EntityUpdateRepository<PartnerOrganisationRiskMitigationActionUpdate>, IEntityUpdateRepository<PartnerOrganisationRiskMitigationActionUpdate>
    {
        public PartnerOrganisationRiskMitigationActionUpdateRepository(ApiPrincipal user, OrbContext context, IOptions<UserSettings> options)
        : base(user, context, options) { }

        public override IQueryable<PartnerOrganisationRiskMitigationActionUpdate> Entities
        {
            get
            {
                if (ApiUserIsDepartmentRiskManager || ApiUserIsDepartmentalPartnerOrgAdmin)
                {
                    // Departmental Risk Admins can see all Partner Org Risk Mitigation Action Updates
                    return OrbContext.PartnerOrganisationRiskMitigationActionUpdates;
                }
                else
                {
                    return from pormau in OrbContext.PartnerOrganisationRiskMitigationActionUpdates
                           from upo in pormau.PartnerOrganisationRiskMitigationAction.PartnerOrganisationRisk.PartnerOrganisation.UserPartnerOrganisations
                           where upo.User.Username == Username
                           select pormau;
                }
            }
        }

        public PartnerOrganisationRiskMitigationActionUpdate Add(PartnerOrganisationRiskMitigationActionUpdate riskMitigationActionUpdate)
        {
            var rma = OrbContext.PartnerOrganisationRiskMitigationActions
                .Include(a => a.PartnerOrganisationRisk).ThenInclude(r => r.PartnerOrganisation)
                .Include(a => a.PartnerOrganisationRisk).ThenInclude(r => r.Contributors)
                .Include(a => a.Contributors)
                .SingleOrDefault(a => a.ID == riskMitigationActionUpdate.PartnerOrganisationRiskMitigationActionID);

            if (rma != null)
            {
                if (ApiUserIsDepartmentRiskManager || ApiUserIsDepartmentalPartnerOrgAdmin
                    || ApiUserAdminPartnerOrganisations.Contains(rma.PartnerOrganisationRisk.PartnerOrganisationID)
                    || rma.PartnerOrganisationRisk.PartnerOrganisation.LeadPolicySponsorUserID == ApiUser.ID
                    || rma.PartnerOrganisationRisk.PartnerOrganisation.ReportAuthorUserID == ApiUser.ID
                    || rma.PartnerOrganisationRisk.BeisRiskOwnerUserID == ApiUser.ID
                    || rma.PartnerOrganisationRisk.RiskOwnerUserID == ApiUser.ID
                    || rma.OwnerUserID == ApiUser.ID
                    || rma.PartnerOrganisationRisk.Contributors.Select(c => c.ContributorUserID).Contains(ApiUser.ID)
                    || rma.Contributors.Select(c => c.ContributorUserID).Contains(ApiUser.ID))
                {
                    OrbContext.PartnerOrganisationRiskMitigationActionUpdates.Add(riskMitigationActionUpdate);
                    return riskMitigationActionUpdate;
                }
            }
            return null;
        }
    }
}