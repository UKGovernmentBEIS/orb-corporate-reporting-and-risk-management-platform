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
    public class FinancialRisksController : RisksController<FinancialRisk, FinancialRiskMitigationAction, FinancialRiskUpdate>
    {
        public FinancialRisksController(ILogger<FinancialRisksController> logger, IEntityService<FinancialRisk> service) : base(logger, service) { }

        #region Navigation property methods

        // GET: odata/FinancialRisks(5)/ChildRisks
        [EnableQuery]
        public IQueryable<FinancialRisk> GetChildRisks([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.ChildRisks);
        }

        // GET: odata/FinancialRisks(5)/FinancialRiskMitigationActions
        [EnableQuery]
        public IQueryable<FinancialRiskMitigationAction> GetFinancialRiskMitigationActions([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.FinancialRiskMitigationActions);
        }

        // GET: odata/FinancialRisks(5)/RiskRiskMitigationActions
        [EnableQuery]
        public IQueryable<FinancialRiskRiskMitigationAction> GetRiskRiskMitigationActions([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.FinancialRiskRiskMitigationActions);
        }

        // GET: odata/FinancialRisks(5)/FinancialRiskUpdates
        [EnableQuery]
        public IQueryable<FinancialRiskUpdate> GetFinancialRiskUpdates([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.FinancialRiskUpdates);
        }

        #endregion
    }
}
