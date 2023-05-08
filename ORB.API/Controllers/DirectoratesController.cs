using Microsoft.AspNet.OData;
using Microsoft.AspNet.OData.Routing;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
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
    public class DirectoratesController : BaseEntityController<Directorate>
    {
        public DirectoratesController(ILogger<DirectoratesController> logger, IEntityService<Directorate> context) : base(logger, context) { }

        #region Navigation property methods

        // GET: odata/Directorates(5)/Group
        [EnableQuery]
        public SingleResult<Group> GetGroup([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.Group));
        }

        // GET: odata/Directorates(5)/DirectorUser
        [EnableQuery]
        public SingleResult<User> GetDirectorUser([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.DirectorUser));
        }

        // GET: odata/Directorates(5)/DirectorateUpdates
        [EnableQuery]
        public IQueryable<DirectorateUpdate> GetDirectorateUpdates([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.DirectorateUpdates);
        }

        // GET: odata/Directorates(5)/KeyWorkAreas
        [EnableQuery]
        public IQueryable<KeyWorkArea> GetKeyWorkAreas([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.KeyWorkAreas);
        }

        // GET: odata/Directorates(5)/UserDirectorates
        [EnableQuery]
        public IQueryable<UserDirectorate> GetUserDirectorates([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.UserDirectorates);
        }

        // GET: odata/Directorates(5)/SignOffs
        [EnableQuery]
        public IQueryable<SignOff> GetSignOffs([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.SignOffs);
        }

        // GET: odata/Directorates(5)/Metrics
        [EnableQuery]
        public IQueryable<Metric> GetMetrics([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.Metrics);
        }

        // GET: odata/Directorates(5)/Commitments
        [EnableQuery]
        public IQueryable<Commitment> GetCommitments([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.Commitments);
        }

        // GET: odata/Directorates(5)/PartnerOrganisations
        [EnableQuery]
        public IQueryable<PartnerOrganisation> GetPartnerOrganisations([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.PartnerOrganisations);
        }

        // GET: odata/Directorates(5)/Projects
        [EnableQuery]
        public IQueryable<Project> GetProjects([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.Projects);
        }

        // GET: odata/Directorates(5)/CorporateRisks
        [EnableQuery]
        public IQueryable<CorporateRisk> GetCorporateRisks([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.CorporateRisks);
        }

        #endregion
    }
}
