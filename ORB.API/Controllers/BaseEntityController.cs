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
    public abstract class BaseEntityController<T> : BaseController<T, IEntityService<T>> where T : ObjectWithId
    {
        protected BaseEntityController(ILogger<BaseEntityController<T>> logger, IEntityService<T> service) : base(logger, service) { }

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
                _logger.LogError(ex, "Error adding entity");
                throw;
            }
        }

        // PATCH: odata/Entities(5)
        [AcceptVerbs("PATCH")]
        public async Task<IActionResult> Patch([FromODataUri] int key, [FromBody] Delta<T> patch)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            try
            {
                var entity = await _service.Edit(key, patch);

                if (entity == null)
                {
                    return NotFound();
                }

                return Updated(entity);
            }
            catch (ValidationException ex)
            {
                return BadRequest(ex);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error editing entity");
                throw;
            }
        }

        // DELETE: odata/Entities(5)
        [AcceptVerbs("DELETE")]
        public async Task<IActionResult> Delete([FromODataUri] int key)
        {
            try
            {
                var entity = _service.Find(key).SingleOrDefault();
                if (entity == null)
                {
                    return NotFound();
                }

                var deleteEntity = await _service.Remove(entity);
                if (deleteEntity == null)
                {
                    return Unauthorized();
                }

                return new NoContentResult();
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error deleting entity");
                throw;
            }
        }
    }
}
