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
    public class ReportingEntitiesController : BaseEntityController<CustomReportingEntity>
    {
        public ReportingEntitiesController(ILogger<ReportingEntitiesController> logger, IEntityService<CustomReportingEntity> service) : base(logger, service) { }

        // GET: odata/ReportingEntities(5)/ReportingEntityUpdates
        [EnableQuery]
        public IQueryable<CustomReportingEntityUpdate> GetReportingEntityUpdates([FromODataUri] int key)
        {
            return _service.Entities.Where(e => e.ID == key).SelectMany(e => e.ReportingEntityUpdates);
        }
    }
}
