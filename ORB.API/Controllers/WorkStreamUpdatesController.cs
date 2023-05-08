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
    public class WorkStreamUpdatesController : BaseEntityUpdateController<WorkStreamUpdate>
    {
        public WorkStreamUpdatesController(ILogger<WorkStreamUpdatesController> logger, IEntityUpdateService<WorkStreamUpdate> service) : base(logger, service) { }

        // GET: odata/WorkStreamUpdates(5)/RagOption
        [EnableQuery]
        public SingleResult<RagOption> GetRagOption([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.RagOption));
        }

        // GET: odata/WorkStreamUpdates(5)/UpdateUser
        [EnableQuery]
        public SingleResult<User> GetUpdateUser([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.UpdateUser));
        }

        // GET: odata/WorkStreamUpdates(5)/WorkStream
        [EnableQuery]
        public SingleResult<WorkStream> GetWorkStream([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.WorkStream));
        }
    }
}
