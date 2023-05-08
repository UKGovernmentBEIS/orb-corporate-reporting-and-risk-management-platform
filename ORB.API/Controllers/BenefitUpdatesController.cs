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
    public class BenefitUpdatesController : BaseEntityUpdateController<BenefitUpdate>
    {
        public BenefitUpdatesController(ILogger<BenefitUpdatesController> logger, IEntityUpdateService<BenefitUpdate> service) : base(logger, service) { }

        // GET: odata/BenefitUpdates(5)/Benefit
        [EnableQuery]
        public SingleResult<Benefit> GetBenefit([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.Benefit));
        }

        // GET: odata/BenefitUpdates(5)/RagOption
        [EnableQuery]
        public SingleResult<RagOption> GetRagOption([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.RagOption));
        }
    }
}
