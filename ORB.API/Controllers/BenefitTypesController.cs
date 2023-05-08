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
    public class BenefitTypesController : BaseEntityController<BenefitType>
    {
        public BenefitTypesController(ILogger<BenefitTypesController> logger, IEntityService<BenefitType> service) : base(logger, service) { }

        // GET: odata/BenefitTypes(5)/Benefits
        [EnableQuery]
        public IQueryable<Benefit> GetBenefits([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.Benefits);
        }
    }
}
