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
    public class MeasurementUnitsController : BaseEntityController<MeasurementUnit>
    {
        public MeasurementUnitsController(ILogger<MeasurementUnitsController> logger, IEntityService<MeasurementUnit> service) : base(logger, service) { }

        // GET: odata/MeasurementUnits(5)/Benefits
        [EnableQuery]
        public IQueryable<Benefit> GetBenefits([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.Benefits);
        }

        // GET: odata/MeasurementUnits(5)/Metrics
        [EnableQuery]
        public IQueryable<Metric> GetMetrics([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.Metrics);
        }
    }
}
