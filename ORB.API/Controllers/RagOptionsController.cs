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
    public class RagOptionsController : BaseController<RagOption, IEntityReadService<RagOption>>
    {
        public RagOptionsController(ILogger<RagOptionsController> logger, IEntityReadService<RagOption> service) : base(logger, service) { }

        // GET: odata/RagOptions(5)/KeyWorkAreas
        [EnableQuery]
        public IQueryable<KeyWorkArea> GetKeyWorkAreas([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.KeyWorkAreas);
        }

        // GET: odata/RagOptions(5)/Milestones
        [EnableQuery]
        public IQueryable<Milestone> GetMilestones([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.Milestones);
        }

        // GET: odata/RagOptions(5)/WorkStreams
        [EnableQuery]
        public IQueryable<WorkStream> GetWorkStreams([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.WorkStreams);
        }
    }
}
