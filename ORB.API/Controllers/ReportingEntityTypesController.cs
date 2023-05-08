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
    public class ReportingEntityTypesController : BaseEntityController<CustomReportingEntityType>
    {
        public ReportingEntityTypesController(ILogger<ReportingEntityTypesController> logger, IEntityService<CustomReportingEntityType> service) : base(logger, service) { }
    }
}
