using Microsoft.AspNet.OData;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Microsoft.OData;
using ORB.Core.Models;
using ORB.Core.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ORB.API.Controllers
{
    [Authorize]
    public class RolesController : BaseEntityController<Role>
    {
        public RolesController(ILogger<RolesController> logger, IEntityService<Role> service) : base(logger, service) { }

        // GET: odata/Roles(5)/UserRoles
        [EnableQuery]
        public IQueryable<UserRole> GetUserRoles([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.UserRoles);
        }
    }
}
