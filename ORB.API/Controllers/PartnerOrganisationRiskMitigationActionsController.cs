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
    public class PartnerOrganisationRiskMitigationActionsController : BaseEntityController<PartnerOrganisationRiskMitigationAction>
    {
        public PartnerOrganisationRiskMitigationActionsController(ILogger<PartnerOrganisationRiskMitigationActionsController> logger, IEntityService<PartnerOrganisationRiskMitigationAction> service) : base(logger, service) { }

        #region Navigation property methods

        // GET: odata/PartnerOrganisationRiskMitigationActions(5)/PartnerOrganisationRisk
        [EnableQuery]
        public SingleResult<PartnerOrganisationRisk> GetPartnerOrganisationRisk([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.PartnerOrganisationRisk));
        }

        // GET: odata/PartnerOrganisationRiskMitigationActions(5)/OwnerUser
        [EnableQuery]
        public SingleResult<User> GetOwnerUser([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.OwnerUser));
        }

        // GET: odata/PartnerOrganisationRiskMitigationActions(5)/PartnerOrganisationRiskMitigationActionUpdates
        [EnableQuery]
        public IQueryable<PartnerOrganisationRiskMitigationActionUpdate> GetPartnerOrganisationRiskMitigationActionUpdates([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.PartnerOrganisationRiskMitigationActionUpdates);
        }

        #endregion
    }
}
