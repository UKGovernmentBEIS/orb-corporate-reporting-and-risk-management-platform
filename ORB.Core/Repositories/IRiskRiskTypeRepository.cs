using System.Collections.Generic;
using ORB.Core.Models;

namespace ORB.Core.Repositories
{
    public interface IRiskRiskTypeRepository : IEntityRepository<RiskRiskType>
    {
        void RemoveRange(IEnumerable<RiskRiskType> riskRiskTypes);
    }
}