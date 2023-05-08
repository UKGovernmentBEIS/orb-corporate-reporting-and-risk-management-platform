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
    public class PartnerOrganisationsController : BaseEntityController<PartnerOrganisation>
    {
        public PartnerOrganisationsController(ILogger<PartnerOrganisationsController> logger, IEntityService<PartnerOrganisation> service) : base(logger, service) { }

        #region Navigation property methods

        // GET: odata/PartnerOrganisations(5)/Directorate
        [EnableQuery]
        public SingleResult<Directorate> GetDirectorate([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.Directorate));
        }

        // GET: odata/PartnerOrganisations(5)/Milestones
        [EnableQuery]
        public IQueryable<Milestone> GetMilestones([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.Milestones);
        }

        // GET: odata/PartnerOrganisations(5)/PartnerOrganisationRisks
        [EnableQuery]
        public IQueryable<PartnerOrganisationRisk> GetPartnerOrganisationRisks([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.PartnerOrganisationRisks);
        }

        // GET: odata/PartnerOrganisations(5)/PartnerOrganisationUpdates
        [EnableQuery]
        public IQueryable<PartnerOrganisationUpdate> GetPartnerOrganisationUpdates([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.PartnerOrganisationUpdates);
        }

        // GET: odata/PartnerOrganisations(5)/SignOffs
        [EnableQuery]
        public IQueryable<SignOff> GetSignOffs([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.SignOffs);
        }

        // GET: odata/PartnerOrganisations(5)/UserPartnerOrganisations
        [EnableQuery]
        public IQueryable<UserPartnerOrganisation> GetUserPartnerOrganisations([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.UserPartnerOrganisations);
        }

        #endregion
    }
}
