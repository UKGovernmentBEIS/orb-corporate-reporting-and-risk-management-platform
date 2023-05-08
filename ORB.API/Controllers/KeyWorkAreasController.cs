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
    public class KeyWorkAreasController : BaseEntityController<KeyWorkArea>
    {
        public KeyWorkAreasController(ILogger<KeyWorkAreasController> logger, IEntityService<KeyWorkArea> service) : base(logger, service) { }

        // GET: odata/KeyWorkAreas
        [EnableQuery(MaxExpansionDepth = 3)]
        public IQueryable<KeyWorkArea> GetKeyWorkAreas()
        {
            return _service.Entities;
        }

        #region Navigation property methods

        // GET: odata/KeyWorkAreas(5)/Directorate
        [EnableQuery]
        public SingleResult<Directorate> GetDirectorate([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.Directorate));
        }

        // GET: odata/KeyWorkAreas(5)/RagOption
        [EnableQuery]
        public SingleResult<RagOption> GetRagOption([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.RagOption));
        }

        // GET: odata/KeyWorkAreas(5)/User
        [EnableQuery]
        public SingleResult<User> GetUser([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.LeadUser));
        }

        // GET: odata/KeyWorkAreas(5)/KeyWorkAreaUpdates
        [EnableQuery]
        public IQueryable<KeyWorkAreaUpdate> GetKeyWorkAreaUpdates([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.KeyWorkAreaUpdates);
        }

        // GET: odata/KeyWorkAreas(5)/Milestones
        [EnableQuery]
        public IQueryable<Milestone> GetMilestones([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.Milestones);
        }

        // GET: odata/KeyWorkAreas(5)/Contributors
        [EnableQuery]
        public IQueryable<Contributor> GetContributors([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.Contributors);
        }

        #endregion
    }
}
