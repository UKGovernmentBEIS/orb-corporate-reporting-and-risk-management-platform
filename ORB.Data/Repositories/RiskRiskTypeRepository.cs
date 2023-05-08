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
    public class RiskRiskTypeRepository : EntityRepository<RiskRiskType>, IRiskRiskTypeRepository
    {
        public RiskRiskTypeRepository(ApiPrincipal user, OrbContext context, IOptions<UserSettings> options)
        : base(user, context, options) { }

        public override IQueryable<RiskRiskType> Entities
        {
            get
            {
                return OrbContext.RiskRiskTypes;
            }
        }

        public async Task<RiskRiskType> Edit(int keyValue)
        {
            return await Entities.SingleOrDefaultAsync(e => e.ID == keyValue);
        }

        public RiskRiskType Add(RiskRiskType riskRiskType)
        {
            if (ApiUserIsDepartmentRiskManager)
            {
                OrbContext.RiskRiskTypes.Add(riskRiskType);
                return riskRiskType;
            }

            var risk = OrbContext.CorporateRisks.Include(r => r.Directorate).SingleOrDefault(r => r.ID == riskRiskType.RiskID);
            if (risk != null)
            {
                if (risk.RiskRegisterID == (int)RiskRegisters.Group) // Group
                {
                    var group = OrbContext.Groups.Find(risk.Directorate.GroupID);
                    if (ApiUserAdminGroupRisks.Contains(risk.Directorate.GroupID) || group.RiskChampionDeputyDirectorUserID == ApiUser.ID)
                    {
                        OrbContext.RiskRiskTypes.Add(riskRiskType);
                        return riskRiskType;
                    }
                }

                if (risk.RiskRegisterID == (int)RiskRegisters.Directorate) // Directorate
                {
                    if (ApiUserAdminGroupRisks.Contains(risk.Directorate.GroupID) || ApiUserAdminDirectorateRisks.Contains((int)risk.DirectorateID))
                    {
                        OrbContext.RiskRiskTypes.Add(riskRiskType);
                        return riskRiskType;
                    }
                }
            }
            return null;
        }

        public RiskRiskType Remove(RiskRiskType riskRiskType)
        {
            if (ApiUserIsDepartmentRiskManager)
            {
                OrbContext.RiskRiskTypes.Remove(riskRiskType);
                return riskRiskType;
            }

            var risk = OrbContext.CorporateRisks.Include(r => r.Directorate).SingleOrDefault(r => r.ID == riskRiskType.RiskID);
            if (risk != null)
            {
                if (risk.RiskRegisterID == (int)RiskRegisters.Group) // Group
                {
                    var group = OrbContext.Groups.Find(risk.Directorate.GroupID);
                    if (ApiUserAdminGroupRisks.Contains(risk.Directorate.GroupID) || group.RiskChampionDeputyDirectorUserID == ApiUser.ID)
                    {
                        OrbContext.RiskRiskTypes.Remove(riskRiskType);
                        return riskRiskType;
                    }
                }

                if (risk.RiskRegisterID == (int)RiskRegisters.Directorate) // Directorate
                {
                    if (ApiUserAdminGroupRisks.Contains(risk.Directorate.GroupID) || ApiUserAdminDirectorateRisks.Contains((int)risk.DirectorateID))
                    {
                        OrbContext.RiskRiskTypes.Remove(riskRiskType);
                        return riskRiskType;
                    }
                }
            }

            return null;
        }

        public void RemoveRange(IEnumerable<RiskRiskType> riskRiskTypes)
        {
            OrbContext.RiskRiskTypes.RemoveRange(riskRiskTypes);
        }
    }
}