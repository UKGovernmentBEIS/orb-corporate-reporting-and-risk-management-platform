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
    public class ThresholdService : EntityService<Threshold>, IEntityService<Threshold>
    {
        public ThresholdService(IUnitOfWork unitOfWork) : base(unitOfWork, unitOfWork.Thresholds) { }

        protected override void BeforeRemove(Threshold threshold)
        {
            _unitOfWork.ThresholdAppetites.RemoveRange(_unitOfWork.ThresholdAppetites.Entities.Where(ta => ta.ThresholdID == threshold.ID));
        }
    }
}
