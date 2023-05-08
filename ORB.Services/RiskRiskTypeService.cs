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
    public class RiskRiskTypeService : EntityService<RiskRiskType>, IEntityService<RiskRiskType>
    {
        public RiskRiskTypeService(IUnitOfWork unitOfWork) : base(unitOfWork, unitOfWork.RiskRiskTypes) { }
    }
}
