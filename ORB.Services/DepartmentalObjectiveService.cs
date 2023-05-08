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
    public class DepartmentalObjectiveService : EntityService<DepartmentalObjective>, IEntityService<DepartmentalObjective>
    {
        public DepartmentalObjectiveService(IUnitOfWork unitOfWork) : base(unitOfWork, unitOfWork.DepartmentalObjectives) { }
    }
}
