using FluentValidation;
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
    public abstract class BaseEntityUpdateController<T> : BaseController<T, IEntityUpdateService<T>> where T : EntityUpdate
    {
        protected BaseEntityUpdateController(ILogger<BaseEntityUpdateController<T>> logger, IEntityUpdateService<T> service) : base(logger, service) { }

        // POST: odata/Entities
        public async Task<IActionResult> Post([FromBody] T entity)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            
            try
            {
                var addedEntity = await _service.Add(entity);
                if (addedEntity == null)
                {
                    return Unauthorized();
                }

                return Created(entity);
            }
            catch (ValidationException ex)
            {
                return BadRequest(ex.Message);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error adding entity update");
                throw;
            }
        }
    }
}
