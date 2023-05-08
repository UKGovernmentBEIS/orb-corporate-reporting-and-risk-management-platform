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
    public class AttributeTypesController : BaseEntityController<AttributeType>
    {
        public AttributeTypesController(ILogger<AttributeTypesController> logger, IEntityService<AttributeType> context) : base(logger, context) { }

        // GET: odata/AttributeTypes(5)/Attributes
        [EnableQuery]
        public IQueryable<ORB.Core.Models.Attribute> GetAttributes([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.Attributes);
        }
    }
}
