using System.Collections.Generic;
using ORB.Core.Models;

namespace ORB.Core.Repositories
{
    public interface IRiskRiskMitigationActionRepository<T> : IEntityRepository<T> where T : RiskRiskMitigationAction
    {
        void RemoveRange(IEnumerable<T> riskRiskMitigationActions);
    }
}