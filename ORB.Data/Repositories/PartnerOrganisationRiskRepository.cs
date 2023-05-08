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
    public class PartnerOrganisationRiskRepository : EntityRepository<PartnerOrganisationRisk>, IEntityRepository<PartnerOrganisationRisk>
    {
        public PartnerOrganisationRiskRepository(ApiPrincipal user, OrbContext context, IOptions<UserSettings> options)
        : base(user, context, options) { }

        public override IQueryable<PartnerOrganisationRisk> Entities
        {
            get
            {
                if (ApiUserIsDepartmentRiskManager || ApiUserIsDepartmentalPartnerOrgAdmin)
                {
                    // Departmental Risk Admins can see all Partner Organisation Risks
                    return OrbContext.PartnerOrganisationRisks;
                }
                else
                {
                    return from por in OrbContext.PartnerOrganisationRisks
                           from upo in por.PartnerOrganisation.UserPartnerOrganisations
                           where upo.User.Username == Username
                           select por;
                }
            }
        }

        public async Task<PartnerOrganisationRisk> Edit(int keyValue)
        {
            var risk = await Entities.Include(r => r.PartnerOrganisation).SingleOrDefaultAsync(p => p.ID == keyValue);

            if (ApiUserIsDepartmentRiskManager || ApiUserIsDepartmentalPartnerOrgAdmin)
            {
                return risk;
            }

            if (risk != null && ApiUserAdminPartnerOrganisations.Contains(risk.PartnerOrganisationID))
            {
                return risk;
            }

            if (risk != null && risk.PartnerOrganisation != null
                && (risk.RiskOwnerUserID == ApiUser.ID
                || risk.BeisRiskOwnerUserID == ApiUser.ID
                || risk.PartnerOrganisation.ReportAuthorUserID == ApiUser.ID
                || risk.PartnerOrganisation.LeadPolicySponsorUserID == ApiUser.ID))
            {
                return risk;
            }

            return null;
        }

        public PartnerOrganisationRisk Add(PartnerOrganisationRisk risk)
        {
            if (ApiUserIsDepartmentRiskManager || ApiUserIsDepartmentalPartnerOrgAdmin)
            {
                OrbContext.PartnerOrganisationRisks.Add(risk);
                return risk;
            }

            if (ApiUserAdminPartnerOrganisations.Contains(risk.PartnerOrganisationID))
            {
                OrbContext.PartnerOrganisationRisks.Add(risk);
                return risk;
            }

            return null;
        }

        public PartnerOrganisationRisk Remove(PartnerOrganisationRisk risk)
        {
            if (ApiUserIsDepartmentRiskManager || ApiUserAdminPartnerOrganisations.Contains(risk.PartnerOrganisationID) || ApiUserIsDepartmentalPartnerOrgAdmin)
            {
                
                OrbContext.PartnerOrganisationRisks.Remove(risk);
                return risk;
                
            }

            return null;
        }
    }
}