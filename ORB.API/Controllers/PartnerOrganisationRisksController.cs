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
    public class PartnerOrganisationRisksController : BaseEntityController<PartnerOrganisationRisk>
    {
        public PartnerOrganisationRisksController(ILogger<PartnerOrganisationRisksController> logger, IEntityService<PartnerOrganisationRisk> service) : base(logger, service) { }

        #region Navigation property methods

        // GET: odata/PartnerOrganisationRisks(5)/PartnerOrganisation
        [EnableQuery]
        public SingleResult<PartnerOrganisation> GetPartnerOrganisation([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.PartnerOrganisation));
        }

        // GET: odata/PartnerOrganisationRisks(5)/RagOption
        [EnableQuery]
        public SingleResult<RagOption> GetRagOption([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.RagOption));
        }

        // GET: odata/PartnerOrganisationRisks(5)/PartnerOrganisationRiskMitigationActions
        [EnableQuery]
        public IQueryable<PartnerOrganisationRiskMitigationAction> GetPartnerOrganisationRiskMitigationActions([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.PartnerOrganisationRiskMitigationActions);
        }

        // GET: odata/PartnerOrganisationRisks(5)/PartnerOrganisationRiskOwnerUser
        [EnableQuery]
        public SingleResult<User> GetUser([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.RiskOwnerUser));
        }

        // GET: odata/PartnerOrganisationRisks(5)/PartnerOrganisationRiskUpdates
        [EnableQuery]
        public IQueryable<PartnerOrganisationRiskUpdate> GetPartnerOrganisationRiskUpdates([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.PartnerOrganisationRiskUpdates);
        }

        #endregion
    }
}
