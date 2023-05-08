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
    public class RiskTypesController : BaseEntityController<RiskType>
    {
        public RiskTypesController(ILogger<RiskTypesController> logger, IEntityService<RiskType> service) : base(logger, service) { }

        // GET: odata/RiskTypes(5)/RiskRiskTypes
        [EnableQuery]
        public IQueryable<RiskRiskType> GetRiskRiskTypes([FromODataUri] int key)
        {
            return _service.Entities.Where(r => r.ID == key).SelectMany(r => r.RiskRiskTypes);
        }
    }
}
