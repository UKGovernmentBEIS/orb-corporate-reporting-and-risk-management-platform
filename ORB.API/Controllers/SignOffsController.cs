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
    public class SignOffsController : BaseController<SignOff, ISignOffService>
    {
        public SignOffsController(ILogger<SignOffsController> logger, ISignOffService service) : base(logger, service) { }

        // POST: odata/Entities
        public async Task<IActionResult> Post([FromBody] SignOff signOff)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var addedSignOff = await _service.Add(signOff);
            if (addedSignOff == null)
            {
                return Unauthorized();
            }

            return Created(addedSignOff);
        }

        #region Navigation property methods

        // GET: odata/SignOffs(5)/BenefitUpdates
        [EnableQuery]
        public IQueryable<BenefitUpdate> GetBenefitUpdates([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.BenefitUpdates);
        }

        // GET: odata/SignOffs(5)/DirectorateUpdates
        [EnableQuery]
        public IQueryable<DirectorateUpdate> GetDirectorateUpdates([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.DirectorateUpdates);
        }

        // GET: odata/SignOffs(5)/KeyWorkAreaUpdates
        [EnableQuery]
        public IQueryable<KeyWorkAreaUpdate> GetKeyWorkAreaUpdates([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.KeyWorkAreaUpdates);
        }

        // GET: odata/SignOffs(5)/MetricUpdates
        [EnableQuery]
        public IQueryable<MetricUpdate> GetMetricUpdates([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.MetricUpdates);
        }

        // GET: odata/SignOffs(5)/MilestoneUpdates
        [EnableQuery]
        public IQueryable<MilestoneUpdate> GetMilestoneUpdates([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.MilestoneUpdates);
        }

        // GET: odata/SignOffs(5)/ProjectUpdates
        [EnableQuery]
        public IQueryable<ProjectUpdate> GetProjectUpdates([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.ProjectUpdates);
        }

        // GET: odata/SignOffs(5)/SignOffUser
        [EnableQuery]
        public SingleResult<User> GetSignOffUser([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.SignOffUser));
        }

        // GET: odata/SignOffs(5)/WorkStreamUpdates
        [EnableQuery]
        public IQueryable<WorkStreamUpdate> GetWorkStreamUpdates([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.WorkStreamUpdates);
        }

        #endregion
    }
}
