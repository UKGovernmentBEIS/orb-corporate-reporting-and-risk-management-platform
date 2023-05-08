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
    public class CorporateRiskMitigationActionUpdatesController : BaseEntityUpdateController<CorporateRiskMitigationActionUpdate>
    {
        public CorporateRiskMitigationActionUpdatesController(ILogger<CorporateRiskMitigationActionUpdatesController> logger, IEntityUpdateService<CorporateRiskMitigationActionUpdate> service) : base(logger, service) { }

        // GET: odata/CorporateRiskMitigationActionUpdates(5)/CorporateRiskMitigationAction
        [EnableQuery]
        public SingleResult<CorporateRiskMitigationAction> GetCorporateRiskMitigationAction([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.RiskMitigationAction));
        }

        // GET: odata/CorporateRiskMitigationActionUpdates(5)/UpdateUser
        [EnableQuery]
        public SingleResult<User> GetUpdateUser([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.UpdateUser));
        }
    }
}
