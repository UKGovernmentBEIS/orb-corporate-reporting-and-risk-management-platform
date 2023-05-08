using ORB.Core.Models;
using System;
using System.Collections.Generic;

namespace ORB.Core.Services
{
    public interface IProjectService : IReportingEntityService<Project>
    {
        ICollection<Project> ProjectsDueInDirectoratePeriod(int directorateId, Period period);
        ICollection<Project> ProjectsDueInDirectoratePeriod(int directorateId, DateTime fromDate, DateTime toDate);
    }
}