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
    public class CorporateRiskMitigationActionsController : BaseEntityController<CorporateRiskMitigationAction>
    {
        public CorporateRiskMitigationActionsController(ILogger<CorporateRiskMitigationActionsController> logger, IEntityService<CorporateRiskMitigationAction> service) : base(logger, service) { }

        #region Navigation property methods

        // GET: odata/CorporateRiskMitigationActions(5)/RiskRiskMitigationActions
        [EnableQuery]
        public IQueryable<CorporateRiskRiskMitigationAction> GetRiskRiskMitigationActions([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.CorporateRiskRiskMitigationActions);
        }

        // GET: odata/CorporateRiskMitigationActions(5)/Risk
        [EnableQuery]
        public SingleResult<CorporateRisk> GetRisk([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.Risk));
        }

        // GET: odata/CorporateRiskMitigationActions(5)/OwnerUser
        [EnableQuery]
        public SingleResult<User> GetOwnerUser([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.OwnerUser));
        }

        // GET: odata/CorporateRiskMitigationActions(5)/RiskMitigationActionUpdates
        [EnableQuery]
        public IQueryable<RiskMitigationActionUpdate> GetRiskMitigationActionUpdates([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.RiskMitigationActionUpdates);
        }

        #endregion
    }
}
