using ORB.Core;
using ORB.Core.Models;
using ORB.Core.Services;
using ORB.Services.Validations;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Threading.Tasks;

namespace ORB.Services
{
    public class CustomReportingEntityTypeService : EntityService<CustomReportingEntityType>, IEntityService<CustomReportingEntityType>
    {
        public CustomReportingEntityTypeService(IUnitOfWork unitOfWork) : base(unitOfWork, unitOfWork.ReportingEntityTypes, new CustomReportingEntityTypeValidator()) { }
    }
}
