using Microsoft.AspNet.OData;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Attribute = ORB.Core.Models.Attribute;
using ORB.Core.Models;
using ORB.Core.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ORB.API.Controllers
{
    [Authorize]
    public class AttributesController : BaseEntityController<Attribute>
    {
        public AttributesController(ILogger<AttributesController> logger, IEntityService<Attribute> context) : base(logger, context) { }

        // GET: odata/Attributes(5)/AttributeType
        [EnableQuery]
        public SingleResult<AttributeType> GetAttributeType([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.AttributeType));
        }

        // GET: odata/Attributes(5)/Benefit
        [EnableQuery]
        public SingleResult<Benefit> GetBenefit([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.Benefit));
        }

        // GET: odata/Attributes(5)/Commitment
        [EnableQuery]
        public SingleResult<Commitment> GetCommitment([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.Commitment));
        }

        // GET: odata/Attributes(5)/Directorate
        [EnableQuery]
        public SingleResult<Directorate> GetDirectorate([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(a => a.ID == key).Select(a => a.Directorate));
        }

        // GET: odata/Attributes(5)/KeyWorkArea
        [EnableQuery]
        public SingleResult<KeyWorkArea> GetKeyWorkArea([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.KeyWorkArea));
        }

        // GET: odata/Attributes(5)/Metric
        [EnableQuery]
        public SingleResult<Metric> GetMetric([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.Metric));
        }

        // GET: odata/Attributes(5)/Project
        [EnableQuery]
        public SingleResult<Project> GetProject([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(a => a.ID == key).Select(a => a.Project));
        }

        // GET: odata/Attributes(5)/WorkStream
        [EnableQuery]
        public SingleResult<WorkStream> GetWorkStream([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.WorkStream));
        }
    }
}
