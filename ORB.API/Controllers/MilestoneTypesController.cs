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
    public class MilestoneTypesController : BaseEntityController<MilestoneType>
    {
        public MilestoneTypesController(ILogger<MilestoneTypesController> logger, IEntityService<MilestoneType> service) : base(logger, service) { }

        // GET: odata/MilestoneTypes(5)/Milestones
        [EnableQuery]
        public IQueryable<Milestone> GetMilestones([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.Milestones);
        }
    }
}
