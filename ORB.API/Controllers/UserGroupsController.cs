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
    public class UserGroupsController : BaseEntityController<UserGroup>
    {
        public UserGroupsController(ILogger<UserGroupsController> logger, IEntityService<UserGroup> service) : base(logger, service) { }

        // GET: odata/UserGroups(5)/Group
        [EnableQuery]
        public SingleResult<Group> GetGroup([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.Group));
        }

        // GET: odata/UserGroups(5)/User
        [EnableQuery]
        public SingleResult<User> GetUser([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.User));
        }
    }
}
