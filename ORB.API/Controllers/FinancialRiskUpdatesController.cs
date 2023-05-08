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
    public class FinancialRiskUpdatesController : BaseEntityUpdateController<FinancialRiskUpdate>
    {
        public FinancialRiskUpdatesController(ILogger<FinancialRiskUpdatesController> logger, IEntityUpdateService<FinancialRiskUpdate> service) : base(logger, service) { }

        // GET: odata/FinancialRiskUpdates(5)/FinancialRisk
        [EnableQuery]
        public SingleResult<FinancialRisk> GetFinancialRisk([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.FinancialRisk));
        }

        // GET: odata/FinancialRiskUpdates(5)/UpdateUser
        [EnableQuery]
        public SingleResult<User> GetUpdateUser([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.UpdateUser));
        }

        // GET: odata/FinancialRiskUpdates(5)/RiskImpactLevel
        [EnableQuery]
        public SingleResult<RiskImpactLevel> GetRiskImpactLevel([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.RiskImpactLevel));
        }

        // GET: odata/FinancialRiskUpdates(5)/RiskProbability
        [EnableQuery]
        public SingleResult<RiskProbability> GetRiskProbability([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.RiskProbability));
        }
    }
}
