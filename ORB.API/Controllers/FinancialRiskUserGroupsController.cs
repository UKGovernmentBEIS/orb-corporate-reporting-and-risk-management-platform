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
    public class FinancialRiskUserGroupsController : BaseEntityController<FinancialRiskUserGroup>
    {
        public FinancialRiskUserGroupsController(ILogger<FinancialRiskUserGroupsController> logger, IEntityService<FinancialRiskUserGroup> service) : base(logger, service) { }

        // GET: odata/FinancialRiskUserGroups(5)/Group
        [EnableQuery]
        public SingleResult<Group> GetGroup([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.Group));
        }

        // GET: odata/FinancialRiskUserGroups(5)/User
        [EnableQuery]
        public SingleResult<User> GetUser([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.User));
        }
    }
}
