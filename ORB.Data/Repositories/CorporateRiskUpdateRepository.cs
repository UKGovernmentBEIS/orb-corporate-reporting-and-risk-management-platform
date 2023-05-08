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
    public class CorporateRiskUpdateRepository : EntityUpdateRepository<CorporateRiskUpdate>, IEntityUpdateRepository<CorporateRiskUpdate>
    {
        public CorporateRiskUpdateRepository(ApiPrincipal user, OrbContext context, IOptions<UserSettings> options)
        : base(user, context, options) { }

        public override IQueryable<CorporateRiskUpdate> Entities
        {
            get
            {
                if (ApiUserIsDepartmentRiskManager)
                {
                    // Departmental Risk Admins can see all Risk Updates
                    return OrbContext.CorporateRiskUpdates;
                }
                else
                {
                    // Risk Updates from Groups to which the user is assigned
                    var groupRiskUpdates = from ru in OrbContext.CorporateRiskUpdates
                                           from ug in ru.Risk.Directorate.Group.UserGroups
                                           where ug.User.Username == Username
                                           select ru;

                    // Risk Updates for Directorates to which the user is assigned
                    var directorateRiskUpdates = from ru in OrbContext.CorporateRiskUpdates
                                                 from ud in ru.Risk.Directorate.UserDirectorates
                                                 where ud.User.Username == Username
                                                 select ru;

                    // Risk Updates for Projects to which the user is assigned
                    var projectRiskUpdates = from ru in OrbContext.CorporateRiskUpdates
                                             from up in ru.Risk.Project.UserProjects
                                             where up.User.Username == Username
                                             select ru;

                    return groupRiskUpdates
                        .Union(directorateRiskUpdates)
                        .Union(projectRiskUpdates);
                }
            }
        }

        public CorporateRiskUpdate Add(CorporateRiskUpdate riskUpdate)
        {
            var risk = OrbContext.CorporateRisks
                .Include(r => r.Contributors)
                .Include(r => r.Directorate)
                .SingleOrDefault(r => r.ID == riskUpdate.RiskID);

            if (risk != null)
            {
                if (ApiUserIsDepartmentRiskManager)
                {
                    OrbContext.CorporateRiskUpdates.Add(riskUpdate);
                    return riskUpdate;
                }

                if (risk.IsProjectRisk == true) // Project risk
                {
                    if (ApiUserAdminProjectRisks.Contains((int)risk.ProjectID)
                        || risk.RiskOwnerUserID == ApiUser.ID
                        || risk.ReportApproverUserID == ApiUser.ID
                        || risk.Contributors.Select(c => c.ContributorUserID).Contains(ApiUser.ID))
                    {
                        OrbContext.CorporateRiskUpdates.Add(riskUpdate);
                        return riskUpdate;
                    }
                }

                if (risk.RiskRegisterID == (int)RiskRegisters.Departmental) // Departmental
                {
                    if (ApiUserAdminGroupRisks.Contains(risk.Directorate.GroupID)
                        || ApiUserAdminDirectorateRisks.Contains((int)risk.DirectorateID)
                        || risk.RiskOwnerUserID == ApiUser.ID
                        || risk.ReportApproverUserID == ApiUser.ID
                        || risk.Contributors.Select(c => c.ContributorUserID).Contains(ApiUser.ID))
                    {
                        OrbContext.CorporateRiskUpdates.Add(riskUpdate);
                        return riskUpdate;
                    }
                }

                if (risk.RiskRegisterID == (int)RiskRegisters.Group) // Group
                {
                    if (ApiUserAdminGroupRisks.Contains(risk.Directorate.GroupID)
                        || ApiUserAdminDirectorateRisks.Contains((int)risk.DirectorateID)
                        || risk.RiskOwnerUserID == ApiUser.ID
                        || risk.ReportApproverUserID == ApiUser.ID
                        || risk.Contributors.Select(c => c.ContributorUserID).Contains(ApiUser.ID))
                    {
                        OrbContext.CorporateRiskUpdates.Add(riskUpdate);
                        return riskUpdate;
                    }
                }

                if (risk.RiskRegisterID == (int)RiskRegisters.Directorate) // Directorate
                {
                    if (ApiUserAdminDirectorateRisks.Contains((int)risk.DirectorateID)
                        || risk.RiskOwnerUserID == ApiUser.ID
                        || risk.ReportApproverUserID == ApiUser.ID
                        || risk.Contributors.Select(c => c.ContributorUserID).Contains(ApiUser.ID))
                    {
                        OrbContext.CorporateRiskUpdates.Add(riskUpdate);
                        return riskUpdate;
                    }
                }
            }

            return null;
        }
    }
}