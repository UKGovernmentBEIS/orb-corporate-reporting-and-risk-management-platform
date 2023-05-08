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
    public class CorporateRiskRiskMitigationActionsController : BaseEntityController<CorporateRiskRiskMitigationAction>
    {
        public CorporateRiskRiskMitigationActionsController(
            ILogger<CorporateRiskRiskMitigationActionsController> logger,
            IEntityService<CorporateRiskRiskMitigationAction> service) : base(logger, service) { }
    }
}
