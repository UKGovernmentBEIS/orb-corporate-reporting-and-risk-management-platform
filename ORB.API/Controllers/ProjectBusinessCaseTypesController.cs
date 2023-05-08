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
    public class ProjectBusinessCaseTypesController : BaseEntityController<ProjectBusinessCaseType>
    {
        public ProjectBusinessCaseTypesController(ILogger<ProjectBusinessCaseTypesController> logger, IEntityService<ProjectBusinessCaseType> service) : base(logger, service) { }

        // GET: odata/ProjectBusinessCaseTypes(5)/ProjectUpdates
        [EnableQuery]
        public IQueryable<ProjectUpdate> GetProjectUpdates([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.ProjectUpdates);
        }
    }
}
