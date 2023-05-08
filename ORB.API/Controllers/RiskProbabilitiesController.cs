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
    public class RiskProbabilitiesController : BaseEntityController<RiskProbability>
    {
        public RiskProbabilitiesController(ILogger<RiskProbabilitiesController> logger, IEntityService<RiskProbability> service) : base(logger, service) { }

        // GET: odata/RiskProbabilities(5)/CorporateRiskUpdates
        [EnableQuery]
        public IQueryable<CorporateRiskUpdate> GetCorporateRiskUpdates([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.CorporateRiskUpdates);
        }
    }
}
