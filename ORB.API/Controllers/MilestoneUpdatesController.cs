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
    public class MilestoneUpdatesController : BaseEntityUpdateController<MilestoneUpdate>
    {
        public MilestoneUpdatesController(ILogger<MilestoneUpdatesController> logger, IEntityUpdateService<MilestoneUpdate> service) : base(logger, service) { }

        // GET: odata/MilestoneUpdates(5)/Milestone
        [EnableQuery]
        public SingleResult<Milestone> GetMilestone([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.Milestone));
        }

        // GET: odata/MilestoneUpdates(5)/RagOption
        [EnableQuery]
        public SingleResult<RagOption> GetRagOption([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.RagOption));
        }
    }
}
