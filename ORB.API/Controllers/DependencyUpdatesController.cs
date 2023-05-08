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
    public class DependencyUpdatesController : BaseEntityUpdateController<DependencyUpdate>
    {
        public DependencyUpdatesController(ILogger<DependencyUpdatesController> logger, IEntityUpdateService<DependencyUpdate> service) : base(logger, service) { }

        // GET: odata/DependencyUpdates(5)/Dependency
        [EnableQuery]
        public SingleResult<Dependency> GetDependency([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.Dependency));
        }

        // GET: odata/DependencyUpdates(5)/RagOption
        [EnableQuery]
        public SingleResult<RagOption> GetRagOption([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.RagOption));
        }

        // GET: odata/DependencyUpdates(5)/SignOff
        [EnableQuery]
        public SingleResult<SignOff> GetSignOff([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.SignOff));
        }

        // GET: odata/DependencyUpdates(5)/UpdateUser
        [EnableQuery]
        public SingleResult<User> GetUpdateUser([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.UpdateUser));
        }
    }
}
