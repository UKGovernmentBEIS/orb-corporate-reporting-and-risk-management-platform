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
    public class ReportingEntityRepository : EntityRepository<CustomReportingEntity>, IEntityRepository<CustomReportingEntity>
    {
        public ReportingEntityRepository(ApiPrincipal user, OrbContext context, IOptions<UserSettings> options)
        : base(user, context, options) { }

        public override IQueryable<CustomReportingEntity> Entities
        {
            get
            {
                return from re in OrbContext.ReportingEntities
                       where OrbContext.UserRoles.Any(ur => ur.UserID == ApiUser.ID && ur.RoleID == (int)AdminRoles.SystemAdmin)
                        || re.Directorate.UserDirectorates.Any(ud => ud.User.Username == Username)
                        || re.Project.UserProjects.Any(up => up.User.Username == Username)
                        || re.PartnerOrganisation.UserPartnerOrganisations.Any(upo => upo.User.Username == Username)
                       select re;
            }
        }

        public async Task<CustomReportingEntity> Edit(int keyValue)
        {
            var reportingEntity = await Entities
                .Include(re => re.Directorate)
                .Include(re => re.Project)
                .Include(re => re.PartnerOrganisation)
                .SingleOrDefaultAsync(re => re.ID == keyValue);

            if (ApiUserIsAdmin
                || (reportingEntity.DirectorateID != null &&
                    (ApiUserAdminDirectorates.Contains((int)reportingEntity.DirectorateID)
                    || reportingEntity.Directorate.DirectorUserID == ApiUser.ID
                    || reportingEntity.Directorate.ReportApproverUserID == ApiUser.ID))
                || (reportingEntity.ProjectID != null &&
                    (ApiUserAdminProjects.Contains((int)reportingEntity.ProjectID)
                    || reportingEntity.Project.SeniorResponsibleOwnerUserID == ApiUser.ID
                    || reportingEntity.Project.ReportApproverUserID == ApiUser.ID))
                || (reportingEntity.PartnerOrganisationID != null &&
                    (ApiUserIsDepartmentalPartnerOrgAdmin
                    || ApiUserAdminPartnerOrganisations.Contains((int)reportingEntity.PartnerOrganisationID)
                    || reportingEntity.PartnerOrganisation.ReportAuthorUserID == ApiUser.ID
                    || reportingEntity.PartnerOrganisation.LeadPolicySponsorUserID == ApiUser.ID))
                )
            {
                return reportingEntity;
            }

            return null;
        }

        public CustomReportingEntity Add(CustomReportingEntity reportingEntity)
        {
            if (reportingEntity.DirectorateID != null)
            {
                if (ApiUserIsAdmin || ApiUserAdminDirectorates.Contains((int)reportingEntity.DirectorateID))
                {
                    OrbContext.ReportingEntities.Add(reportingEntity);
                    return reportingEntity;
                }
            }
            if (reportingEntity.ProjectID != null)
            {
                if (ApiUserIsAdmin || ApiUserAdminProjects.Contains((int)reportingEntity.ProjectID))
                {
                    OrbContext.ReportingEntities.Add(reportingEntity);
                    return reportingEntity;
                }
            }
            if (reportingEntity.PartnerOrganisationID != null)
            {
                if (ApiUserIsAdmin || ApiUserIsDepartmentalPartnerOrgAdmin || ApiUserAdminPartnerOrganisations.Contains((int)reportingEntity.PartnerOrganisationID))
                {
                    OrbContext.ReportingEntities.Add(reportingEntity);
                    return reportingEntity;
                }
            }

            return null;
        }

        public CustomReportingEntity Remove(CustomReportingEntity reportingEntity)
        {
            if (ApiUserIsAdmin ||
                (reportingEntity.DirectorateID != null && ApiUserAdminDirectorates.Contains((int)reportingEntity.DirectorateID)) ||
                (reportingEntity.ProjectID != null && ApiUserAdminProjects.Contains((int)reportingEntity.ProjectID)) ||
                (reportingEntity.PartnerOrganisationID != null && (ApiUserAdminPartnerOrganisations.Contains((int)reportingEntity.PartnerOrganisationID) || ApiUserIsDepartmentalPartnerOrgAdmin)))
            {
                OrbContext.ReportingEntities.Remove(reportingEntity);
                return reportingEntity;
            }
            
            return null;
        }
    }
}