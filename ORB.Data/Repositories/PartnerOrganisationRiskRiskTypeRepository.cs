using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using ORB.Core;
using ORB.Core.Models;
using ORB.Core.Repositories;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Principal;
using System.Threading.Tasks;

namespace ORB.Data.Repositories
{
    public class PartnerOrganisationRiskRiskTypeRepository : EntityRepository<PartnerOrganisationRiskRiskType>, IPartnerOrganisationRiskRiskTypeRepository
    {
        public PartnerOrganisationRiskRiskTypeRepository(ApiPrincipal user, OrbContext context, IOptions<UserSettings> options)
        : base(user, context, options) { }

        public override IQueryable<PartnerOrganisationRiskRiskType> Entities
        {
            get
            {
                return OrbContext.PartnerOrganisationRiskRiskTypes;
            }
        }

        public async Task<PartnerOrganisationRiskRiskType> Edit(int keyValue)
        {
            return await Entities.SingleOrDefaultAsync(e => e.ID == keyValue);
        }

        public PartnerOrganisationRiskRiskType Add(PartnerOrganisationRiskRiskType riskRiskType)
        {
            if (ApiUserIsDepartmentRiskManager || ApiUserIsDepartmentalPartnerOrgAdmin)
            {
                OrbContext.PartnerOrganisationRiskRiskTypes.Add(riskRiskType);
                return riskRiskType;
            }

            var risk = OrbContext.PartnerOrganisationRisks.Find(riskRiskType.PartnerOrganisationRiskID);
            if (risk != null)
            {
                if (ApiUserAdminPartnerOrganisations.Contains(risk.PartnerOrganisationID)
                    || risk.BeisRiskOwnerUserID == ApiUser.ID
                    || risk.RiskOwnerUserID == ApiUser.ID)
                {
                    OrbContext.PartnerOrganisationRiskRiskTypes.Add(riskRiskType);
                    return riskRiskType;
                }
            }
            return null;
        }

        public PartnerOrganisationRiskRiskType Remove(PartnerOrganisationRiskRiskType riskRiskType)
        {
            if (ApiUserIsDepartmentRiskManager || ApiUserIsDepartmentalPartnerOrgAdmin)
            {
                OrbContext.PartnerOrganisationRiskRiskTypes.Remove(riskRiskType);
                return riskRiskType;
            }

            var risk = OrbContext.PartnerOrganisationRisks.Find(riskRiskType.PartnerOrganisationRiskID);
            if (risk != null)
            {
                if (ApiUserAdminPartnerOrganisations.Contains(risk.PartnerOrganisationID)
                    || risk.BeisRiskOwnerUserID == ApiUser.ID
                    || risk.RiskOwnerUserID == ApiUser.ID)
                {
                    OrbContext.PartnerOrganisationRiskRiskTypes.Remove(riskRiskType);
                    return riskRiskType;
                }
            }

            return null;
        }

        public void RemoveRange(IEnumerable<PartnerOrganisationRiskRiskType> partnerOrganisationRiskRiskTypes)
        {
            OrbContext.PartnerOrganisationRiskRiskTypes.RemoveRange(partnerOrganisationRiskRiskTypes);
        }
    }
}