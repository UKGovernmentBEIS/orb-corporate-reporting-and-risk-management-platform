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
    public class ContributorsController : BaseEntityController<Contributor>
    {
        public ContributorsController(ILogger<ContributorsController> logger, IEntityService<Contributor> service) : base(logger, service) { }

        // GET: odata/Contributors(5)/Benefit
        [EnableQuery]
        public SingleResult<Benefit> GetBenefit([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.Benefit));
        }

        // GET: odata/Contributors(5)/Commitment
        [EnableQuery]
        public SingleResult<Commitment> GetCommitment([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.Commitment));
        }

        // GET: odata/Contributors(5)/Dependency
        [EnableQuery]
        public SingleResult<Dependency> GetDependency([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.Dependency));
        }

        // GET: odata/Contributors(5)/ContributorUser
        [EnableQuery]
        public SingleResult<User> GetContributorUser([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.ContributorUser));
        }
    }
}
