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
    public class PartnerOrganisationRiskMitigationActionUpdatesController : BaseEntityUpdateController<PartnerOrganisationRiskMitigationActionUpdate>
    {
        public PartnerOrganisationRiskMitigationActionUpdatesController(ILogger<PartnerOrganisationRiskMitigationActionUpdatesController> logger, IEntityUpdateService<PartnerOrganisationRiskMitigationActionUpdate> service) : base(logger, service) { }

        // GET: odata/PartnerOrganisationRiskMitigationActionUpdates(5)/PartnerOrganisationRiskMitigationAction
        [EnableQuery]
        public SingleResult<PartnerOrganisationRiskMitigationAction> GetPartnerOrganisationRiskMitigationAction([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.PartnerOrganisationRiskMitigationAction));
        }

        // GET: odata/PartnerOrganisationRiskMitigationActionUpdates(5)/UpdateUser
        [EnableQuery]
        public SingleResult<User> GetUpdateUser([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.UpdateUser));
        }
    }
}
