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
    public class CommitmentUpdatesController : BaseEntityUpdateController<CommitmentUpdate>
    {
        public CommitmentUpdatesController(ILogger<CommitmentUpdatesController> logger, IEntityUpdateService<CommitmentUpdate> service) : base(logger, service) { }

        // GET: odata/CommitmentUpdates(5)/Commitment
        [EnableQuery]
        public SingleResult<Commitment> GetCommitment([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.Commitment));
        }

        // GET: odata/CommitmentUpdates(5)/RagOption
        [EnableQuery]
        public SingleResult<RagOption> GetRagOption([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.RagOption));
        }

        // GET: odata/CommitmentUpdates(5)/SignOff
        [EnableQuery]
        public SingleResult<SignOff> GetSignOff([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.SignOff));
        }

        // GET: odata/CommitmentUpdates(5)/UpdateUser
        [EnableQuery]
        public SingleResult<User> GetUser([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.UpdateUser));
        }
    }
}
