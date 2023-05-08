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
    public class KeyWorkAreaUpdatesController : BaseEntityUpdateController<KeyWorkAreaUpdate>
    {
        public KeyWorkAreaUpdatesController(ILogger<KeyWorkAreaUpdatesController> logger, IEntityUpdateService<KeyWorkAreaUpdate> service) : base(logger, service) { }

        // GET: odata/KeyWorkAreaUpdates(5)/KeyWorkArea
        [EnableQuery]
        public SingleResult<KeyWorkArea> GetKeyWorkArea([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.KeyWorkArea));
        }

        // GET: odata/KeyWorkAreaUpdates(5)/RagOption
        [EnableQuery]
        public SingleResult<RagOption> GetRagOption([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.RagOption));
        }
    }
}
