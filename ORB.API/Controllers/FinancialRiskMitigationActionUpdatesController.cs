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
    public class FinancialRiskMitigationActionUpdatesController : BaseEntityUpdateController<FinancialRiskMitigationActionUpdate>
    {
        public FinancialRiskMitigationActionUpdatesController(ILogger<FinancialRiskMitigationActionUpdatesController> logger, IEntityUpdateService<FinancialRiskMitigationActionUpdate> service) : base(logger, service) { }

        // GET: odata/FinancialRiskMitigationActionUpdates(5)/FinancialRiskMitigationAction
        [EnableQuery]
        public SingleResult<FinancialRiskMitigationAction> GetFinancialRiskMitigationAction([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.FinancialRiskMitigationAction));
        }

        // GET: odata/FinancialRiskMitigationActionUpdates(5)/UpdateUser
        [EnableQuery]
        public SingleResult<User> GetUpdateUser([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.UpdateUser));
        }
    }
}
