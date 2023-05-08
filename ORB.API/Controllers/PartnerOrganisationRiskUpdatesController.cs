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
    public class PartnerOrganisationRiskUpdatesController : BaseEntityUpdateController<PartnerOrganisationRiskUpdate>
    {
        public PartnerOrganisationRiskUpdatesController(ILogger<PartnerOrganisationRiskUpdatesController> logger, IEntityUpdateService<PartnerOrganisationRiskUpdate> service) : base(logger, service) { }

        // GET: odata/PartnerOrganisationRiskUpdates(5)/PartnerOrganisationRisk
        [EnableQuery]
        public SingleResult<PartnerOrganisationRisk> GetRisk([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.PartnerOrganisationRisk));
        }

        // GET: odata/PartnerOrganisationRiskUpdates(5)/UpdateUser
        [EnableQuery]
        public SingleResult<User> GetUpdateUser([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.UpdateUser));
        }

        // GET: odata/PartnerOrganisationRiskUpdates(5)/RiskImpactLevel
        [EnableQuery]
        public SingleResult<RiskImpactLevel> GetRiskImpactLevel([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.RiskImpactLevel));
        }

        // GET: odata/PartnerOrganisationRiskUpdates(5)/RiskProbability
        [EnableQuery]
        public SingleResult<RiskProbability> GetRiskProbability([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.RiskProbability));
        }
    }
}
