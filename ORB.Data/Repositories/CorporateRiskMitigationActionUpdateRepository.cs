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
    public class CorporateRiskMitigationActionUpdateRepository : EntityUpdateRepository<CorporateRiskMitigationActionUpdate>, IEntityUpdateRepository<CorporateRiskMitigationActionUpdate>
    {
        public CorporateRiskMitigationActionUpdateRepository(ApiPrincipal user, OrbContext context, IOptions<UserSettings> options)
        : base(user, context, options) { }

        public override IQueryable<CorporateRiskMitigationActionUpdate> Entities
        {
            get
            {
                if (ApiUserIsDepartmentRiskManager)
                {
                    // Departmental Risk Admins can see all Risk Mitigation Action Updates
                    return OrbContext.CorporateRiskMitigationActionUpdates;
                }
                else
                {
                    // Risk Mitigation Action Updates for Groups linked to user
                    var groupRiskMitigationActionUpdates = from rmau in OrbContext.CorporateRiskMitigationActionUpdates
                                                           where rmau.RiskMitigationAction.Risk.Directorate.Group.UserGroups.Any(ug => ug.User.Username == Username)
                                                           || rmau.RiskMitigationAction.CorporateRiskRiskMitigationActions.Any(rrma => rrma.Risk.Directorate.Group.UserGroups.Any(ug => ug.User.Username == Username))
                                                           select rmau;

                    // Risk Mitigation Action Updates for Directorates linked to user
                    var directorateRiskMitigationActionUpdates = from rmau in OrbContext.CorporateRiskMitigationActionUpdates
                                                                 where rmau.RiskMitigationAction.Risk.Directorate.UserDirectorates.Any(ud => ud.User.Username == Username)
                                                                  || rmau.RiskMitigationAction.CorporateRiskRiskMitigationActions.Any(rrma => rrma.Risk.Directorate.UserDirectorates.Any(ud => ud.User.Username == Username))
                                                                 select rmau;

                    // Risk Mitigation Action Updates for Projects linked to user
                    var projectRiskMitigationActionUpdates = from rmau in OrbContext.CorporateRiskMitigationActionUpdates
                                                             where rmau.RiskMitigationAction.Risk.Project.UserProjects.Any(up => up.User.Username == Username)
                                                             || rmau.RiskMitigationAction.CorporateRiskRiskMitigationActions.Any(rrma => rrma.Risk.Project.UserProjects.Any(up => up.User.Username == Username))
                                                             select rmau;

                    return groupRiskMitigationActionUpdates
                        .Union(directorateRiskMitigationActionUpdates)
                        .Union(projectRiskMitigationActionUpdates);
                }
            }
        }

        public CorporateRiskMitigationActionUpdate Add(CorporateRiskMitigationActionUpdate riskMitigationActionUpdate)
        {

            var rma = OrbContext.CorporateRiskMitigationActions
                .Include(a => a.CorporateRiskRiskMitigationActions).ThenInclude(rrma => rrma.Risk).ThenInclude(r => r.Directorate)
                .Include(a => a.CorporateRiskRiskMitigationActions).ThenInclude(rrma => rrma.Risk).ThenInclude(r => r.Contributors)
                .Include(a => a.Contributors)
                .SingleOrDefault(a => a.ID == riskMitigationActionUpdate.RiskMitigationActionID);


            if (rma != null)
            {
                if (ApiUserIsDepartmentRiskManager)
                {
                    OrbContext.CorporateRiskMitigationActionUpdates.Add(riskMitigationActionUpdate);
                    return riskMitigationActionUpdate;
                }

                if (rma.OwnerUserID == ApiUser.ID || rma.Contributors.Select(c => c.ContributorUserID).Contains(ApiUser.ID))
                {
                    OrbContext.CorporateRiskMitigationActionUpdates.Add(riskMitigationActionUpdate);
                    return riskMitigationActionUpdate;
                }

                foreach (var rrma in rma.CorporateRiskRiskMitigationActions)
                {
                    if (rrma.Risk.IsProjectRisk == true) // Project risk
                    {
                        if (ApiUserAdminProjectRisks.Contains((int)rrma.Risk.ProjectID)
                            || rrma.Risk.RiskOwnerUserID == ApiUser.ID
                            || rrma.Risk.ReportApproverUserID == ApiUser.ID
                            || rrma.Risk.Contributors.Select(c => c.ContributorUserID).Contains(ApiUser.ID))
                        {
                            OrbContext.CorporateRiskMitigationActionUpdates.Add(riskMitigationActionUpdate);
                            return riskMitigationActionUpdate;
                        }
                    }

                    if (rrma.Risk.RiskRegisterID == (int)RiskRegisters.Departmental) // Departmental
                    {
                        if (ApiUserAdminGroupRisks.Contains(rrma.Risk.Directorate.GroupID)
                            || ApiUserAdminDirectorateRisks.Contains((int)rrma.Risk.DirectorateID)
                            || rrma.Risk.RiskOwnerUserID == ApiUser.ID
                            || rrma.Risk.ReportApproverUserID == ApiUser.ID)
                        {
                            OrbContext.CorporateRiskMitigationActionUpdates.Add(riskMitigationActionUpdate);
                            return riskMitigationActionUpdate;
                        }
                    }

                    if (rrma.Risk.RiskRegisterID == (int)RiskRegisters.Group) // Group
                    {
                        if (ApiUserAdminGroupRisks.Contains(rrma.Risk.Directorate.GroupID)
                            || ApiUserAdminDirectorateRisks.Contains((int)rrma.Risk.DirectorateID)
                            || rrma.Risk.RiskOwnerUserID == ApiUser.ID
                            || rrma.Risk.ReportApproverUserID == ApiUser.ID)
                        {
                            OrbContext.CorporateRiskMitigationActionUpdates.Add(riskMitigationActionUpdate);
                            return riskMitigationActionUpdate;
                        }
                    }

                    if (rrma.Risk.RiskRegisterID == (int)RiskRegisters.Directorate) // Directorate
                    {
                        if (ApiUserAdminDirectorateRisks.Contains((int)rrma.Risk.DirectorateID)
                            || rrma.Risk.RiskOwnerUserID == ApiUser.ID
                            || rrma.Risk.ReportApproverUserID == ApiUser.ID)
                        {
                            OrbContext.CorporateRiskMitigationActionUpdates.Add(riskMitigationActionUpdate);
                            return riskMitigationActionUpdate;
                        }
                    }
                }

            }

            //by reaching here foreach loop counter can be 0 (because of 0 dependent risks) or no if condition met
            //so repeat code by ignorning RiskRiskMitigationActions

            var rma2 = OrbContext.CorporateRiskMitigationActions
                    .Include(a => a.Risk).ThenInclude(r => r.Directorate)
                    .Include(a => a.Risk).ThenInclude(r => r.Contributors)
                    .Include(a => a.Contributors)
                    .SingleOrDefault(a => a.ID == riskMitigationActionUpdate.RiskMitigationActionID);
            if(rma2 != null)
            {

                if (rma2.Risk.IsProjectRisk == true) // Project risk
                {
                    if (ApiUserAdminProjectRisks.Contains((int)rma2.Risk.ProjectID)
                        || rma2.Risk.RiskOwnerUserID == ApiUser.ID
                        || rma2.Risk.ReportApproverUserID == ApiUser.ID
                        || rma2.Risk.Contributors.Select(c => c.ContributorUserID).Contains(ApiUser.ID))
                    {
                        OrbContext.CorporateRiskMitigationActionUpdates.Add(riskMitigationActionUpdate);
                        return riskMitigationActionUpdate;
                    }
                }

                if (rma2.Risk.RiskRegisterID == (int)RiskRegisters.Departmental) // Departmental
                {
                    if (ApiUserAdminGroupRisks.Contains(rma2.Risk.Directorate.GroupID)
                        || ApiUserAdminDirectorateRisks.Contains((int)rma2.Risk.DirectorateID)
                        || rma2.Risk.RiskOwnerUserID == ApiUser.ID
                        || rma2.Risk.ReportApproverUserID == ApiUser.ID)
                    {
                        OrbContext.CorporateRiskMitigationActionUpdates.Add(riskMitigationActionUpdate);
                        return riskMitigationActionUpdate;
                    }
                }

                if (rma2.Risk.RiskRegisterID == (int)RiskRegisters.Group) // Group
                {
                    if (ApiUserAdminGroupRisks.Contains(rma2.Risk.Directorate.GroupID)
                        || ApiUserAdminDirectorateRisks.Contains((int)rma2.Risk.DirectorateID)
                        || rma2.Risk.RiskOwnerUserID == ApiUser.ID
                        || rma2.Risk.ReportApproverUserID == ApiUser.ID)
                    {
                        OrbContext.CorporateRiskMitigationActionUpdates.Add(riskMitigationActionUpdate);
                        return riskMitigationActionUpdate;
                    }
                }

                if (rma2.Risk.RiskRegisterID == (int)RiskRegisters.Directorate) // Directorate
                {
                    if (ApiUserAdminDirectorateRisks.Contains((int)rma2.Risk.DirectorateID)
                        || rma2.Risk.RiskOwnerUserID == ApiUser.ID
                        || rma2.Risk.ReportApproverUserID == ApiUser.ID)
                    {
                        OrbContext.CorporateRiskMitigationActionUpdates.Add(riskMitigationActionUpdate);
                        return riskMitigationActionUpdate;
                    }
                }
            }



            return null;
        }
    }
}