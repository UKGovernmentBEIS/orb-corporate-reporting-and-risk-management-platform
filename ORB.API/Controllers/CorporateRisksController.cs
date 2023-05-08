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
    public class CorporateRisksController : BaseEntityController<CorporateRisk>
    {
        public CorporateRisksController(ILogger<CorporateRisksController> logger, IEntityService<CorporateRisk> service) : base(logger, service) { }

        #region Navigation property methods

        // GET: odata/CorporateRisks(5)/RiskMitigationActions
        [EnableQuery]
        public IQueryable<CorporateRiskMitigationAction> GetRiskMitigationActions([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.RiskMitigationActions);
        }

        // GET: odata/CorporateRisks(5)/RiskRiskMitigationActions
        [EnableQuery]
        public IQueryable<CorporateRiskRiskMitigationAction> GetRiskRiskMitigationActions([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.CorporateRiskRiskMitigationActions);
        }

        // GET: odata/CorporateRisks(5)/RiskUpdates
        [EnableQuery]
        public IQueryable<CorporateRiskUpdate> GetRiskUpdates([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.RiskUpdates);
        }

        // GET: odata/CorporateRisks(5)/ChildRisks
        [EnableQuery]
        public IQueryable<CorporateRisk> GetChildRisks([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.ChildRisks);
        }

        // GET: odata/CorporateRisks(5)/SignOffs
        [EnableQuery]
        public IQueryable<SignOff> GetSignOffs([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.SignOffs);
        }

        #endregion
    }
}
