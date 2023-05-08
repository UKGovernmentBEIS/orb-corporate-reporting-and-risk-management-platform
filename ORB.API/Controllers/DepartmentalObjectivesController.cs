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
    public class DepartmentalObjectivesController : BaseEntityController<DepartmentalObjective>
    {
        public DepartmentalObjectivesController(ILogger<DepartmentalObjectivesController> logger, IEntityService<DepartmentalObjective> context) : base(logger, context) { }

        // GET: odata/DepartmentalObjectives(5)/Risks
        [EnableQuery]
        public IQueryable<CorporateRisk> GetRisks([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.Risks);
        }
    }
}
