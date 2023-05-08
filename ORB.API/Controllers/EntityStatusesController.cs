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
    public class EntityStatusesController : BaseEntityController<EntityStatus>
    {
        public EntityStatusesController(ILogger<BaseEntityController<EntityStatus>> logger, IEntityService<EntityStatus> context) : base(logger, context) { }

        // GET: odata/EntityStatus(5)/Benefits
        [EnableQuery]
        public IQueryable<Benefit> GetBenefits([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.Benefits);
        }

        // GET: odata/EntityStatus(5)/Commitments
        [EnableQuery]
        public IQueryable<Commitment> GetCommitments([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.Commitments);
        }

        // GET: odata/EntityStatus(5)/Dependencies
        [EnableQuery]
        public IQueryable<Dependency> GetDependencies([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.Dependencies);
        }

        // GET: odata/EntityStatus(5)/Directorates
        [EnableQuery]
        public IQueryable<Directorate> GetDirectorates([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.Directorates);
        }

        // GET: odata/EntityStatus(5)/KeyWorkAreas
        [EnableQuery]
        public IQueryable<KeyWorkArea> GetKeyWorkAreas([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.KeyWorkAreas);
        }

        // GET: odata/EntityStatus(5)/Metrics
        [EnableQuery]
        public IQueryable<Metric> GetMetrics([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.Metrics);
        }

        // GET: odata/EntityStatus(5)/Milestones
        [EnableQuery]
        public IQueryable<Milestone> GetMilestones([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.Milestones);
        }

        // GET: odata/EntityStatus(5)/Projects
        [EnableQuery]
        public IQueryable<Project> GetProjects([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.Projects);
        }

        // GET: odata/EntityStatus(5)/WorkStreams
        [EnableQuery]
        public IQueryable<WorkStream> GetWorkStreams([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.WorkStreams);
        }
    }
}
