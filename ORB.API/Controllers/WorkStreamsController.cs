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
    public class WorkStreamsController : BaseEntityController<WorkStream>
    {
        public WorkStreamsController(ILogger<WorkStreamsController> logger, IEntityService<WorkStream> service) : base(logger, service) { }

        #region Navigation property methods

        // GET: odata/WorkStreams
        [EnableQuery(MaxExpansionDepth = 3)]
        public IQueryable<WorkStream> GetWorkStreams()
        {
            return _service.Entities;
        }

        // GET: odata/WorkStreams(5)/Milestones
        [EnableQuery]
        public IQueryable<Milestone> GetMilestones([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.Milestones);
        }

        // GET: odata/WorkStreams(5)/Project
        [EnableQuery]
        public SingleResult<Project> GetProject([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.Project));
        }

        // GET: odata/WorkStreams(5)/RagOption
        [EnableQuery]
        public SingleResult<RagOption> GetRagOption([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.RagOption));
        }

        // GET: odata/WorkStreams(5)/LeadUser
        [EnableQuery]
        public SingleResult<User> GetUser([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.LeadUser));
        }

        // GET: odata/WorkStreams(5)/Contributors
        [EnableQuery]
        public IQueryable<Contributor> GetContributors([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.Contributors);
        }

        // GET: odata/WorkStreams(5)/WorkStreamUpdates
        [EnableQuery]
        public IQueryable<WorkStreamUpdate> GetWorkStreamUpdates([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.WorkStreamUpdates);
        }

        #endregion
    }
}
