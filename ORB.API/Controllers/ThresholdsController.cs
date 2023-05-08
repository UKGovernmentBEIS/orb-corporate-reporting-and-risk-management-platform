using Microsoft.AspNet.OData;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Microsoft.OData;
using ORB.Core.Models;
using ORB.Core.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ORB.API.Controllers
{
    [Authorize]
    public class ThresholdsController : BaseEntityController<Threshold>
    {
        public ThresholdsController(ILogger<ThresholdsController> logger, IEntityService<Threshold> service) : base(logger, service) { }

        // GET: odata/Threshold(5)/RiskType
        [EnableQuery]
        public IQueryable<RiskType> GetRiskTypes([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.RiskTypes);
        }

        // GET: odata/Threshold(5)/ThresholdAppetites
        [EnableQuery]
        public IQueryable<ThresholdAppetite> GetThresholdAppetites([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.ThresholdAppetites);
        }
    }
}
