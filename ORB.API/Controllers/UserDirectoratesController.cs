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
    public class UserDirectoratesController : BaseEntityController<UserDirectorate>
    {
        public UserDirectoratesController(ILogger<UserDirectoratesController> logger, IEntityService<UserDirectorate> service) : base(logger, service) { }

        // GET: odata/UserDirectorates(5)/Directorate
        [EnableQuery]
        public SingleResult<Directorate> GetDirectorate([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.Directorate));
        }

        // GET: odata/UserDirectorates(5)/User
        [EnableQuery]
        public SingleResult<User> GetUser([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.User));
        }
    }
}
