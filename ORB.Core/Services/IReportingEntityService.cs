using ORB.Core.Models;
using System.Collections.Generic;

namespace ORB.Core.Services
{
    public interface IReportingEntityService<T> : IEntityService<T> where T : ReportingEntity
    {
        ICollection<T> EntitiesWithReportingCycle(IReportingCycle reportingCycle);
        ICollection<T> EntitiesWithReportingCycle2(IReportingCycle reportingCycle, out int totalEntities, out int totalWithFilter, out string repType);
    }
}