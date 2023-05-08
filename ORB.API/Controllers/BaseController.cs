using Microsoft.AspNet.OData;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using ORB.Core;
using ORB.Core.Models;
using ORB.Core.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ORB.API.Controllers
{
    [Authorize]
    public abstract class BaseController<T, S> : ODataController where T : ObjectWithId where S : IEntityReadService<T>
    {
        protected readonly S _service;
        protected readonly ILogger<BaseController<T, S>> _logger;

        protected BaseController(ILogger<BaseController<T, S>> logger, S service)
        {
            _logger = logger;
            _service = service;
        }

        // GET: odata/Entities
        [EnableQuery(MaxExpansionDepth = 3)]
        public ActionResult<IQueryable<T>> Get()
        {
            try
            {
                return Ok(_service.Entities);
            }
            catch (AuthorizationException ex)
            {
                return Unauthorized(ex.Message);
            }
        }

        // GET: odata/Entities(5)
        [EnableQuery(MaxExpansionDepth = 3)]
        public ActionResult<SingleResult<T>> Get(int key)
        {
            try
            {
                return SingleResult.Create<T>(_service.Find(key));
            }
            catch (AuthorizationException ex)
            {
                return Unauthorized(ex.Message);
            }
        }
    }
}
