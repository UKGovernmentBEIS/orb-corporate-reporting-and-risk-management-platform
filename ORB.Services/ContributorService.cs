using FluentValidation;
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
    public class ContributorService : EntityWithEditorService<Contributor>, IEntityService<Contributor>
    {
        public ContributorService(IUnitOfWork unitOfWork) : base(unitOfWork, unitOfWork.Contributors) { }
    }
}
