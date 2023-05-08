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
    public class PartnerOrganisationUpdatesController : BaseEntityUpdateController<PartnerOrganisationUpdate>
    {
        public PartnerOrganisationUpdatesController(ILogger<PartnerOrganisationUpdatesController> logger, IEntityUpdateService<PartnerOrganisationUpdate> service) : base(logger, service) { }

        // GET: odata/PartnerOrganisationUpdates(5)/PartnerOrganisation
        [EnableQuery]
        public SingleResult<PartnerOrganisation> GetPartnerOrganisation([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.PartnerOrganisation));
        }

        // GET: odata/PartnerOrganisationUpdates(5)/KPIRagOption
        [EnableQuery]
        public SingleResult<RagOption> GetKPIRagOption([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.KPIRagOption));
        }

        // GET: odata/PartnerOrganisationUpdates(5)/FinanceRagOption
        [EnableQuery]
        public SingleResult<RagOption> GetFinanceRagOption([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.FinanceRagOption));
        }

        // GET: odata/PartnerOrganisationUpdates(5)/MilestonesRagOption
        [EnableQuery]
        public SingleResult<RagOption> GetMilestonesRagOption([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.MilestonesRagOption));
        }

        // GET: odata/PartnerOrganisationUpdates(5)/OverallRagOption
        [EnableQuery]
        public SingleResult<RagOption> GetOverallRagOption([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.OverallRagOption));
        }

        // GET: odata/PartnerOrganisationUpdates(5)/PeopleRagOption
        [EnableQuery]
        public SingleResult<RagOption> GetPeopleRagOption([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.PeopleRagOption));
        }
    }
}
