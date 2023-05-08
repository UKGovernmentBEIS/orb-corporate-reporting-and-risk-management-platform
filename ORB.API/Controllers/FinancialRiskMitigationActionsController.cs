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
    public class FinancialRiskMitigationActionsController : BaseEntityController<FinancialRiskMitigationAction>
    {
        public FinancialRiskMitigationActionsController(ILogger<FinancialRiskMitigationActionsController> logger, IEntityService<FinancialRiskMitigationAction> service) : base(logger, service) { }

        #region Navigation property methods

        // GET: odata/FinancialRiskMitigationActions(5)/FinancialRisk
        [EnableQuery]
        public SingleResult<FinancialRisk> GetFinancialRisk([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.FinancialRisk));
        }

        // GET: odata/FinancialRiskMitigationActions(5)/RiskRiskMitigationActions
        [EnableQuery]
        public IQueryable<FinancialRiskRiskMitigationAction> GetRiskRiskMitigationActions([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.FinancialRiskRiskMitigationActions);
        }

        // GET: odata/FinancialRiskMitigationActions(5)/OwnerUser
        [EnableQuery]
        public SingleResult<User> GetOwnerUser([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.OwnerUser));
        }

        // GET: odata/FinancialRiskMitigationActions(5)/FinancialRiskMitigationActionUpdates
        [EnableQuery]
        public IQueryable<FinancialRiskMitigationActionUpdate> GetFinancialRiskMitigationActionUpdates([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.FinancialRiskMitigationActionUpdates);
        }

        #endregion
    }
}
