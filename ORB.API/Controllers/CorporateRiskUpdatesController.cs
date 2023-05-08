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
    public class CorporateRiskUpdatesController : BaseEntityUpdateController<CorporateRiskUpdate>
    {
        public CorporateRiskUpdatesController(ILogger<CorporateRiskUpdatesController> logger, IEntityUpdateService<CorporateRiskUpdate> service) : base(logger, service) { }

        // GET: odata/CorporateRiskUpdates(5)/CorporateRisk
        [EnableQuery]
        public SingleResult<CorporateRisk> GetCorporateRisk([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.Risk));
        }

        // GET: odata/CorporateRiskUpdates(5)/UpdateUser
        [EnableQuery]
        public SingleResult<User> GetUpdateUser([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.UpdateUser));
        }

        // GET: odata/CorporateRiskUpdates(5)/RiskImpactLevel
        [EnableQuery]
        public SingleResult<RiskImpactLevel> GetRiskImpactLevel([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.RiskImpactLevel));
        }

        // GET: odata/CorporateRiskUpdates(5)/RiskProbability
        [EnableQuery]
        public SingleResult<RiskProbability> GetRiskProbability([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.RiskProbability));
        }
    }
}
