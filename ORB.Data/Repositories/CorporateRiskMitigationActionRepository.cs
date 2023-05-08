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
    public class CorporateRiskMitigationActionRepository : EntityRepository<CorporateRiskMitigationAction>, IEntityRepository<CorporateRiskMitigationAction>
    {
        public CorporateRiskMitigationActionRepository(ApiPrincipal user, OrbContext context, IOptions<UserSettings> options)
        : base(user, context, options) { }

        public override IQueryable<CorporateRiskMitigationAction> Entities
        {
            get
            {
                if (ApiUserIsDepartmentRiskManager)
                {
                    // Risk Admins can see all Risk Mitigation Actions
                    return OrbContext.CorporateRiskMitigationActions;
                }
                else
                {
                    // Risk Mitigation Actions for Groups to which the user is assigned
                    var groupRiskMitigationActions = from rma in OrbContext.CorporateRiskMitigationActions
                                                     where rma.Risk.Directorate.Group.UserGroups.Any(ug => ug.User.Username == Username)
                                                      || rma.CorporateRiskRiskMitigationActions.Any(rrma => rrma.Risk.Directorate.Group.UserGroups.Any(ug => ug.User.Username == Username))
                                                     select rma;

                    // Risk Mitigation Actions for Directorates to which the user is assigned
                    var directorateRiskMitigationActions = from rma in OrbContext.CorporateRiskMitigationActions
                                                           where rma.Risk.Directorate.UserDirectorates.Any(ud => ud.User.Username == Username)
                                                            || rma.CorporateRiskRiskMitigationActions.Any(rrma => rrma.Risk.Directorate.UserDirectorates.Any(ud => ud.User.Username == Username))
                                                           select rma;

                    // Risk Mitigation Actions for Projects to which the user is assigned
                    var projectRiskMitigationActions = from rma in OrbContext.CorporateRiskMitigationActions
                                                       where rma.Risk.Project.UserProjects.Any(up => up.User.Username == Username)
                                                        || rma.CorporateRiskRiskMitigationActions.Any(rrma => rrma.Risk.Project.UserProjects.Any(up => up.User.Username == Username))
                                                       select rma;

                    return groupRiskMitigationActions
                        .Union(directorateRiskMitigationActions)
                        .Union(projectRiskMitigationActions);
                }
            }
        }

        public async Task<CorporateRiskMitigationAction> Edit(int keyValue)
        {
            var rma = await Entities
                .Include(a => a.Risk).ThenInclude(r => r.Directorate)
                .Include(a => a.CorporateRiskRiskMitigationActions).ThenInclude(rrma => rrma.Risk).ThenInclude(r => r.Directorate)
                .SingleOrDefaultAsync(p => p.ID == keyValue);

            if (ApiUserIsDepartmentRiskManager)
            {
                return rma;
            }

            if (rma.Risk.RiskRegisterID == (int)RiskRegisters.Departmental) // Departmental
            {
                if (ApiUserAdminGroupRisks.Contains(rma.Risk.Directorate.GroupID)
                    || ApiUserAdminDirectorateRisks.Contains((int)rma.Risk.DirectorateID)
                    || rma.Risk.RiskOwnerUserID == ApiUser.ID
                    || rma.Risk.ReportApproverUserID == ApiUser.ID)
                {
                    return rma;
                }
            }

            if (rma.Risk.RiskRegisterID == (int)RiskRegisters.Group) // Group
            {
                if (ApiUserAdminGroupRisks.Contains(rma.Risk.Directorate.GroupID)
                    || ApiUserAdminDirectorateRisks.Contains((int)rma.Risk.DirectorateID)
                    || rma.Risk.RiskOwnerUserID == ApiUser.ID
                    || rma.Risk.ReportApproverUserID == ApiUser.ID)
                {
                    return rma;
                }
            }

            if (rma.Risk.RiskRegisterID == (int)RiskRegisters.Directorate) // Directorate
            {
                if (ApiUserAdminDirectorateRisks.Contains((int)rma.Risk.DirectorateID)
                    || rma.Risk.RiskOwnerUserID == ApiUser.ID
                    || rma.Risk.ReportApproverUserID == ApiUser.ID)
                {
                    return rma;
                }
            }

            foreach (var rrma in rma.CorporateRiskRiskMitigationActions)
            {
                if (rrma.Risk.RiskRegisterID == (int)RiskRegisters.Departmental) // Departmental
                {
                    if (ApiUserAdminGroupRisks.Contains(rrma.Risk.Directorate.GroupID)
                        || ApiUserAdminDirectorateRisks.Contains((int)rrma.Risk.DirectorateID)
                        || rrma.Risk.RiskOwnerUserID == ApiUser.ID
                        || rrma.Risk.ReportApproverUserID == ApiUser.ID)
                    {
                        return rma;
                    }
                }

                if (rrma.Risk.RiskRegisterID == (int)RiskRegisters.Group) // Group
                {
                    if (ApiUserAdminGroupRisks.Contains(rrma.Risk.Directorate.GroupID)
                        || ApiUserAdminDirectorateRisks.Contains((int)rrma.Risk.DirectorateID)
                        || rrma.Risk.RiskOwnerUserID == ApiUser.ID
                        || rrma.Risk.ReportApproverUserID == ApiUser.ID)
                    {
                        return rma;
                    }
                }

                if (rrma.Risk.RiskRegisterID == (int)RiskRegisters.Directorate) // Directorate
                {
                    if (ApiUserAdminDirectorateRisks.Contains((int)rrma.Risk.DirectorateID)
                        || rrma.Risk.RiskOwnerUserID == ApiUser.ID
                        || rrma.Risk.ReportApproverUserID == ApiUser.ID)
                    {
                        return rma;
                    }
                }
            }

            return null;
        }

        public CorporateRiskMitigationAction Add(CorporateRiskMitigationAction riskMitigationAction)
        {
            if (ApiUserIsDepartmentRiskManager)
            {
                OrbContext.CorporateRiskMitigationActions.Add(riskMitigationAction);
                return riskMitigationAction;
            }

            var risk = OrbContext.CorporateRisks.Include(r => r.Directorate).SingleOrDefault(r => r.ID == riskMitigationAction.RiskID);
            if (risk != null)
            {
                if (risk.RiskRegisterID == (int)RiskRegisters.Departmental) // Departmental
                {
                    if (ApiUserAdminGroupRisks.Contains(risk.Directorate.GroupID)
                        || ApiUserAdminDirectorateRisks.Contains((int)risk.DirectorateID)
                        || risk.RiskOwnerUserID == ApiUser.ID
                        || risk.ReportApproverUserID == ApiUser.ID)
                    {
                        OrbContext.CorporateRiskMitigationActions.Add(riskMitigationAction);
                        return riskMitigationAction;
                    }
                }

                if (risk.RiskRegisterID == (int)RiskRegisters.Group) // Group
                {
                    if (ApiUserAdminGroupRisks.Contains(risk.Directorate.GroupID)
                        || ApiUserAdminDirectorateRisks.Contains((int)risk.DirectorateID)
                        || risk.RiskOwnerUserID == ApiUser.ID
                        || risk.ReportApproverUserID == ApiUser.ID)
                    {
                        OrbContext.CorporateRiskMitigationActions.Add(riskMitigationAction);
                        return riskMitigationAction;
                    }
                }

                if (risk.RiskRegisterID == (int)RiskRegisters.Directorate) // Directorate
                {
                    if (ApiUserAdminDirectorateRisks.Contains((int)risk.DirectorateID)
                        || risk.RiskOwnerUserID == ApiUser.ID
                        || risk.ReportApproverUserID == ApiUser.ID)
                    {
                        OrbContext.CorporateRiskMitigationActions.Add(riskMitigationAction);
                        return riskMitigationAction;
                    }
                }
            }

            return null;
        }

        public CorporateRiskMitigationAction Remove(CorporateRiskMitigationAction riskMitigationAction)
        {
            if (ApiUserIsDepartmentRiskManager)
            {
                OrbContext.CorporateRiskMitigationActions.Remove(riskMitigationAction);
                return riskMitigationAction;
            }

            var risk = OrbContext.CorporateRisks.Include(r => r.Directorate).SingleOrDefault(r => r.ID == riskMitigationAction.RiskID);

            if(risk != null)
            {
                if (risk.RiskRegisterID == (int)RiskRegisters.Departmental) // Departmental
                {
                    if (ApiUserAdminGroupRisks.Contains(risk.Directorate.GroupID)
                        || ApiUserAdminDirectorateRisks.Contains((int)risk.DirectorateID))
                    {
                        OrbContext.CorporateRiskMitigationActions.Remove(riskMitigationAction);
                        return riskMitigationAction;
                    }
                }

                if (risk.RiskRegisterID == (int)RiskRegisters.Group) // Group
                {
                    if (ApiUserAdminGroupRisks.Contains(risk.Directorate.GroupID)
                        || ApiUserAdminDirectorateRisks.Contains((int)risk.DirectorateID))
                    {
                        OrbContext.CorporateRiskMitigationActions.Remove(riskMitigationAction);
                        return riskMitigationAction;
                    }
                }

                if (riskMitigationAction.Risk.RiskRegisterID == (int)RiskRegisters.Directorate) // Directorate
                {
                    if (ApiUserAdminDirectorateRisks.Contains((int)risk.DirectorateID))
                    {
                        OrbContext.CorporateRiskMitigationActions.Remove(riskMitigationAction);
                        return riskMitigationAction;
                    }
                }
            }

            return null;
        }
    }
}