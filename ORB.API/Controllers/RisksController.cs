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
    public class RisksController<TRisk, TAction, TUpdate> : BaseEntityController<TRisk>
    where TRisk : Risk
    where TAction : RiskMitigationAction
    where TUpdate : RiskUpdate
    {
        public RisksController(ILogger<RisksController<TRisk, TAction, TUpdate>> logger, IEntityService<TRisk> service) : base(logger, service) { }

        #region Navigation property methods

        // GET: odata/Risks(5)/Directorate
        [EnableQuery]
        public SingleResult<Directorate> GetDirectorate([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.Directorate));
        }

        // GET: odata/Risks(5)/RagOption
        [EnableQuery]
        public SingleResult<RagOption> GetRagOption([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.RagOption));
        }

        // GET: odata/Risks(5)/RiskRegister
        [EnableQuery]
        public SingleResult<RiskRegister> GetRiskRegister([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.RiskRegister));
        }

        // GET: odata/Risks(5)/RiskOwnerUser
        [EnableQuery]
        public SingleResult<User> GetUser([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.RiskOwnerUser));
        }

        // GET: odata/Risks(5)/SignOffs
        [EnableQuery]
        public IQueryable<SignOff> GetSignOffs([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.SignOffs);
        }

        #endregion
    }
}
