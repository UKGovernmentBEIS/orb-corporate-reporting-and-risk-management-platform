using Microsoft.AspNet.OData;
using Microsoft.AspNet.OData.Routing;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Microsoft.OData;
using ORB.Core;
using ORB.Core.Models;
using ORB.Core.Services;
using ORB.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ORB.API.Controllers
{
    [Authorize]
    public class ProjectsController : BaseEntityController<Project>
    {
        private readonly IProjectService _projectService;

        public ProjectsController(ILogger<ProjectsController> logger, IProjectService service) : base(logger, service)
        {
            _projectService = service;
        }

        // GET: odata/Projects/GetProjectsDueInPeriod(DirectorateId=2,Period=1)
        [EnableQuery]
        [ODataRoute("Projects/GetProjectsDueInPeriod(DirectorateId={directorateId},Period={period})")]
        public ICollection<Project> GetProjectsDueInPeriod([FromODataUri] int directorateId, [FromODataUri] byte period)
        {
            return _projectService.ProjectsDueInDirectoratePeriod(directorateId, period == (byte)Period.Previous ? Period.Previous : Period.Current);
        }

        #region Navigation property methods

        // GET: odata/Projects(5)/Benefits
        [EnableQuery]
        public IQueryable<Benefit> GetBenefits([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.Benefits);
        }

        // GET: odata/Projects(5)/ChildProjects
        [EnableQuery]
        public IQueryable<Project> GetChildProjects([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.ChildProjects);
        }

        // GET: odata/Projects(5)/Dependencies
        [EnableQuery]
        public IQueryable<Dependency> GetDependencies([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.Dependencies);
        }

        // GET: odata/Projects(5)/ProjectManagerUser
        [EnableQuery]
        public SingleResult<User> GetProjectManagerUser([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.ProjectManagerUser));
        }

        // GET: odata/Projects(5)/ProjectUpdates
        [EnableQuery]
        public IQueryable<ProjectUpdate> GetProjectUpdates([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.ProjectUpdates);
        }

        // GET: odata/Projects(5)/CorporateRisks
        [EnableQuery]
        public IQueryable<CorporateRisk> GetCorporateRisks([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.CorporateRisks);
        }

        // GET: odata/Projects(5)/SeniorResponsibleOwnerUser
        [EnableQuery]
        public SingleResult<User> GetSeniorResponsibleOwnerUser([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.SeniorResponsibleOwnerUser));
        }

        // GET: odata/Projects(5)/SignOffs
        [EnableQuery]
        public IQueryable<SignOff> GetSignOffs([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.SignOffs);
        }

        // GET: odata/Projects(5)/UserProjects
        [EnableQuery]
        public IQueryable<UserProject> GetUserProjects([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.UserProjects);
        }

        // GET: odata/Projects(5)/WorkStreams
        [EnableQuery]
        public IQueryable<WorkStream> GetWorkStreams([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.WorkStreams);
        }

        #endregion
    }
}
