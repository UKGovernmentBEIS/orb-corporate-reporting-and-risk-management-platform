using Microsoft.AspNet.OData;
using Microsoft.EntityFrameworkCore;
using ORB.Core;
using ORB.Core.Models;
using ORB.Core.Services;
using System;
using System.Linq;
using System.Threading.Tasks;

namespace ORB.Services
{
    public class UserPartnerOrganisationService : EntityWithEditorService<UserPartnerOrganisation>, IEntityService<UserPartnerOrganisation>
    {
        public UserPartnerOrganisationService(IUnitOfWork unitOfWork) : base(unitOfWork, unitOfWork.UserPartnerOrganisations) { }
    }
}
