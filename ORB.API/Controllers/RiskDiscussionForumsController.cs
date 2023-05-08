﻿using Microsoft.AspNet.OData;
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
    public class RiskDiscussionForumsController : BaseEntityController<RiskDiscussionForum>
    {
        public RiskDiscussionForumsController(ILogger<RiskDiscussionForumsController> logger, IEntityService<RiskDiscussionForum> service) : base(logger, service) { }
    }
}
