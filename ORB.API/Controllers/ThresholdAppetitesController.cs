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
    public class ThresholdAppetitesController : BaseEntityController<ThresholdAppetite>
    {
        public ThresholdAppetitesController(ILogger<ThresholdAppetitesController> logger, IEntityService<ThresholdAppetite> service) : base(logger, service) { }

        // GET: odata/ThresholdAppetites(5)/RiskImpactLevel
        [EnableQuery]
        public SingleResult<RiskImpactLevel> GetRiskImpactLevel([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.RiskImpactLevel));
        }

        // GET: odata/ThresholdAppetites(5)/RiskProbability
        [EnableQuery]
        public SingleResult<RiskProbability> GetRiskProbability([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.RiskProbability));
        }
    }
}
