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
    public class RiskAppetitesController : BaseEntityController<RiskAppetite>
    {
        public RiskAppetitesController(ILogger<RiskAppetitesController> logger, IEntityService<RiskAppetite> service) : base(logger, service) { }

        // GET: odata/RiskAppetites(5)/CorporateRisks
        [EnableQuery]
        public IQueryable<CorporateRisk> GetCorporateRisks([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.CorporateRisks);
        }

        // GET: odata/RiskAppetites(5)/FinancialRisks
        [EnableQuery]
        public IQueryable<FinancialRisk> GetFinancialRisks([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.FinancialRisks);
        }
    }
}
