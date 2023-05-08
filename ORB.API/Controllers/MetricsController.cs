using Microsoft.AspNet.OData;
using Microsoft.AspNet.OData.Routing;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using ORB.Core;
using ORB.Core.Models;
using ORB.Core.Services;
using ORB.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ORB.API.Controllers
{
    [Authorize]
    public class MetricsController : BaseEntityController<Metric>
    {
        private readonly IMetricService _metricService;

        public MetricsController(ILogger<MetricsController> logger, IMetricService service) : base(logger, service) {
            _metricService = service;
        }

        // GET: odata/Metrics/GetMetricsDueInPeriod(DirectorateId=2,Period=1)
        [EnableQuery]
        [ODataRoute("Metrics/GetMetricsDueInPeriod(DirectorateId={directorateId},Period={period})")]
        public IEnumerable<Metric> GetMetricsDueInPeriod([FromODataUri] int directorateId, [FromODataUri] byte period)
        {
            return _metricService.MetricsDueInDirectoratePeriod(directorateId, period == (byte)Period.Previous ? Period.Previous : Period.Current);
        }

        #region Navigation property methods

        // GET: odata/Metrics(5)/Directorate
        [EnableQuery]
        public SingleResult<Directorate> GetDirectorate([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.Directorate));
        }

        // GET: odata/Metrics(5)/RagOption
        [EnableQuery]
        public SingleResult<RagOption> GetRagOption([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.RagOption));
        }

        // GET: odata/Metrics(5)/LeadUser
        [EnableQuery]
        public SingleResult<User> GetLeadUser([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.LeadUser));
        }

        // GET: odata/Metrics(5)/MetricUpdates
        [EnableQuery]
        public IQueryable<MetricUpdate> GetMetricUpdates([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.MetricUpdates);
        }

        // GET: odata/Metrics(5)/Contributors
        [EnableQuery]
        public IQueryable<Contributor> GetContributors([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.Contributors);
        }

        #endregion
    }
}
