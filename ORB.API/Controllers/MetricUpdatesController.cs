using Microsoft.AspNet.OData;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using ORB.Core.Models;
using ORB.Core.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ORB.API.Controllers
{
    [Authorize]
    public class MetricUpdatesController : BaseEntityUpdateController<MetricUpdate>
    {
        public MetricUpdatesController(ILogger<MetricUpdatesController> logger, IEntityUpdateService<MetricUpdate> service) : base(logger, service) { }

        // GET: odata/MetricUpdates(5)/Metric
        [EnableQuery]
        public SingleResult<Metric> GetMetric([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.Metric));
        }

        // GET: odata/MetricUpdates(5)/RagOption
        [EnableQuery]
        public SingleResult<RagOption> GetRagOption([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.RagOption));
        }
    }
}
