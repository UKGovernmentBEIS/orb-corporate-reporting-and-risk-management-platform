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
    public class ProjectUpdatesController : BaseEntityUpdateController<ProjectUpdate>
    {
        public ProjectUpdatesController(ILogger<ProjectUpdatesController> logger, IEntityUpdateService<ProjectUpdate> service) : base(logger, service) { }

        // GET: odata/ProjectUpdates
        [EnableQuery(MaxExpansionDepth = 3)]
        public IQueryable<ProjectUpdate> GetProjectUpdates()
        {
            return _service.Entities;
        }

        // GET: odata/ProjectUpdates(5)/Project
        [EnableQuery]
        public SingleResult<Project> GetProject([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.Project));
        }

        // GET: odata/ProjectUpdates(5)/FinanceRagOption
        [EnableQuery]
        public SingleResult<RagOption> GetFinanceRagOption([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.FinanceRagOption));
        }

        // GET: odata/ProjectUpdates(5)/BenefitsRagOption
        [EnableQuery]
        public SingleResult<RagOption> GetBenefitsRagOption([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.BenefitsRagOption));
        }

        // GET: odata/ProjectUpdates(5)/MilestonesRagOption
        [EnableQuery]
        public SingleResult<RagOption> GetMilestonesRagOption([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.MilestonesRagOption));
        }

        // GET: odata/ProjectUpdates(5)/OverallRagOption
        [EnableQuery]
        public SingleResult<RagOption> GetOverallRagOption([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.OverallRagOption));
        }

        // GET: odata/ProjectUpdates(5)/PeopleRagOption
        [EnableQuery]
        public SingleResult<RagOption> GetPeopleRagOption([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.PeopleRagOption));
        }

        // GET: odata/ProjectUpdates(5)/UpdateUser
        [EnableQuery]
        public SingleResult<User> GetUpdateUser([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.UpdateUser));
        }
    }
}
