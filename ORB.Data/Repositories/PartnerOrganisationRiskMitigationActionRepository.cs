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
    public class PartnerOrganisationRiskMitigationActionRepository
    : EntityRepository<PartnerOrganisationRiskMitigationAction>, IEntityRepository<PartnerOrganisationRiskMitigationAction>
    {
        public PartnerOrganisationRiskMitigationActionRepository(ApiPrincipal user, OrbContext context, IOptions<UserSettings> options)
        : base(user, context, options) { }

        public override IQueryable<PartnerOrganisationRiskMitigationAction> Entities
        {
            get
            {
                if (ApiUserIsDepartmentRiskManager || ApiUserIsDepartmentalPartnerOrgAdmin)
                {
                    // Departmental Risk Admins can see all Partner Org Risk Mitigation Actions
                    return OrbContext.PartnerOrganisationRiskMitigationActions;
                }
                else
                {
                    return from porma in OrbContext.PartnerOrganisationRiskMitigationActions
                           from upo in porma.PartnerOrganisationRisk.PartnerOrganisation.UserPartnerOrganisations
                           where upo.User.Username == Username
                           select porma;
                }
            }
        }

        public async Task<PartnerOrganisationRiskMitigationAction> Edit(int keyValue)
        {
            var rma = await Entities.Include(a => a.PartnerOrganisationRisk).ThenInclude(r => r.PartnerOrganisation).SingleOrDefaultAsync(p => p.ID == keyValue);

            if (ApiUserIsDepartmentRiskManager || ApiUserIsDepartmentalPartnerOrgAdmin
                || ApiUserAdminPartnerOrganisations.Contains(rma.PartnerOrganisationRisk.PartnerOrganisationID)
                || rma.PartnerOrganisationRisk.BeisRiskOwnerUserID == ApiUser.ID
                || rma.PartnerOrganisationRisk.RiskOwnerUserID == ApiUser.ID
                || (rma.PartnerOrganisationRisk != null && rma.PartnerOrganisationRisk.PartnerOrganisation != null
                    && (rma.PartnerOrganisationRisk.PartnerOrganisation.ReportAuthorUserID == ApiUser.ID
                    || rma.PartnerOrganisationRisk.PartnerOrganisation.LeadPolicySponsorUserID == ApiUser.ID))
                )
            {
                return rma;
            }

            return null;
        }

        public PartnerOrganisationRiskMitigationAction Add(PartnerOrganisationRiskMitigationAction riskMitigationAction)
        {
            var risk = OrbContext.PartnerOrganisationRisks.Find(riskMitigationAction.PartnerOrganisationRiskID);
            if (risk != null)
            {
                if (ApiUserIsDepartmentRiskManager || ApiUserIsDepartmentalPartnerOrgAdmin
                    || ApiUserAdminPartnerOrganisations.Contains(risk.PartnerOrganisationID)
                    || risk.BeisRiskOwnerUserID == ApiUser.ID
                    || risk.RiskOwnerUserID == ApiUser.ID)
                {
                    OrbContext.PartnerOrganisationRiskMitigationActions.Add(riskMitigationAction);
                    return riskMitigationAction;
                }
            }

            return null;
        }

        public PartnerOrganisationRiskMitigationAction Remove(PartnerOrganisationRiskMitigationAction riskMitigationAction)
        {
            var rma = OrbContext.PartnerOrganisationRiskMitigationActions.Include(a => a.PartnerOrganisationRisk).SingleOrDefault(a => a.ID == riskMitigationAction.PartnerOrganisationRiskID);
            if(rma != null)
            {
                if (ApiUserIsDepartmentRiskManager || ApiUserIsDepartmentalPartnerOrgAdmin
                    || ApiUserAdminPartnerOrganisations.Contains(rma.PartnerOrganisationRisk.PartnerOrganisationID))
                {
                    OrbContext.PartnerOrganisationRiskMitigationActions.Remove(riskMitigationAction);
                    return riskMitigationAction;
                }
            }

            return null;
        }
    }
}