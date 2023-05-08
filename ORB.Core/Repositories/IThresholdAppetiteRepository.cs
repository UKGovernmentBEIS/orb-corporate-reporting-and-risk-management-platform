using System.Collections.Generic;
using ORB.Core.Models;

namespace ORB.Core.Repositories
{
    public interface IThresholdAppetiteRepository : IEntityRepository<ThresholdAppetite>
    {
        void RemoveRange(IEnumerable<ThresholdAppetite> thresholdAppetites);
    }
}