using ORB.Core.Models;
using System;
using System.Collections.Generic;

namespace ORB.Core.Services
{
    public interface IBenefitService : IReportingEntityService<Benefit>
    {
        ICollection<Benefit> BenefitsDueInProjectPeriod(int projectId, Period period);
        ICollection<Benefit> BenefitsDueInProjectPeriod(int projectId, DateTime fromDate, DateTime toDate);
    }
}
