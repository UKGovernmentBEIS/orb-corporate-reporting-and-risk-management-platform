using Microsoft.AspNet.OData;
using Microsoft.AspNet.OData.Routing;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using ORB.Core;
using ORB.Core.Models;
using ORB.Core.Services;
using ORB.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ORB.API.Controllers
{
    [Authorize]
    public class MilestonesController : BaseEntityController<Milestone>
    {
        public MilestonesController(ILogger<MilestonesController> logger, IEntityService<Milestone> service) : base(logger, service) { }

        #region Navigation property methods

        // GET: odata/Milestones(5)/KeyWorkArea
        [EnableQuery]
        public SingleResult<KeyWorkArea> GetKeyWorkArea([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.KeyWorkArea));
        }

        // GET: odata/Milestones(5)/RagOption
        [EnableQuery]
        public SingleResult<RagOption> GetRagOption([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.RagOption));
        }

        // GET: odata/Milestones(5)/LeadUser
        [EnableQuery]
        public SingleResult<User> GetLeadUser([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.LeadUser));
        }

        // GET: odata/Milestones(5)/WorkStream
        [EnableQuery]
        public SingleResult<WorkStream> GetWorkStream([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.WorkStream));
        }

        // GET: odata/Milestones(5)/MilestoneUpdates
        [EnableQuery]
        public IQueryable<MilestoneUpdate> GetMilestoneUpdates([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.MilestoneUpdates);
        }

        // GET: odata/Milestones(5)/Contributors
        [EnableQuery]
        public IQueryable<Contributor> GetContributors([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.Contributors);
        }

        #endregion
    }
}
