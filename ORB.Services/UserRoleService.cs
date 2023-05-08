using Microsoft.AspNet.OData;
using Microsoft.EntityFrameworkCore;
using ORB.Core;
using ORB.Core.Models;
using ORB.Core.Services;
using ORB.Services.Validations;
using System;
using System.Linq;
using System.Threading.Tasks;

namespace ORB.Services
{
    public class UserRoleService : EntityWithEditorService<UserRole>, IEntityService<UserRole>
    {
        public UserRoleService(IUnitOfWork unitOfWork) : base(unitOfWork, unitOfWork.UserRoles, new UserRoleValidator(unitOfWork)) { }
    }
}
