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
    public class RiskRiskTypesController : BaseEntityController<RiskRiskType>
    {
        public RiskRiskTypesController(ILogger<RiskRiskTypesController> logger, IEntityService<RiskRiskType> service) : base(logger, service) { }
    }
}
