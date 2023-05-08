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
    public class GroupsController : BaseEntityController<Group>
    {
        public GroupsController(ILogger<GroupsController> logger, IEntityService<Group> service) : base(logger, service) { }

        // GET: odata/Groups(5)/Directorates
        [EnableQuery]
        public IQueryable<Directorate> GetDirectorates([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.Directorates);
        }
    }
}
