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
    public class CommitmentsController : BaseEntityController<Commitment>
    {
        public CommitmentsController(ILogger<CommitmentsController> logger, IEntityService<Commitment> service) : base(logger, service) { }

        #region Navigation property methods

        // GET: odata/Commitments(5)/Directorate
        [EnableQuery]
        public SingleResult<Directorate> GetDirectorate([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.Directorate));
        }

        // GET: odata/Commitments(5)/RagOption
        [EnableQuery]
        public SingleResult<RagOption> GetRagOption([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.RagOption));
        }

        // GET: odata/Commitments(5)/User
        [EnableQuery]
        public SingleResult<User> GetUser([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.LeadUser));
        }

        // GET: odata/Commitments(5)/CommitmentUpdates
        [EnableQuery]
        public IQueryable<CommitmentUpdate> GetCommitmentUpdates([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.CommitmentUpdates);
        }

        // GET: odata/Commitments(5)/Contributors
        [EnableQuery]
        public IQueryable<Contributor> GetContributors([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.Contributors);
        }

        #endregion
    }
}
