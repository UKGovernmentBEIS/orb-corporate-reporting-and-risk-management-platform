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
    public class DirectorateUpdatesController : BaseEntityUpdateController<DirectorateUpdate>
    {
        public DirectorateUpdatesController(ILogger<DirectorateUpdatesController> logger, IEntityUpdateService<DirectorateUpdate> service) : base(logger, service) { }

        // GET: odata/DirectorateUpdates(5)/Directorate
        [EnableQuery]
        public SingleResult<Directorate> GetDirectorate([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.Directorate));
        }

        // GET: odata/DirectorateUpdates(5)/MetricsRagOption
        [EnableQuery]
        public SingleResult<RagOption> GetMetricsRagOption([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.MetricsRagOption));
        }

        // GET: odata/DirectorateUpdates(5)/FinanceRagOption
        [EnableQuery]
        public SingleResult<RagOption> GetFinanceRagOption([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.FinanceRagOption));
        }

        // GET: odata/DirectorateUpdates(5)/MilestonesRagOption
        [EnableQuery]
        public SingleResult<RagOption> GetMilestonesRagOption([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.MilestonesRagOption));
        }

        // GET: odata/DirectorateUpdates(5)/OverallRagOption
        [EnableQuery]
        public SingleResult<RagOption> GetOverallRagOption([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.OverallRagOption));
        }

        // GET: odata/DirectorateUpdates(5)/PeopleRagOption
        [EnableQuery]
        public SingleResult<RagOption> GetPeopleRagOption([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.PeopleRagOption));
        }
    }
}
