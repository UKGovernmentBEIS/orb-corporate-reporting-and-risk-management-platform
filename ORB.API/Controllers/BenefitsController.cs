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
    public class BenefitsController : BaseEntityController<Benefit>
    {
        private readonly IBenefitService _benefitService;

        public BenefitsController(ILogger<BenefitsController> logger, IBenefitService service) : base(logger, service) {
            _benefitService = service;
        }

        // GET: odata/Benefits/GetBenefitsDueInPeriod(ProjectId=2,Period=1)
        [EnableQuery]
        [ODataRoute("Benefits/GetBenefitsDueInPeriod(ProjectId={projectId},Period={period})")]
        public ICollection<Benefit> GetBenefitsDueInPeriod([FromODataUri] int projectId, [FromODataUri] byte period)
        {
            return _benefitService.BenefitsDueInProjectPeriod(projectId, period == (byte)Period.Previous ? Period.Previous : Period.Current);
        }

        #region Navigation property methods

        // GET: odata/Benefits(5)/BenefitType
        [EnableQuery]
        public SingleResult<BenefitType> GetBenefitType([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.BenefitType));
        }

        // GET: odata/Benefits(5)/Project
        [EnableQuery]
        public SingleResult<Project> GetDirectorate([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.Project));
        }

        // GET: odata/Benefits(5)/RagOption
        [EnableQuery]
        public SingleResult<RagOption> GetRagOption([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.RagOption));
        }

        // GET: odata/Benefits(5)/LeadUser
        [EnableQuery]
        public SingleResult<User> GetLeadUser([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.LeadUser));
        }

        // GET: odata/Benefits(5)/BenefitUpdates
        [EnableQuery]
        public IQueryable<BenefitUpdate> GetBenefitUpdates([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.BenefitUpdates);
        }

        // GET: odata/Benefits(5)/Contributors
        [EnableQuery]
        public IQueryable<Contributor> GetContributors([FromODataUri] int key)
        {
            return _service.Entities.Where(m => m.ID == key).SelectMany(m => m.Contributors);
        }

        #endregion
    }
}
