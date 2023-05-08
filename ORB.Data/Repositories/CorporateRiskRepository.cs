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
    public class CorporateRiskRepository : EntityRepository<CorporateRisk>, IEntityRepository<CorporateRisk>
    {
        public CorporateRiskRepository(ApiPrincipal user, OrbContext context, IOptions<UserSettings> options)
        : base(user, context, options) { }

        public override IQueryable<CorporateRisk> Entities
        {
            get
            {
                if (ApiUserIsDepartmentRiskManager)
                {
                    // Risk Admins can see all Risks
                    return OrbContext.CorporateRisks;
                }
                else
                {
                    // Risks for Groups to which the user is assigned and are on group or dept register
                    var groupRisks = from r in OrbContext.CorporateRisks
                                     from ug in r.Directorate.Group.UserGroups
                                     where (r.RiskOwnerUser.Username == Username || ug.User.Username == Username)
                                        && (r.RiskRegisterID == (int)RiskRegisters.Departmental || r.RiskRegisterID == (int)RiskRegisters.Group)
                                     select r;

                    var groupContributorRisks = from r in OrbContext.CorporateRisks
                                                from c in r.Contributors
                                                where c.ContributorUser.Username == Username
                                                   && (r.RiskRegisterID == (int)RiskRegisters.Departmental || r.RiskRegisterID == (int)RiskRegisters.Group)
                                                select r;

                    // Risks for Directorates to which the user is assigned
                    var directorateRisks = from r in OrbContext.CorporateRisks
                                           from ud in r.Directorate.UserDirectorates
                                           where r.RiskOwnerUser.Username == Username || r.ReportApproverUser.Username == Username || ud.User.Username == Username
                                           select r;

                    var directorateContributorRisks = from r in OrbContext.CorporateRisks
                                                      from c in r.Contributors
                                                      where c.ContributorUser.Username == Username
                                                      select r;

                    // Risks for Projects to which the user is assigned
                    var projectRisks = from r in OrbContext.CorporateRisks
                                       from up in r.Project.UserProjects
                                       where r.RiskOwnerUser.Username == Username || r.ReportApproverUser.Username == Username
                                           || up.User.Username == Username
                                       select r;

                    var projectContributorRisks = from r in OrbContext.CorporateRisks
                                                  from c in r.Contributors
                                                  where c.ContributorUser.Username == Username
                                                  select r;

                    return groupRisks.Union(groupContributorRisks)
                        .Union(directorateRisks).Union(directorateContributorRisks)
                        .Union(projectRisks).Union(projectContributorRisks);
                }
            }
        }

        public async Task<CorporateRisk> Edit(int keyValue)
        {
            var risk = await Entities.Include(r => r.Directorate).ThenInclude(d => d.Group).SingleOrDefaultAsync(p => p.ID == keyValue);

            if (risk != null) 
            {
                if (ApiUserIsDepartmentRiskManager)
                {
                    return risk;
                }

                if (risk.RiskOwnerUserID == ApiUser.ID || risk.ReportApproverUserID == ApiUser.ID)
                {
                    return risk;
                }



                if (risk.IsProjectRisk == true && (risk.RiskRegisterID == (int)RiskRegisters.Departmental || risk.RiskRegisterID == (int)RiskRegisters.Group)) // Project risk, departmental or group register
                {
                    if (ApiUserAdminGroupRisks.Contains(risk.Directorate.GroupID)
                        || ApiUserAdminDirectorateRisks.Contains((int)risk.DirectorateID)
                        || ApiUserAdminProjectRisks.Contains((int)risk.ProjectID))
                    {
                        return risk;
                    }
                }

                if (risk.IsProjectRisk == true && risk.RiskRegisterID == (int)RiskRegisters.Directorate) // Project risk, directorate register
                {
                    if (ApiUserAdminProjectRisks.Contains((int)risk.ProjectID)
                        || ApiUserAdminDirectorateRisks.Contains((int)risk.DirectorateID))
                    {
                        return risk;
                    }
                }

                if (risk.RiskRegisterID == (int)RiskRegisters.Departmental) // Departmental
                {
                    if (ApiUserAdminGroupRisks.Contains(risk.Directorate.GroupID)
                        || ApiUserAdminDirectorateRisks.Contains((int)risk.DirectorateID)
                        || risk.Directorate.Group.RiskChampionDeputyDirectorUserID == ApiUser.ID)
                    {
                        return risk;
                    }
                }

                if (risk.RiskRegisterID == (int)RiskRegisters.Group) // Group
                {
                    if (ApiUserAdminGroupRisks.Contains(risk.Directorate.GroupID)
                        || ApiUserAdminDirectorateRisks.Contains((int)risk.DirectorateID)
                        || risk.Directorate.Group.RiskChampionDeputyDirectorUserID == ApiUser.ID)
                    {
                        return risk;
                    }
                }

                if (risk.RiskRegisterID == (int)RiskRegisters.Directorate) // Directorate
                {
                    if (ApiUserAdminDirectorateRisks.Contains((int)risk.DirectorateID))
                    {
                        return risk;
                    }
                }
            }

            return null;
        }

        public CorporateRisk Add(CorporateRisk risk)
        {
            if (ApiUserIsDepartmentRiskManager)
            {
                OrbContext.CorporateRisks.Add(risk);
                return risk;
            }

            if (risk.RiskRegisterID == (int)RiskRegisters.Group) // Group
            {
                var directorate = OrbContext.Directorates.Include(d => d.Group).SingleOrDefault(d => d.ID == risk.DirectorateID);
                if (directorate != null)
                {
                    if (ApiUserAdminGroupRisks.Contains(directorate.GroupID) || directorate.Group.RiskChampionDeputyDirectorUserID == ApiUser.ID)
                    {
                        OrbContext.CorporateRisks.Add(risk);
                        return risk;
                    }
                }

            }

            if (risk.RiskRegisterID == (int)RiskRegisters.Directorate) // Directorate
            {
                if (ApiUserAdminDirectorateRisks.Contains((int)risk.DirectorateID))
                {
                    OrbContext.CorporateRisks.Add(risk);
                    return risk;
                }
            }

            return null;
        }

        public CorporateRisk Remove(CorporateRisk risk)
        {
            if (ApiUserIsDepartmentRiskManager)
            {
                OrbContext.CorporateRisks.Remove(risk);
                return risk;
            }

            var riskDirectorate = OrbContext.Directorates.Find(risk.DirectorateID);

            if (risk.RiskRegisterID == (int)RiskRegisters.Group) // Group
            {
                if (ApiUserAdminGroupRisks.Contains(riskDirectorate.GroupID))
                {
                    OrbContext.CorporateRisks.Remove(risk);
                    return risk;
                }
            }

            if (risk.RiskRegisterID == (int)RiskRegisters.Directorate) // Directorate
            {
                if (ApiUserAdminGroupRisks.Contains(riskDirectorate.GroupID) || ApiUserAdminDirectorateRisks.Contains((int)risk.DirectorateID))
                {
                    OrbContext.CorporateRisks.Remove(risk);
                    return risk;
                }
            }

            return null;
        }
    }
}