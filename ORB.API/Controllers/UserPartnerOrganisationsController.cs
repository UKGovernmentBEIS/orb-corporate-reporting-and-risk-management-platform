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
    public class UserPartnerOrganisationsController : BaseEntityController<UserPartnerOrganisation>
    {
        public UserPartnerOrganisationsController(ILogger<UserPartnerOrganisationsController> logger, IEntityService<UserPartnerOrganisation> service) : base(logger, service) { }

        // GET: odata/UserPartnerOrganisations(5)/PartnerOrganisation
        [EnableQuery]
        public SingleResult<PartnerOrganisation> GetPartnerOrganisation([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.PartnerOrganisation));
        }

        // GET: odata/UserPartnerOrganisations(5)/User
        [EnableQuery]
        public SingleResult<User> GetUser([FromODataUri] int key)
        {
            return SingleResult.Create(_service.Entities.Where(m => m.ID == key).Select(m => m.User));
        }
    }
}
