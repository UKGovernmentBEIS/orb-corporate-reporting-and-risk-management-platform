using ORB.Core.Models;
using System;
using System.Collections.Generic;

namespace ORB.Core.Services
{
    public interface IMetricService : IReportingEntityService<Metric>
    {
        ICollection<Metric> MetricsDueInDirectoratePeriod(int directorateId, Period period);
        ICollection<Metric> MetricsDueInDirectoratePeriod(int directorateId, DateTime fromDate, DateTime toDate);
    }
}